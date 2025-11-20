import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/user_profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(SupabaseService.client);
});

class ProfileRepository {
  final SupabaseClient _client;

  ProfileRepository(this._client);

  Future<UserProfile?> getProfile(String userId) async {
    try {
      final data = await _client
          .from('profiles_public')
          .select()
          .eq('id', userId)
          .single();
      return UserProfile.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Stream<UserProfile?> watchProfile(String userId) {
    return _client
        .from('profiles_public')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((rows) {
      if (rows.isEmpty) return null;
      final first = rows.first;
      if (first is Map<String, dynamic>) {
        return UserProfile.fromJson(first);
      }
      return UserProfile.fromJson(Map<String, dynamic>.from(first as Map));
    });
  }
  
  // TODO: Add update profile methods
}
