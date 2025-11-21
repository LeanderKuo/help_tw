import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/supabase_service.dart';
import '../../../models/user_profile.dart';
import '../../../core/utils/phone_masking.dart';

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
          final List<dynamic> data = rows;
          if (data.isEmpty) return null;
          final first = Map<String, dynamic>.from(data.first as Map);
          return UserProfile.fromJson(first);
        });
  }

  Future<void> upsertPhone({
    required String userId,
    required String phoneNumber,
  }) async {
    final masked = maskPhone(phoneNumber);
    await _client.from('profiles_private').upsert({
      'id': userId,
      'phone': phoneNumber,
      'masked_phone': masked,
    });
    await _client.from('profiles_public').upsert({
      'id': userId,
      'masked_phone': masked,
    });
  }
}
