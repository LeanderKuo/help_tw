import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/chat_message.dart';
import '../../../models/chat_room.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(SupabaseService.client);
});

class ChatRepository {
  final SupabaseClient _supabase;

  ChatRepository(this._supabase);

  /// Get chat room for entity (mission or shuttle)
  Future<ChatRoom?> getChatRoom(String entityId, String entityType) async {
    final data = await _supabase
        .from('chat_rooms')
        .select()
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .maybeSingle();

    if (data == null) return null;
    return ChatRoom.fromSupabase(data);
  }

  /// Get messages for a chat room
  Future<List<ChatMessage>> getMessages(String chatRoomId) async {
    final data = await _supabase
        .from('chat_messages')
        .select()
        .eq('chat_room_id', chatRoomId)
        .order('created_at', ascending: true);

    return (data as List)
        .map((json) => ChatMessage.fromSupabase(json))
        .toList();
  }

  /// Send a message to a chat room
  Future<void> sendMessage(ChatMessage message) async {
    await _supabase.from('chat_messages').insert(message.toSupabasePayload());
  }

  /// Subscribe to messages in a chat room
  Stream<List<ChatMessage>> subscribeToMessages(String chatRoomId) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('chat_room_id', chatRoomId)
        .order('created_at')
        .map(
          (data) => data.map((json) => ChatMessage.fromSupabase(json)).toList(),
        );
  }

  /// Helper: Get messages for a mission (legacy API)
  Future<List<ChatMessage>> getTaskMessages(String taskId) async {
    final room = await getChatRoom(taskId, 'mission');
    if (room == null) return [];
    return getMessages(room.id);
  }

  /// Helper: Subscribe to messages for a mission (legacy API)
  Stream<List<ChatMessage>> subscribeToTaskMessages(String taskId) async* {
    final room = await getChatRoom(taskId, 'mission');
    if (room == null) {
      yield [];
      return;
    }
    yield* subscribeToMessages(room.id);
  }

  /// Helper: Get messages for a shuttle (legacy API)
  Future<List<ChatMessage>> getShuttleMessages(String shuttleId) async {
    final room = await getChatRoom(shuttleId, 'shuttle');
    if (room == null) return [];
    return getMessages(room.id);
  }

  /// Helper: Subscribe to messages for a shuttle (legacy API)
  Stream<List<ChatMessage>> subscribeToShuttleMessages(String shuttleId) async* {
    final room = await getChatRoom(shuttleId, 'shuttle');
    if (room == null) {
      yield [];
      return;
    }
    yield* subscribeToMessages(room.id);
  }
}
