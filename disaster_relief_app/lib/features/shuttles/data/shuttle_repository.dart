import 'dart:async';
import 'dart:math' as math;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../services/offline_queue_service.dart';
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
        'title',
        'description',
        'status',
        'cost_type',
        'priority',
        'vehicle_info',
        'purposes',
        'route',
        'schedule',
        'capacity',
        'contact_name',
        'contact_phone_masked',
        'creator_id',
        'participants_snapshot',
        'created_at',
        'updated_at',
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

    final List<ConnectivityResult> connectivityStatus = await Connectivity()
        .checkConnectivity();
    final shuttleId = const Uuid().v4();

    final localizedTitle = {'zh-TW': title, 'en-US': title};
    final localizedDesc = description != null
        ? {
            'zh-TW': description,
            'en-US': description,
          }
        : null;

    final payload = {
      'id': shuttleId,
      'title': localizedTitle,
      if (localizedDesc != null) 'description': localizedDesc,
      'vehicle_info': {
        'type': vehicleType,
        if (vehiclePlate != null && vehiclePlate.isNotEmpty)
          'plate': vehiclePlate,
      },
      'purposes': <String>[],
      'route': {
        'origin': {
          'lat': originLat,
          'lng': originLng,
          if (originAddress != null) 'address': originAddress,
        },
        'destination': {
          'lat': destinationLat,
          'lng': destinationLng,
          if (destinationAddress != null) 'address': destinationAddress,
        },
      },
      'schedule': {
        'depart_at': departAt.toIso8601String(),
        if (arriveAt != null) 'arrive_at': arriveAt.toIso8601String(),
      },
      'capacity': {
        'total': seatsTotal,
        'taken': 0,
        'remaining': seatsTotal,
      },
      'cost_type': costType,
      'contact_name': contactName,
      'contact_phone_masked': contactPhoneMasked,
      'priority': isPriority,
      'creator_id': userId,
      'status': 'open',
    }..removeWhere((key, value) => value == null);

    final bool isOffline = connectivityStatus.contains(ConnectivityResult.none);

    if (isOffline) {
      await OfflineQueueService.instance.enqueue(
        table: 'shuttles',
        payload: payload,
      );
      final local = ShuttleModel.fromSupabase({
        ...payload,
        'capacity': {'total': seatsTotal, 'taken': 0, 'remaining': seatsTotal},
        'status': 'open',
      });
      return local.copyWith(isarId: fastHash(local.id));
    }

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
    int? seatsTaken,
  }) async {
    final updates = <String, dynamic>{};

    if (title != null) {
      updates['title'] = {'zh-TW': title, 'en-US': title};
    }
    if (description != null) {
      updates['description'] = {
        'zh-TW': description,
        'en-US': description,
      };
    }
    final shouldUpdateRoute =
        originLat != null && originLng != null && destinationLat != null && destinationLng != null;
    if (shouldUpdateRoute) {
      updates['route'] = {
        'origin': {
          'lat': originLat,
          'lng': originLng,
          if (originAddress != null) 'address': originAddress,
        },
        'destination': {
          'lat': destinationLat,
          'lng': destinationLng,
          if (destinationAddress != null) 'address': destinationAddress,
        },
      };
    } else {
      if (originAddress != null || destinationAddress != null) {
        // Addresses alone require coordinates to satisfy constraint; skip to avoid invalid row.
        debugPrint(
          'Skipped address-only shuttle route update because coordinates were not provided.',
        );
      }
    }

    if (departAt != null || arriveAt != null) {
      final scheduleUpdate = <String, dynamic>{};
      if (departAt != null) {
        scheduleUpdate['depart_at'] = departAt.toIso8601String();
      }
      if (arriveAt != null) {
        scheduleUpdate['arrive_at'] = arriveAt.toIso8601String();
      }
      // Only send schedule if we have depart_at per constraint.
      if (scheduleUpdate.containsKey('depart_at')) {
        updates['schedule'] = scheduleUpdate;
      }
    }

    if (seatsTotal != null) {
      final currentCapacity = await _supabase
          .from('shuttles')
          .select('capacity')
          .eq('id', shuttleId)
          .single();
      final currentTaken =
          (currentCapacity['capacity']?['taken'] as num?)?.toInt() ?? seatsTaken ?? 0;
      final normalizedTaken = math.min(currentTaken, seatsTotal);
      updates['capacity'] = {
        'total': seatsTotal,
        'taken': normalizedTaken,
        'remaining': math.max(seatsTotal - normalizedTaken, 0),
      };
    }

    if (costType != null) updates['cost_type'] = costType;
    if (vehicleType != null || vehiclePlate != null) {
      updates['vehicle_info'] = {
        if (vehicleType != null) 'type': vehicleType,
        if (vehiclePlate != null && vehiclePlate.isNotEmpty)
          'plate': vehiclePlate,
      };
    }
    if (contactName != null) updates['contact_name'] = contactName;
    if (contactPhoneMasked != null) {
      updates['contact_phone_masked'] = contactPhoneMasked;
    }
    if (isPriority != null) updates['priority'] = isPriority;

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
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('User not logged in');
    }

    // Check if user has already joined
    final alreadyJoined = await isUserParticipant(shuttleId);
    if (alreadyJoined) {
      debugPrint('User already joined shuttle $shuttleId');
      return; // Silently return, user is already in the shuttle
    }

    await _supabase.from('shuttle_participants').insert({
      'shuttle_id': shuttleId,
      'user_id': userId,
      'role': role,
      'is_visible': isVisible,
    });

    // Trigger a refresh or update local count optimistically
  }

  Future<void> leaveShuttle(String shuttleId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('User not logged in');
    }

    await _supabase
        .from('shuttle_participants')
        .delete()
        .eq('shuttle_id', shuttleId)
        .eq('user_id', userId);
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
