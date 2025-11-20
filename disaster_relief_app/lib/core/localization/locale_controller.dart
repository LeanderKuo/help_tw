import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../services/supabase_service.dart';
import 'app_language.dart';

final languageRepositoryProvider = Provider<LanguageRepository>(
  (ref) => LanguageRepository(SupabaseService.client),
);

final localeControllerProvider =
    StateNotifierProvider<LocaleController, AsyncValue<AppLanguage>>(
      (ref) => LocaleController(ref.watch(languageRepositoryProvider), ref),
    );

class LanguageRepository {
  LanguageRepository(this._client);

  final SupabaseClient _client;

  Future<AppLanguage> fetchPreferredLanguage({required String userId}) async {
    try {
      final settings = await _client
          .from('user_settings')
          .select('language')
          .eq('user_id', userId)
          .maybeSingle();

      if (settings != null && settings['language'] is String) {
        return languageFromCode(settings['language'] as String);
      }

      final profile = await _client
          .from('profiles_public')
          .select('locale')
          .eq('id', userId)
          .maybeSingle();

      if (profile != null && profile['locale'] is String) {
        return languageFromCode(profile['locale'] as String);
      }

      return AppLanguage.zhTw;
    } catch (_) {
      return AppLanguage.zhTw;
    }
  }

  Future<void> updateLanguage({
    required String userId,
    required AppLanguage language,
  }) async {
    final code = language.code;
    final timestamp = DateTime.now().toIso8601String();

    // Persist to user_settings (UI language) and keep profiles_public.locale in sync
    await _client.from('user_settings').upsert({
      'user_id': userId,
      'language': code,
      'updated_at': timestamp,
    });

    await _client
        .from('profiles_public')
        .update({'locale': code, 'updated_at': timestamp})
        .eq('id', userId);
  }
}

class LocaleController extends StateNotifier<AsyncValue<AppLanguage>> {
  LocaleController(this._repository, this._ref) : super(const AsyncLoading()) {
    _authSubscription = _ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen((_) => _bootstrap());
    _bootstrap();
  }

  final LanguageRepository _repository;
  final Ref _ref;
  late final StreamSubscription<AuthState> _authSubscription;

  Future<void> _bootstrap() async {
    final userId = _ref.read(authRepositoryProvider).currentUser?.id;
    if (userId == null) {
      state = const AsyncData(AppLanguage.zhTw);
      return;
    }

    final language = await _repository.fetchPreferredLanguage(userId: userId);
    state = AsyncData(language);
  }

  Future<void> updateLanguage(AppLanguage language) async {
    final previous = state.valueOrNull;
    state = const AsyncLoading();

    final userId = _ref.read(authRepositoryProvider).currentUser?.id;
    if (userId == null) {
      state = AsyncData(language);
      return;
    }

    try {
      await _repository.updateLanguage(userId: userId, language: language);
      state = AsyncData(language);
    } catch (error, stack) {
      state = AsyncError<AppLanguage>(
        error,
        stack,
        previous: AsyncData(previous ?? AppLanguage.zhTw),
      );
    }
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
