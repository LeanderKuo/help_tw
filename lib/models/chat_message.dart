import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    @JsonKey(name: 'task_id') String? taskId,
    @JsonKey(name: 'shuttle_id') String? shuttleId,
    @JsonKey(name: 'sender_id') String? senderId,
    String? content,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
