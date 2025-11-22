// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    @JsonKey(name: 'mission_id') String? missionId,
    @JsonKey(name: 'shuttle_id') String? shuttleId,
    @JsonKey(name: 'sender_id') String? senderId,
    String? content,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Parse Supabase task/shuttle message row.
  factory ChatMessage.fromSupabase(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      missionId: json['mission_id'] as String?,
      shuttleId: json['shuttle_id'] as String?,
      senderId: json['author_id'] as String? ?? json['sender_id'] as String?,
      content: json['content'] as String? ?? json['text'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
