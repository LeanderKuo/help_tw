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

  Future<List<ChatMessage>> getTaskMessages(String taskId) async {
    final data = await _supabase
        .from('task_messages')
        .select()
        .eq('task_id', taskId)
        .order('created_at', ascending: true);

    return (data as List)
        .map((json) => ChatMessage.fromSupabase(json))
        .toList();
  }

  Future<void> sendTaskMessage(ChatMessage message) async {
    await _supabase.from('task_messages').insert({
      'task_id': message.taskId,
      'author_id': message.senderId,
      'content': message.content,
      'image_url': message.imageUrl,
    });
  }

  Stream<List<ChatMessage>> subscribeToTaskMessages(String taskId) {
    return _supabase
        .from('task_messages')
        .stream(primaryKey: ['id'])
        .eq('task_id', taskId)
        .order('created_at')
        .map(
          (data) => data.map((json) => ChatMessage.fromSupabase(json)).toList(),
        );
  }

  Stream<List<ChatMessage>> subscribeToShuttleMessages(String shuttleId) {
    return _supabase
        .from('shuttle_messages')
        .stream(primaryKey: ['id'])
        .eq('shuttle_id', shuttleId)
        .order('created_at')
        .map(
          (data) => data.map((json) => ChatMessage.fromSupabase(json)).toList(),
        );
  }

  Future<void> sendShuttleMessage(ChatMessage message) async {
    await _supabase.from('shuttle_messages').insert({
      'shuttle_id': message.shuttleId,
      'author_id': message.senderId,
      'content': message.content,
      'image_url': message.imageUrl,
    });
  }
}
