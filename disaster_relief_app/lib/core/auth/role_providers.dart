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

final currentUserRoleProvider = Provider<AppRole>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final userId = authRepo.currentUser?.id;
  if (userId == null) {
    return AppRole.visitor;
  }

  final profile = ref.watch(currentUserProfileProvider).valueOrNull;
  return roleFromString(profile?.role);
});
