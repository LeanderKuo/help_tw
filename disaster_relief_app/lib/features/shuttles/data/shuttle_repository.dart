import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../models/shuttle_model.dart';
import '../../../models/resource_point.dart'; // for fastHash

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final shuttleRepositoryProvider = Provider<ShuttleRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return ShuttleRepository(SupabaseService.client, isarService);
});

class ShuttleRepository {
  final SupabaseClient _supabase;
  final IsarService _isarService;

  ShuttleRepository(this._supabase, this._isarService);

  Future<List<ShuttleModel>> getShuttles() async {
    try {
      const selectColumns = [
        'id',
        'display_id',
        'title',
        'description',
        'status',
        'cost_type',
        'fare_total',
        'fare_per_person',
        'seats_total',
        'seats_taken',
        'origin_address',
        'destination_address',
        'created_by',
        'depart_at',
        'arrive_at',
        'signup_deadline',
        'created_at',
        'updated_at',
        'origin_lat: ST_Y(origin::geometry)',
        'origin_lng: ST_X(origin::geometry)',
        'destination_lat: ST_Y(destination::geometry)',
        'destination_lng: ST_X(destination::geometry)',
      ];
      final data = await _supabase
          .from('shuttles')
          .select(selectColumns.join(','))
          .timeout(const Duration(seconds: 12));
      final shuttles = (data as List)
          .map((json) => ShuttleModel.fromSupabase(json as Map<String, dynamic>))
          .toList();
      final shuttlesWithIds = shuttles
          .map((s) => s.copyWith(isarId: fastHash(s.id)))
          .toList();

      if (kIsWeb) return shuttlesWithIds;

      // Cache
      final isar = await _isarService.db;
      await isar.writeTxn((isar) async {
        await isar.shuttleModels.putAll(shuttlesWithIds);
      });

      return shuttlesWithIds;
    } catch (e) {
      if (kIsWeb) {
        debugPrint('Shuttle fetch failed on web: $e');
        rethrow;
      }

      final isar = await _isarService.db;
      return await isar.shuttleModels.where().findAll();
    }
  }

  Future<void> joinShuttle(String shuttleId,
      {String role = 'passenger', bool isVisible = true}) async {
    await _supabase.rpc('join_shuttle', params: {
      'p_shuttle_id': shuttleId,
      'p_role': role,
      'p_is_visible': isVisible,
    });

    // Trigger a refresh or update local count optimistically
  }

  Future<void> leaveShuttle(String shuttleId) async {
    await _supabase.rpc('leave_shuttle', params: {
      'p_shuttle_id': shuttleId,
    });
  }

  Future<bool> isUserParticipant(String shuttleId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final rows = await _supabase
        .from('shuttle_participants')
        .select('user_id')
        .eq('shuttle_id', shuttleId)
        .eq('user_id', userId)
        .limit(1) as List;
    return rows.isNotEmpty;
  }

  Stream<List<Map<String, dynamic>>> subscribeToShuttleUpdates() {
    return _supabase
        .from('shuttles')
        .stream(primaryKey: ['id'])
        .map((data) => data);
  }
}
