// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String email,
    @JsonKey(name: 'display_id') String? displayId,
    String? nickname,
    @Default('User') String role,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'masked_phone') String? maskedPhone,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'real_phone') String? realPhone,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Check if user has Admin, Superadmin, or Root role
  bool get isAdminOrAbove {
    return role == 'Admin' || role == 'Superadmin' || role == 'Root';
  }

  /// Check if user has Leader role or above
  bool get isLeaderOrAbove {
    return role == 'Leader' || isAdminOrAbove;
  }
}
