// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      taskId: json['mission_id'] as String?,
      shuttleId: json['shuttle_id'] as String?,
      senderId: json['sender_id'] as String?,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mission_id': instance.taskId,
      'shuttle_id': instance.shuttleId,
      'sender_id': instance.senderId,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };
