// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayId: json['display_id'] as String?,
      nickname: json['nickname'] as String?,
      role: json['role'] as String? ?? 'User',
      avatarUrl: json['avatar_url'] as String?,
      maskedPhone: json['masked_phone'] as String?,
      fullName: json['full_name'] as String?,
      realPhone: json['real_phone'] as String?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_id': instance.displayId,
      'nickname': instance.nickname,
      'role': instance.role,
      'avatar_url': instance.avatarUrl,
      'masked_phone': instance.maskedPhone,
      'full_name': instance.fullName,
      'real_phone': instance.realPhone,
    };
