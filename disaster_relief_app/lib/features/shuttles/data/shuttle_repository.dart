import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../models/shuttle_model.dart';
import '../../../models/resource_point.dart'; // for fastHash
import '../../../core/utils/geohash.dart';

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
        'origin',
        'destination',
      ];
      final data = await _supabase
          .from('shuttles')
          .select(selectColumns.join(','))
          .timeout(const Duration(seconds: 12));
      final shuttles = (data as List)
          .map(
            (json) => ShuttleModel.fromSupabase(json as Map<String, dynamic>),
          )
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

  Future<ShuttleModel> createShuttle({
    required String title,
    String? description,
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    required DateTime departAt,
    DateTime? arriveAt,
    required int seatsTotal,
    double? costPerSeat,
    String? originAddress,
    String? destinationAddress,
    String costType = 'free',
    String vehicleType = 'other',
    String? vehiclePlate,
    String? contactName,
    String? contactPhoneMasked,
    bool isPriority = false,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('User not logged in');
    }

    final payload = {
      'title': title,
      'description': description,
      'origin': 'POINT($originLng $originLat)',
      'destination': 'POINT($destinationLng $destinationLat)',
      'origin_address': originAddress,
      'destination_address': destinationAddress,
      'depart_at': departAt.toIso8601String(),
      'arrive_at': arriveAt?.toIso8601String(),
      'seats_total': seatsTotal,
      'cost_type': costType,
      'fare_per_person': costPerSeat,
      'vehicle': {
        'type': vehicleType,
        if (vehiclePlate != null && vehiclePlate.isNotEmpty)
          'plate': vehiclePlate,
      },
      'contact_name': contactName,
      'contact_phone_masked': contactPhoneMasked,
      'is_priority': isPriority,
      'created_by': userId,
      'origin_geohash': encodeGeohash(originLat, originLng),
      'destination_geohash': encodeGeohash(destinationLat, destinationLng),
    }..removeWhere((key, value) => value == null);

    final Map<String, dynamic> result = await _supabase
        .from('shuttles')
        .insert(payload)
        .select()
        .single();

    final shuttle = ShuttleModel.fromSupabase(result);

    // Ensure creator is enrolled as driver by default
    await joinShuttle(shuttle.id, role: 'driver');
    return shuttle;
  }

  Future<ShuttleModel> updateShuttle({
    required String shuttleId,
    String? title,
    String? description,
    double? originLat,
    double? originLng,
    double? destinationLat,
    double? destinationLng,
    DateTime? departAt,
    DateTime? arriveAt,
    int? seatsTotal,
    double? costPerSeat,
    String? originAddress,
    String? destinationAddress,
    String? costType,
    String? vehicleType,
    String? vehiclePlate,
    String? contactName,
    String? contactPhoneMasked,
    bool? isPriority,
  }) async {
    final updates = <String, dynamic>{
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (originLat != null && originLng != null)
        'origin': 'POINT($originLng $originLat)',
      if (destinationLat != null && destinationLng != null)
        'destination': 'POINT($destinationLng $destinationLat)',
      if (originAddress != null) 'origin_address': originAddress,
      if (destinationAddress != null) 'destination_address': destinationAddress,
      if (departAt != null) 'depart_at': departAt.toIso8601String(),
      if (arriveAt != null) 'arrive_at': arriveAt.toIso8601String(),
      if (seatsTotal != null) 'seats_total': seatsTotal,
      if (costType != null) 'cost_type': costType,
      if (costPerSeat != null) 'fare_per_person': costPerSeat,
      if (vehicleType != null || vehiclePlate != null)
        'vehicle': {
          if (vehicleType != null) 'type': vehicleType,
          if (vehiclePlate != null && vehiclePlate.isNotEmpty)
            'plate': vehiclePlate,
        },
      if (contactName != null) 'contact_name': contactName,
      if (contactPhoneMasked != null)
        'contact_phone_masked': contactPhoneMasked,
      if (isPriority != null) 'is_priority': isPriority,
      if (originLat != null && originLng != null)
        'origin_geohash': encodeGeohash(originLat, originLng),
      if (destinationLat != null && destinationLng != null)
        'destination_geohash': encodeGeohash(destinationLat, destinationLng),
    };

    if (updates.isEmpty) {
      throw Exception('No fields provided to update shuttle');
    }

    final Map<String, dynamic> result = await _supabase
        .from('shuttles')
        .update(updates)
        .eq('id', shuttleId)
        .select()
        .single();

    return ShuttleModel.fromSupabase(result);
  }

  Future<void> joinShuttle(
    String shuttleId, {
    String role = 'passenger',
    bool isVisible = true,
  }) async {
    await _supabase.rpc(
      'join_shuttle',
      params: {
        'p_shuttle_id': shuttleId,
        'p_role': role,
        'p_is_visible': isVisible,
      },
    );

    // Trigger a refresh or update local count optimistically
  }

  Future<void> leaveShuttle(String shuttleId) async {
    await _supabase.rpc('leave_shuttle', params: {'p_shuttle_id': shuttleId});
  }

  Future<bool> isUserParticipant(String shuttleId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final rows =
        await _supabase
                .from('shuttle_participants')
                .select('user_id')
                .eq('shuttle_id', shuttleId)
                .eq('user_id', userId)
                .limit(1)
            as List;
    return rows.isNotEmpty;
  }

  Future<Set<String>> getJoinedShuttleIds() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return {};

    final rows =
        await _supabase
                .from('shuttle_participants')
                .select('shuttle_id')
                .eq('user_id', userId)
            as List<dynamic>;

    return rows
        .map((row) => (row as Map<String, dynamic>)['shuttle_id'] as String)
        .toSet();
  }

  Future<void> completeShuttle(String shuttleId) async {
    await _supabase
        .from('shuttles')
        .update({'status': 'done'})
        .eq('id', shuttleId);
  }

  Future<void> deleteShuttle(String shuttleId) async {
    await _supabase.from('shuttles').delete().eq('id', shuttleId);
  }

  Stream<List<Map<String, dynamic>>> subscribeToShuttleUpdates() {
    return _supabase
        .from('shuttles')
        .stream(primaryKey: ['id'])
        .map((data) => data);
  }
}
