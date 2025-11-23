// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipantImpl _$$ParticipantImplFromJson(Map<String, dynamic> json) =>
    _$ParticipantImpl(
      entityId: json['entity_id'] as String,
      entityType: json['entity_type'] as String,
      userId: json['user_id'] as String,
      role: json['role'] as String? ?? 'helper',
      status: json['status'] as String? ?? 'joined',
      isContactVisible: json['is_contact_visible'] as bool? ?? false,
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$ParticipantImplToJson(_$ParticipantImpl instance) =>
    <String, dynamic>{
      'entity_id': instance.entityId,
      'entity_type': instance.entityType,
      'user_id': instance.userId,
      'role': instance.role,
      'status': instance.status,
      'is_contact_visible': instance.isContactVisible,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };
