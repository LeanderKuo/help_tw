import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'resource_point.dart'; // For fastHash

part 'shuttle_model.freezed.dart';
part 'shuttle_model.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
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
    @JsonKey(name: 'departure_time') DateTime? departureTime,
    @Default(0) int capacity,
    @Default(0) @JsonKey(name: 'seats_taken') int seatsTaken,
    @JsonKey(name: 'driver_id') String? driverId,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ShuttleModel;

  factory ShuttleModel.fromJson(Map<String, dynamic> json) =>
      _$ShuttleModelFromJson(json);

  Id get isarId => fastHash(id);
}
