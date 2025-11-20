import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../models/resource_point.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final resourceRepositoryProvider = Provider<ResourceRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return ResourceRepository(SupabaseService.client, isarService);
});

class ResourceRepository {
  final SupabaseClient _supabase;
  final IsarService _isarService;

  ResourceRepository(this._supabase, this._isarService);

  // Fetch resources from Supabase and cache them locally
  Future<List<ResourcePoint>> getResources() async {
    try {
      const selectColumns = [
        'id',
        'title',
        'description',
        'resource_type',
        'category',
        'address',
        'geohash',
        'is_active',
        'expires_at',
        'contact_masked_phone',
        'tags',
        'created_by',
        'created_at',
        'updated_at',
        'lat: ST_Y(location::geometry)',
        'lng: ST_X(location::geometry)',
      ];
      // 1. Try to fetch from Supabase (Network First)
      final data = await _supabase
          .from('resource_points')
          .select(selectColumns.join(','))
          .eq('is_active', true) // Only fetch active resources
          .timeout(const Duration(seconds: 12));

      final resources = (data as List)
          .map((json) => ResourcePoint.fromSupabase(json as Map<String, dynamic>))
          .toList();
      final resourcesWithIds = resources
          .map((r) => r.copyWith(isarId: fastHash(r.id)))
          .toList();

      if (kIsWeb) return resourcesWithIds;

      // 2. Cache to Isar
      final isar = await _isarService.db;
      await isar.writeTxn((isar) async {
        await isar.resourcePoints.putAll(resourcesWithIds);
      });

      return resourcesWithIds;
    } catch (e) {
      if (kIsWeb) {
        debugPrint('Resource fetch failed on web: $e');
        rethrow;
      }

      // 3. Fallback to Isar (Offline)
      final isar = await _isarService.db;
      return await isar.resourcePoints.where().findAll();
    }
  }

  // Create a new resource point
  Future<void> createResourcePoint(ResourcePoint resource) async {
    final payload = resource
        .copyWith(createdBy: _supabase.auth.currentUser?.id ?? resource.createdBy)
        .toSupabasePayload();

    await _supabase.from('resource_points').insert(payload);

    // 2. Save to local cache (skip on web where Isar isn't available)
    if (!kIsWeb) {
      final isar = await _isarService.db;
      final cached = resource.copyWith(isarId: fastHash(resource.id));
      await isar.writeTxn((isar) async {
        await isar.resourcePoints.put(cached);
      });
    }
  }
}
