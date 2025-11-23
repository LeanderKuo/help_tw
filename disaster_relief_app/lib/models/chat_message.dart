// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    @JsonKey(name: 'chat_room_id') String? chatRoomId,
    @JsonKey(name: 'sender_id') String? senderId,
    String? content,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Parse Supabase chat_messages row.
  factory ChatMessage.fromSupabase(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      chatRoomId: json['chat_room_id'] as String?,
      senderId: json['sender_id'] as String?,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'].toString())
          : null,
    );
  }

  /// Build payload for inserting into Supabase.
  Map<String, dynamic> toSupabasePayload() {
    return {
      'chat_room_id': chatRoomId,
      'sender_id': senderId,
      if (content != null) 'content': content,
      if (imageUrl != null) 'image_url': imageUrl,
    }..removeWhere((key, value) => value == null);
  }
}
