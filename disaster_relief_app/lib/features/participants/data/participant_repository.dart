import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/participant.dart';

final participantRepositoryProvider = Provider<ParticipantRepository>((ref) {
  return ParticipantRepository(SupabaseService.client);
});

class ParticipantRepository {
  final SupabaseClient _supabase;

  ParticipantRepository(this._supabase);

  /// Get all participants for an entity (mission or shuttle)
  Future<List<Participant>> getParticipants(
    String entityId,
    String entityType,
  ) async {
    final data = await _supabase
        .from('participants')
        .select()
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .order('joined_at', ascending: true);

    return (data as List)
        .map((json) => Participant.fromSupabase(json))
        .toList();
  }

  /// Join an entity as a participant
  Future<void> joinEntity({
    required String entityId,
    required String entityType,
    required String userId,
    String role = 'helper',
    bool isContactVisible = false,
  }) async {
    final participant = Participant(
      entityId: entityId,
      entityType: entityType,
      userId: userId,
      role: role,
      status: 'joined',
      isContactVisible: isContactVisible,
    );

    await _supabase.from('participants').insert(participant.toSupabasePayload());
  }

  /// Leave an entity
  Future<void> leaveEntity({
    required String entityId,
    required String entityType,
    required String userId,
  }) async {
    await _supabase
        .from('participants')
        .delete()
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .eq('user_id', userId);
  }

  /// Update participant role or contact visibility
  Future<void> updateParticipant({
    required String entityId,
    required String entityType,
    required String userId,
    String? role,
    bool? isContactVisible,
  }) async {
    final updates = <String, dynamic>{};
    if (role != null) updates['role'] = role;
    if (isContactVisible != null) {
      updates['is_contact_visible'] = isContactVisible;
    }

    if (updates.isEmpty) return;

    await _supabase
        .from('participants')
        .update(updates)
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .eq('user_id', userId);
  }

  /// Subscribe to participants for an entity
  Stream<List<Participant>> subscribeToParticipants(
    String entityId,
    String entityType,
  ) {
    return _supabase
        .from('participants')
        .stream(primaryKey: ['entity_id', 'entity_type', 'user_id'])
        .order('joined_at')
        .map(
          (data) => data
              .where((json) =>
                  json['entity_id'] == entityId &&
                  json['entity_type'] == entityType)
              .map((json) => Participant.fromSupabase(json))
              .toList(),
        );
  }

  /// Get participant count for an entity
  Future<int> getParticipantCount(String entityId, String entityType) async {
    final data = await _supabase
        .from('participants')
        .select('user_id')
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .eq('status', 'joined');

    return (data as List).length;
  }

  /// Check if user is participant
  Future<bool> isUserParticipant({
    required String entityId,
    required String entityType,
    required String userId,
  }) async {
    final data = await _supabase
        .from('participants')
        .select('user_id')
        .eq('entity_id', entityId)
        .eq('entity_type', entityType)
        .eq('user_id', userId)
        .maybeSingle();

    return data != null;
  }
}
