import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/shuttle_model.dart';
import '../../../models/user_profile.dart';
import '../../auth/data/auth_repository.dart';
import '../../chat/data/chat_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../data/shuttle_repository.dart';
import '../../../models/chat_message.dart';

final currentUserIdProvider = Provider<String?>(
  (ref) => ref.watch(authRepositoryProvider).currentUser?.id,
);

final shuttleDetailProvider = FutureProvider.family<ShuttleModel?, String>((
  ref,
  id,
) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  try {
    return shuttles.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
});

final shuttleParticipationProvider = FutureProvider.family<bool, String>((
  ref,
  shuttleId,
) async {
  return ref.watch(shuttleRepositoryProvider).isUserParticipant(shuttleId);
});

final shuttleHostProfileProvider = FutureProvider.family<UserProfile?, String?>(
  (ref, userId) async {
    if (userId == null) return null;
    return ref.watch(profileRepositoryProvider).getProfile(userId);
  },
);

final shuttleMessagesProvider =
    StreamProvider.family<List<ChatMessage>, String>((ref, shuttleId) {
      return ref
          .watch(chatRepositoryProvider)
          .subscribeToShuttleMessages(shuttleId);
    });
