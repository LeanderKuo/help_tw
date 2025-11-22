// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'drip_models.freezed.dart';
part 'drip_models.g.dart';

@freezed
class LocalizedText with _$LocalizedText {
  const factory LocalizedText({
    @JsonKey(name: 'zh-TW') required String zhTW,
    @JsonKey(name: 'en-US') required String enUS,
  }) = _LocalizedText;

  factory LocalizedText.fromJson(Map<String, dynamic> json) => _$LocalizedTextFromJson(json);
}

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    required double lat,
    required double lng,
    required String address,
    String? geohash,
  }) = _GeoLocation;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => _$GeoLocationFromJson(json);
}

@freezed
class MissionRequirements with _$MissionRequirements {
  const factory MissionRequirements({
    @Default(<String>[]) List<String> materials,
    @JsonKey(name: 'manpower_needed') @Default(0) int manpowerNeeded,
    @JsonKey(name: 'manpower_current') @Default(0) int manpowerCurrent,
  }) = _MissionRequirements;

  factory MissionRequirements.fromJson(Map<String, dynamic> json) => _$MissionRequirementsFromJson(json);
}

enum MissionStatus {
  @JsonValue('open')
  open,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('done')
  done,
  @JsonValue('canceled')
  canceled,
}

enum MissionType { rescue, medical, transport, clearing, other }

