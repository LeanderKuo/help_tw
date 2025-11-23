// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant.freezed.dart';
part 'participant.g.dart';

@freezed
class Participant with _$Participant {
  const factory Participant({
    @JsonKey(name: 'entity_id') required String entityId,
    @JsonKey(name: 'entity_type') required String entityType, // 'mission' or 'shuttle'
    @JsonKey(name: 'user_id') required String userId,
    @Default('helper') String role, // 'driver', 'passenger', 'helper', 'commander'
    @Default('joined') String status, // 'joined', 'waitlist', 'approved'
    @JsonKey(name: 'is_contact_visible') @Default(false) bool isContactVisible,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
  }) = _Participant;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  /// Parse Supabase participants row.
  factory Participant.fromSupabase(Map<String, dynamic> json) {
    return Participant(
      entityId: json['entity_id'] as String,
      entityType: json['entity_type'] as String,
      userId: json['user_id'] as String,
      role: (json['role'] as String?) ?? 'helper',
      status: (json['status'] as String?) ?? 'joined',
      isContactVisible: (json['is_contact_visible'] as bool?) ?? false,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'].toString())
          : null,
    );
  }

  /// Build payload for inserting into Supabase.
  Map<String, dynamic> toSupabasePayload() {
    return {
      'entity_id': entityId,
      'entity_type': entityType,
      'user_id': userId,
      'role': role,
      'status': status,
      'is_contact_visible': isContactVisible,
    };
  }
}
