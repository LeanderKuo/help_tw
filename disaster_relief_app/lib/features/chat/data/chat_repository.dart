import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/chat_message.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(SupabaseService.client);
});

class ChatRepository {
  final SupabaseClient _supabase;

  ChatRepository(this._supabase);

  Future<List<ChatMessage>> getMessages(String taskId) async {
    final data = await _supabase
        .from('chat_messages')
        .select()
        .eq('task_id', taskId)
        .order('created_at', ascending: true);

    return (data as List).map((json) => ChatMessage.fromJson(json)).toList();
  }

  Future<void> sendMessage(ChatMessage message) async {
    await _supabase.from('chat_messages').insert({
      'task_id': message.taskId,
      'sender_id': message.senderId,
      'content': message.content,
      'image_url': message.imageUrl,
    });
  }

  Stream<List<ChatMessage>> subscribeToMessages(String taskId) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('task_id', taskId)
        .order('created_at')
        .map((data) => data.map((json) => ChatMessage.fromJson(json)).toList());
  }
}
