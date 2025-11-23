// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    @JsonKey(name: 'entity_id') required String entityId,
    @JsonKey(name: 'entity_type') required String entityType, // 'mission' or 'shuttle'
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Parse Supabase chat_rooms row.
  factory ChatRoom.fromSupabase(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String,
      entityId: json['entity_id'] as String,
      entityType: json['entity_type'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
