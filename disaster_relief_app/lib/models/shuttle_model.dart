// ignore_for_file: invalid_annotation_target

import 'dart:math' as math;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'shuttle_model.freezed.dart';
part 'shuttle_model.g.dart';

@freezed
@Collection()
class ShuttleModel with _$ShuttleModel {
  const ShuttleModel._();

  const factory ShuttleModel({
    required String id,
    @JsonKey(name: 'display_id') String? displayId,
    required String title,
    String? description,
    @Default('open')
    String status, // open, in_progress, done, canceled
    @JsonKey(name: 'route_start_lat') double? routeStartLat,
    @JsonKey(name: 'route_start_lng') double? routeStartLng,
    @JsonKey(name: 'route_end_lat') double? routeEndLat,
    @JsonKey(name: 'route_end_lng') double? routeEndLng,
    @JsonKey(name: 'origin_address') String? originAddress,
    @JsonKey(name: 'destination_address') String? destinationAddress,
    @JsonKey(name: 'departure_time') DateTime? departureTime,
    @JsonKey(name: 'arrive_at') DateTime? arriveAt,
    @JsonKey(name: 'signup_deadline') DateTime? signupDeadline,
    @JsonKey(name: 'cost_type') @Default('free') String costType,
    @JsonKey(name: 'fare_total') double? fareTotal,
    @JsonKey(name: 'fare_per_person') double? farePerPerson,
    @Default(0) int capacity,
    @Default(0) @JsonKey(name: 'seats_taken') int seatsTaken,
    @JsonKey(name: 'driver_id') String? driverId,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'vehicle_info') Map<String, dynamic>? vehicle,
    @JsonKey(name: 'contact_name') String? contactName,
    @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
    @JsonKey(name: 'participants') @Default([]) List<String> participantIds,
    @JsonKey(name: 'is_priority') @Default(false) bool isPriority,
    @JsonKey(includeFromJson: false, includeToJson: false) @Id() int? isarId,
  }) = _ShuttleModel;

  factory ShuttleModel.fromJson(Map<String, dynamic> json) =>
      _$ShuttleModelFromJson(json);

  /// Parse Supabase `shuttles` rows (geography + snake_case fields).
  factory ShuttleModel.fromSupabase(Map<String, dynamic> json) {
    final route = json['route'];
    Map<String, dynamic>? origin;
    Map<String, dynamic>? destination;
    if (route is Map) {
      origin = route['origin'] as Map<String, dynamic>?;
      destination = route['destination'] as Map<String, dynamic>?;
    }

    double? startLat = _toDouble(origin?['lat']);
    double? startLng = _toDouble(origin?['lng']);
    double? endLat = _toDouble(destination?['lat']);
    double? endLng = _toDouble(destination?['lng']);

    final capacityJson = json['capacity'] as Map<String, dynamic>?;
    final seatsTotal = (capacityJson?['total'] as num?)?.toInt() ?? 0;
    final seatsTaken = (capacityJson?['taken'] as num?)?.toInt() ?? 0;

    final schedule = json['schedule'] as Map<String, dynamic>?;
    final departAt = schedule?['depart_at'] ?? json['depart_at'];
    final arriveAt = schedule?['arrive_at'] ?? json['arrive_at'];

    return ShuttleModel(
      id: json['id'] as String,
      title: _localizedText(json['title']),
      description: _localizedText(json['description']),
      status: (json['status'] as String?) ?? 'open',
      routeStartLat: startLat,
      routeStartLng: startLng,
      routeEndLat: endLat,
      routeEndLng: endLng,
      originAddress: origin?['address'] as String?,
      destinationAddress: destination?['address'] as String?,
      departureTime: _parseDate(departAt),
      arriveAt: _parseDate(arriveAt),
      signupDeadline: _parseDate(json['signup_deadline']),
      costType: (json['cost_type'] as String?) ?? 'free',
      fareTotal: _toDouble(json['fare_total']),
      farePerPerson: _toDouble(json['fare_per_person']),
      capacity: seatsTotal,
      seatsTaken: seatsTaken,
      driverId: json['driver_id'] as String?,
      createdBy: json['creator_id'] as String? ?? json['created_by'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      displayId: json['display_id'] as String?,
      vehicle: (json['vehicle_info'] ?? json['vehicle']) as Map<String, dynamic>?,
      contactName: json['contact_name'] as String?,
      contactPhoneMasked: json['contact_phone_masked'] as String?,
      participantIds: (json['participants_snapshot'] as List?)
              ?.whereType<String>()
              .toList() ??
          (json['participants'] as List?)?.whereType<String>().toList() ??
          const [],
      isPriority:
          (json['priority'] as bool?) ?? (json['is_priority'] as bool?) ?? false,
    );
  }

  /// Build payload matching Supabase column names and types.
  Map<String, dynamic> toSupabasePayload({String? creatorId}) {
    final normalizedStatus = _normalizeShuttleStatus(status);
    final startLat = routeStartLat;
    final startLng = routeStartLng;
    final endLat = routeEndLat;
    final endLng = routeEndLng;
    return {
      'id': id,
      'title': {'zh-TW': title, 'en-US': title},
      if (description != null)
        'description': {'zh-TW': description, 'en-US': description},
      'status': normalizedStatus,
      'route': startLat != null &&
              startLng != null &&
              endLat != null &&
              endLng != null
          ? {
              'origin': {
                'lat': startLat,
                'lng': startLng,
                if (originAddress != null) 'address': originAddress,
              },
              'destination': {
                'lat': endLat,
                'lng': endLng,
                if (destinationAddress != null) 'address': destinationAddress,
              },
            }
          : null,
      'schedule': departureTime != null
          ? {
              'depart_at': departureTime!.toIso8601String(),
              if (arriveAt != null) 'arrive_at': arriveAt!.toIso8601String(),
            }
          : null,
      'cost_type': costType,
      'capacity': {
        'total': capacity,
        'taken': seatsTaken,
        'remaining': math.max(capacity - seatsTaken, 0),
      },
      'driver_id': driverId,
      'creator_id': creatorId ?? createdBy,
      'vehicle_info': vehicle,
      'contact_name': contactName,
      'contact_phone_masked': contactPhoneMasked,
      'participants_snapshot':
          participantIds.isEmpty ? null : participantIds.toList(),
      'priority': isPriority,
    }..removeWhere((key, value) => value == null);
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  return DateTime.tryParse(value.toString());
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

String _normalizeShuttleStatus(String status) {
  final lower = status.toLowerCase().replaceAll(' ', '_');
  if (lower == 'arrived') return 'done';
  if (lower == 'en_route') return 'in_progress';
  if (lower == 'cancelled') return 'canceled';
  if (lower == 'scheduled') return 'open';
  return lower;
}

String _localizedText(dynamic payload) {
  if (payload == null) return '';
  if (payload is String) return payload;
  if (payload is Map) {
    final zh = payload['zh-TW'] ?? payload['zh_tw'];
    final en = payload['en-US'] ?? payload['en_us'];
    return (zh ?? en ?? '').toString();
  }
  return payload.toString();
}