@freezed
class Mission with _$Mission {
  const factory Mission({
    required String id,
    required LocalizedText title,
    LocalizedText? description,
    @Default(<MissionType>[]) List<MissionType> types,
    @Default(MissionStatus.open) MissionStatus status,
    @Default(false) bool priority,
    @Default(MissionRequirements()) MissionRequirements requirements,
    required GeoLocation location,
    @JsonKey(name: 'contact_name') String? contactName,
    @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
    @JsonKey(name: 'creator_id') required String creatorId,
    @JsonKey(name: 'chat_room_id') String? chatRoomId,
    @JsonKey(name: 'participant_count') @Default(0) int participantCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
}

@freezed
class MissionParticipant with _$MissionParticipant {
  const factory MissionParticipant({
    @JsonKey(name: 'mission_id') required String missionId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'is_visible') @Default(true) bool isVisible,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
  }) = _MissionParticipant;

  factory MissionParticipant.fromJson(Map<String, dynamic> json) => _$MissionParticipantFromJson(json);
}

@freezed
class MissionMessage with _$MissionMessage {
  const factory MissionMessage({
    required String id,
    @JsonKey(name: 'mission_id') required String missionId,
    @JsonKey(name: 'author_id') required String authorId,
    required String content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _MissionMessage;

  factory MissionMessage.fromJson(Map<String, dynamic> json) => _$MissionMessageFromJson(json);
}

@freezed
class ShuttleVehicleInfo with _$ShuttleVehicleInfo {
  const factory ShuttleVehicleInfo({
    required String type,
    String? plate,
  }) = _ShuttleVehicleInfo;

  factory ShuttleVehicleInfo.fromJson(Map<String, dynamic> json) => _$ShuttleVehicleInfoFromJson(json);
}

@freezed
class ShuttleRoute with _$ShuttleRoute {
  const factory ShuttleRoute({
    required GeoLocation origin,
    required GeoLocation destination,
    @Default(<GeoLocation>[]) List<GeoLocation> stops,
  }) = _ShuttleRoute;

  factory ShuttleRoute.fromJson(Map<String, dynamic> json) => _$ShuttleRouteFromJson(json);
}

@freezed
class ShuttleSchedule with _$ShuttleSchedule {
  const factory ShuttleSchedule({
    @JsonKey(name: 'depart_at') required DateTime departAt,
    @JsonKey(name: 'arrive_at') DateTime? arriveAt,
  }) = _ShuttleSchedule;

  factory ShuttleSchedule.fromJson(Map<String, dynamic> json) => _$ShuttleScheduleFromJson(json);
}

@freezed
class ShuttleCapacity with _$ShuttleCapacity {
  const factory ShuttleCapacity({
    required int total,
    required int taken,
    required int remaining,
  }) = _ShuttleCapacity;

  factory ShuttleCapacity.fromJson(Map<String, dynamic> json) => _$ShuttleCapacityFromJson(json);
}

enum ShuttleStatus {
  @JsonValue('open')
  open,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('done')
  done,
  @JsonValue('canceled')
  canceled,
}

enum ShuttlePurpose {
  evacuation,
  medical_transport,
  supply_transport,
  volunteer_shuttle,
  other,
}

enum ShuttleCostType {
  @JsonValue('free')
  free,
  @JsonValue('share_gas')
  shareGas,
}

@freezed
class Shuttle with _$Shuttle {
  const factory Shuttle({
    required String id,
    required LocalizedText title,
    LocalizedText? description,
    @JsonKey(name: 'vehicle_info') required ShuttleVehicleInfo vehicleInfo,
    @Default(<ShuttlePurpose>[]) List<ShuttlePurpose> purposes,
    required ShuttleRoute route,
    required ShuttleSchedule schedule,
    required ShuttleCapacity capacity,
    @JsonKey(name: 'cost_type') @Default(ShuttleCostType.free) ShuttleCostType costType,
    @Default(ShuttleStatus.open) ShuttleStatus status,
    @Default(false) bool priority,
    @JsonKey(name: 'contact_name') String? contactName,
    @JsonKey(name: 'contact_phone_masked') String? contactPhoneMasked,
    @JsonKey(name: 'creator_id') required String creatorId,
    @JsonKey(name: 'chat_room_id') String? chatRoomId,
    @JsonKey(name: 'participants_snapshot') @Default(<String>[]) List<String> participantsSnapshot,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Shuttle;

  factory Shuttle.fromJson(Map<String, dynamic> json) => _$ShuttleFromJson(json);
}

@freezed
class ShuttleParticipant with _$ShuttleParticipant {
  const factory ShuttleParticipant({
    @JsonKey(name: 'shuttle_id') required String shuttleId,
    @JsonKey(name: 'user_id') required String userId,
    @Default('passenger') String role,
    @JsonKey(name: 'is_visible') @Default(true) bool isVisible,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
  }) = _ShuttleParticipant;

  factory ShuttleParticipant.fromJson(Map<String, dynamic> json) => _$ShuttleParticipantFromJson(json);
}

@freezed
class ShuttleMessage with _$ShuttleMessage {
  const factory ShuttleMessage({
    required String id,
    @JsonKey(name: 'shuttle_id') required String shuttleId,
    @JsonKey(name: 'author_id') required String authorId,
    required String content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _ShuttleMessage;

  factory ShuttleMessage.fromJson(Map<String, dynamic> json) => _$ShuttleMessageFromJson(json);
}

enum ResourceStatus {
  @JsonValue('active')
  active,
  @JsonValue('shortage')
  shortage,
  @JsonValue('closed')
  closed,
}

enum ResourceCategory { food, water, medical, shelter, power, other }

@freezed
class ResourcePoint with _$ResourcePoint {
  const factory ResourcePoint({
    required String id,
    required LocalizedText title,
    LocalizedText? description,
    @Default(<ResourceCategory>[]) List<ResourceCategory> categories,
    @JsonKey(name: 'status') @Default(ResourceStatus.active) ResourceStatus status,
    @JsonKey(name: 'expiry') DateTime? expiry,
    required GeoLocation location,
    String? address,
    @JsonKey(name: 'contact_masked_phone') String? contactMaskedPhone,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ResourcePoint;

  factory ResourcePoint.fromJson(Map<String, dynamic> json) => _$ResourcePointFromJson(json);
}

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    @JsonKey(name: 'entity_type') required String entityType,
    @JsonKey(name: 'entity_id') required String entityId,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
}

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent({
    required int id,
    @JsonKey(name: 'entity_type') required String entityType,
    @JsonKey(name: 'entity_id') required String entityId,
    required NotificationPayload payload,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _NotificationEvent;

  factory NotificationEvent.fromJson(Map<String, dynamic> json) => _$NotificationEventFromJson(json);
}

@freezed
class NotificationPayload with _$NotificationPayload {
  const factory NotificationPayload({
    @JsonKey(name: 'changed_fields') @Default(<String>[]) List<String> changedFields,
    required String status,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _NotificationPayload;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => _$NotificationPayloadFromJson(json);
}
