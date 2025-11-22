// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drip_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalizedTextImpl _$$LocalizedTextImplFromJson(Map<String, dynamic> json) =>
    _$LocalizedTextImpl(
      zhTW: json['zh-TW'] as String,
      enUS: json['en-US'] as String,
    );

Map<String, dynamic> _$$LocalizedTextImplToJson(_$LocalizedTextImpl instance) =>
    <String, dynamic>{
      'zh-TW': instance.zhTW,
      'en-US': instance.enUS,
    };

_$GeoLocationImpl _$$GeoLocationImplFromJson(Map<String, dynamic> json) =>
    _$GeoLocationImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String,
      geohash: json['geohash'] as String?,
    );

Map<String, dynamic> _$$GeoLocationImplToJson(_$GeoLocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'geohash': instance.geohash,
    };

_$MissionRequirementsImpl _$$MissionRequirementsImplFromJson(
        Map<String, dynamic> json) =>
    _$MissionRequirementsImpl(
      materials: (json['materials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      manpowerNeeded: (json['manpower_needed'] as num?)?.toInt() ?? 0,
      manpowerCurrent: (json['manpower_current'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MissionRequirementsImplToJson(
        _$MissionRequirementsImpl instance) =>
    <String, dynamic>{
      'materials': instance.materials,
      'manpower_needed': instance.manpowerNeeded,
      'manpower_current': instance.manpowerCurrent,
    };

_$MissionImpl _$$MissionImplFromJson(Map<String, dynamic> json) =>
    _$MissionImpl(
      id: json['id'] as String,
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : LocalizedText.fromJson(json['description'] as Map<String, dynamic>),
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MissionTypeEnumMap, e))
              .toList() ??
          const <MissionType>[],
      status: $enumDecodeNullable(_$MissionStatusEnumMap, json['status']) ??
          MissionStatus.open,
      priority: json['priority'] as bool? ?? false,
      requirements: json['requirements'] == null
          ? const MissionRequirements()
          : MissionRequirements.fromJson(
              json['requirements'] as Map<String, dynamic>),
      location: GeoLocation.fromJson(json['location'] as Map<String, dynamic>),
      contactName: json['contact_name'] as String?,
      contactPhoneMasked: json['contact_phone_masked'] as String?,
      creatorId: json['creator_id'] as String,
      chatRoomId: json['chat_room_id'] as String?,
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MissionImplToJson(_$MissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'types': instance.types.map((e) => _$MissionTypeEnumMap[e]!).toList(),
      'status': _$MissionStatusEnumMap[instance.status]!,
      'priority': instance.priority,
      'requirements': instance.requirements,
      'location': instance.location,
      'contact_name': instance.contactName,
      'contact_phone_masked': instance.contactPhoneMasked,
      'creator_id': instance.creatorId,
      'chat_room_id': instance.chatRoomId,
      'participant_count': instance.participantCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$MissionTypeEnumMap = {
  MissionType.rescue: 'rescue',
  MissionType.medical: 'medical',
  MissionType.transport: 'transport',
  MissionType.clearing: 'clearing',
  MissionType.other: 'other',
};

const _$MissionStatusEnumMap = {
  MissionStatus.open: 'open',
  MissionStatus.inProgress: 'in_progress',
  MissionStatus.done: 'done',
  MissionStatus.canceled: 'canceled',
};

_$MissionParticipantImpl _$$MissionParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$MissionParticipantImpl(
      missionId: json['mission_id'] as String,
      userId: json['user_id'] as String,
      isVisible: json['is_visible'] as bool? ?? true,
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$MissionParticipantImplToJson(
        _$MissionParticipantImpl instance) =>
    <String, dynamic>{
      'mission_id': instance.missionId,
      'user_id': instance.userId,
      'is_visible': instance.isVisible,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };

_$MissionMessageImpl _$$MissionMessageImplFromJson(Map<String, dynamic> json) =>
    _$MissionMessageImpl(
      id: json['id'] as String,
      missionId: json['mission_id'] as String,
      authorId: json['author_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$MissionMessageImplToJson(
        _$MissionMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mission_id': instance.missionId,
      'author_id': instance.authorId,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
    };

_$ShuttleVehicleInfoImpl _$$ShuttleVehicleInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ShuttleVehicleInfoImpl(
      type: json['type'] as String,
      plate: json['plate'] as String?,
    );

Map<String, dynamic> _$$ShuttleVehicleInfoImplToJson(
        _$ShuttleVehicleInfoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'plate': instance.plate,
    };

_$ShuttleRouteImpl _$$ShuttleRouteImplFromJson(Map<String, dynamic> json) =>
    _$ShuttleRouteImpl(
      origin: GeoLocation.fromJson(json['origin'] as Map<String, dynamic>),
      destination:
          GeoLocation.fromJson(json['destination'] as Map<String, dynamic>),
      stops: (json['stops'] as List<dynamic>?)
              ?.map((e) => GeoLocation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GeoLocation>[],
    );

Map<String, dynamic> _$$ShuttleRouteImplToJson(_$ShuttleRouteImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'destination': instance.destination,
      'stops': instance.stops,
    };

_$ShuttleScheduleImpl _$$ShuttleScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$ShuttleScheduleImpl(
      departAt: DateTime.parse(json['depart_at'] as String),
      arriveAt: json['arrive_at'] == null
          ? null
          : DateTime.parse(json['arrive_at'] as String),
    );

Map<String, dynamic> _$$ShuttleScheduleImplToJson(
        _$ShuttleScheduleImpl instance) =>
    <String, dynamic>{
      'depart_at': instance.departAt.toIso8601String(),
      'arrive_at': instance.arriveAt?.toIso8601String(),
    };

_$ShuttleCapacityImpl _$$ShuttleCapacityImplFromJson(
        Map<String, dynamic> json) =>
    _$ShuttleCapacityImpl(
      total: (json['total'] as num).toInt(),
      taken: (json['taken'] as num).toInt(),
      remaining: (json['remaining'] as num).toInt(),
    );

Map<String, dynamic> _$$ShuttleCapacityImplToJson(
        _$ShuttleCapacityImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'taken': instance.taken,
      'remaining': instance.remaining,
    };

_$ShuttleImpl _$$ShuttleImplFromJson(Map<String, dynamic> json) =>
    _$ShuttleImpl(
      id: json['id'] as String,
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : LocalizedText.fromJson(json['description'] as Map<String, dynamic>),
      vehicleInfo: ShuttleVehicleInfo.fromJson(
          json['vehicle_info'] as Map<String, dynamic>),
      purposes: (json['purposes'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ShuttlePurposeEnumMap, e))
              .toList() ??
          const <ShuttlePurpose>[],
      route: ShuttleRoute.fromJson(json['route'] as Map<String, dynamic>),
      schedule:
          ShuttleSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
      capacity:
          ShuttleCapacity.fromJson(json['capacity'] as Map<String, dynamic>),
      costType:
          $enumDecodeNullable(_$ShuttleCostTypeEnumMap, json['cost_type']) ??
              ShuttleCostType.free,
      status: $enumDecodeNullable(_$ShuttleStatusEnumMap, json['status']) ??
          ShuttleStatus.open,
      priority: json['priority'] as bool? ?? false,
      contactName: json['contact_name'] as String?,
      contactPhoneMasked: json['contact_phone_masked'] as String?,
      creatorId: json['creator_id'] as String,
      chatRoomId: json['chat_room_id'] as String?,
      participantsSnapshot: (json['participants_snapshot'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ShuttleImplToJson(_$ShuttleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'vehicle_info': instance.vehicleInfo,
      'purposes':
          instance.purposes.map((e) => _$ShuttlePurposeEnumMap[e]!).toList(),
      'route': instance.route,
      'schedule': instance.schedule,
      'capacity': instance.capacity,
      'cost_type': _$ShuttleCostTypeEnumMap[instance.costType]!,
      'status': _$ShuttleStatusEnumMap[instance.status]!,
      'priority': instance.priority,
      'contact_name': instance.contactName,
      'contact_phone_masked': instance.contactPhoneMasked,
      'creator_id': instance.creatorId,
      'chat_room_id': instance.chatRoomId,
      'participants_snapshot': instance.participantsSnapshot,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ShuttlePurposeEnumMap = {
  ShuttlePurpose.evacuation: 'evacuation',
  ShuttlePurpose.medical_transport: 'medical_transport',
  ShuttlePurpose.supply_transport: 'supply_transport',
  ShuttlePurpose.volunteer_shuttle: 'volunteer_shuttle',
  ShuttlePurpose.other: 'other',
};

const _$ShuttleCostTypeEnumMap = {
  ShuttleCostType.free: 'free',
  ShuttleCostType.shareGas: 'share_gas',
};

const _$ShuttleStatusEnumMap = {
  ShuttleStatus.open: 'open',
  ShuttleStatus.inProgress: 'in_progress',
  ShuttleStatus.done: 'done',
  ShuttleStatus.canceled: 'canceled',
};

_$ShuttleParticipantImpl _$$ShuttleParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$ShuttleParticipantImpl(
      shuttleId: json['shuttle_id'] as String,
      userId: json['user_id'] as String,
      role: json['role'] as String? ?? 'passenger',
      isVisible: json['is_visible'] as bool? ?? true,
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$ShuttleParticipantImplToJson(
        _$ShuttleParticipantImpl instance) =>
    <String, dynamic>{
      'shuttle_id': instance.shuttleId,
      'user_id': instance.userId,
      'role': instance.role,
      'is_visible': instance.isVisible,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };

_$ShuttleMessageImpl _$$ShuttleMessageImplFromJson(Map<String, dynamic> json) =>
    _$ShuttleMessageImpl(
      id: json['id'] as String,
      shuttleId: json['shuttle_id'] as String,
      authorId: json['author_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$ShuttleMessageImplToJson(
        _$ShuttleMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shuttle_id': instance.shuttleId,
      'author_id': instance.authorId,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
    };

_$ResourcePointImpl _$$ResourcePointImplFromJson(Map<String, dynamic> json) =>
    _$ResourcePointImpl(
      id: json['id'] as String,
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : LocalizedText.fromJson(json['description'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ResourceCategoryEnumMap, e))
              .toList() ??
          const <ResourceCategory>[],
      status: $enumDecodeNullable(_$ResourceStatusEnumMap, json['status']) ??
          ResourceStatus.active,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
      location: GeoLocation.fromJson(json['location'] as Map<String, dynamic>),
      address: json['address'] as String?,
      contactMaskedPhone: json['contact_masked_phone'] as String?,
      createdBy: json['created_by'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ResourcePointImplToJson(_$ResourcePointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'categories': instance.categories
          .map((e) => _$ResourceCategoryEnumMap[e]!)
          .toList(),
      'status': _$ResourceStatusEnumMap[instance.status]!,
      'expiry': instance.expiry?.toIso8601String(),
      'location': instance.location,
      'address': instance.address,
      'contact_masked_phone': instance.contactMaskedPhone,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ResourceCategoryEnumMap = {
  ResourceCategory.food: 'food',
  ResourceCategory.water: 'water',
  ResourceCategory.medical: 'medical',
  ResourceCategory.shelter: 'shelter',
  ResourceCategory.power: 'power',
  ResourceCategory.other: 'other',
};

const _$ResourceStatusEnumMap = {
  ResourceStatus.active: 'active',
  ResourceStatus.shortage: 'shortage',
  ResourceStatus.closed: 'closed',
};

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      id: json['id'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity_type': instance.entityType,
      'entity_id': instance.entityId,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$NotificationEventImpl _$$NotificationEventImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationEventImpl(
      id: (json['id'] as num).toInt(),
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
      payload:
          NotificationPayload.fromJson(json['payload'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$NotificationEventImplToJson(
        _$NotificationEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity_type': instance.entityType,
      'entity_id': instance.entityId,
      'payload': instance.payload,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$NotificationPayloadImpl _$$NotificationPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationPayloadImpl(
      changedFields: (json['changed_fields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      status: json['status'] as String,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$NotificationPayloadImplToJson(
        _$NotificationPayloadImpl instance) =>
    <String, dynamic>{
      'changed_fields': instance.changedFields,
      'status': instance.status,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
