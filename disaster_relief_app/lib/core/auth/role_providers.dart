import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../models/user_profile.dart';
import 'role.dart';

final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final profileRepo = ref.watch(profileRepositoryProvider);
  final userId = authRepo.currentUser?.id;

  if (userId == null) {
    return const Stream.empty();
  }

  return profileRepo.watchProfile(userId);
});

final currentUserRoleProvider = StreamProvider<AppRole>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final userId = authRepo.currentUser?.id;
  if (userId == null) {
    return Stream.value(AppRole.visitor);
  }

  final profileStream = ref.watch(currentUserProfileProvider.stream);
  return profileStream.map((profile) => roleFromString(profile?.role));
});
