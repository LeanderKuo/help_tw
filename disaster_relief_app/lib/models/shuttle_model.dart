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
    required String title,
    String? description,
    @Default('Scheduled') String status, // Scheduled, En Route, Arrived, Cancelled
    @JsonKey(name: 'route_start_lat') double? routeStartLat,
    @JsonKey(name: 'route_start_lng') double? routeStartLng,
    @JsonKey(name: 'route_end_lat') double? routeEndLat,
    @JsonKey(name: 'route_end_lng') double? routeEndLng,
    @JsonKey(name: 'origin_address') String? originAddress,
    @JsonKey(name: 'destination_address') String? destinationAddress,
    @JsonKey(name: 'departure_time') DateTime? departureTime,
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
    @JsonKey(ignore: true) @Id() int? isarId,
  }) = _ShuttleModel;

  factory ShuttleModel.fromJson(Map<String, dynamic> json) =>
      _$ShuttleModelFromJson(json);

  /// Parse Supabase `shuttles` rows (geography + snake_case fields).
  factory ShuttleModel.fromSupabase(Map<String, dynamic> json) {
    return ShuttleModel(
      id: json['id'] as String,
      title: (json['title'] ?? '') as String,
      description: json['description'] as String?,
      status: (json['status'] as String?) ?? 'open',
      routeStartLat: _toDouble(
          json['origin_lat'] ?? json['route_start_lat']),
      routeStartLng: _toDouble(
          json['origin_lng'] ?? json['route_start_lng']),
      routeEndLat:
          _toDouble(json['destination_lat'] ?? json['route_end_lat']),
      routeEndLng:
          _toDouble(json['destination_lng'] ?? json['route_end_lng']),
      originAddress: json['origin_address'] as String?,
      destinationAddress: json['destination_address'] as String?,
      departureTime: _parseDate(json['depart_at'] ?? json['departure_time']),
      signupDeadline: _parseDate(json['signup_deadline']),
      costType: (json['cost_type'] as String?) ?? 'free',
      fareTotal: _toDouble(json['fare_total']),
      farePerPerson: _toDouble(json['fare_per_person']),
      capacity: (json['seats_total'] as num?)?.toInt() ??
          (json['capacity'] as num?)?.toInt() ??
          0,
      seatsTaken: (json['seats_taken'] as num?)?.toInt() ?? 0,
      driverId: json['driver_id'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  /// Build payload matching Supabase column names and types.
  Map<String, dynamic> toSupabasePayload({String? creatorId}) {
    final normalizedStatus = _normalizeShuttleStatus(status);
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': normalizedStatus,
      'origin': routeStartLat != null && routeStartLng != null
          ? 'POINT($routeStartLng $routeStartLat)'
          : null,
      'destination': routeEndLat != null && routeEndLng != null
          ? 'POINT($routeEndLng $routeEndLat)'
          : null,
      'origin_address': originAddress,
      'destination_address': destinationAddress,
      'depart_at': departureTime?.toIso8601String(),
      'signup_deadline': signupDeadline?.toIso8601String(),
      'cost_type': costType,
      'fare_total': fareTotal,
      'fare_per_person': farePerPerson,
      'seats_total': capacity,
      'driver_id': driverId,
      'created_by': creatorId ?? createdBy,
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
