import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../models/shuttle_model.dart';

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
      final data = await _supabase.from('shuttles').select();
      final shuttles = (data as List)
          .map((json) => ShuttleModel.fromJson(json))
          .toList();
      
      // Cache
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.shuttleModels.putAll(shuttles);
      });

      return shuttles;
    } catch (e) {
      final isar = await _isarService.db;
      return await isar.shuttleModels.where().findAll();
    }
  }

  Future<void> joinShuttle(String shuttleId, String userId) async {
    await _supabase.from('shuttle_participants').insert({
      'shuttle_id': shuttleId,
      'user_id': userId,
      'status': 'Joined',
    });
    // Trigger a refresh or update local count optimistically
  }

  Stream<List<Map<String, dynamic>>> subscribeToShuttleUpdates() {
    return _supabase
        .from('shuttles')
        .stream(primaryKey: ['id'])
        .map((data) => data);
  }
}
