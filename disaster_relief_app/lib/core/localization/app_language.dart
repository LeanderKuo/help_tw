import 'package:flutter/material.dart';

/// Supported UI languages backed by Supabase user_settings.language.
enum AppLanguage { zhTw, enUs }

AppLanguage languageFromCode(String? code) {
  final normalized = code?.toLowerCase() ?? '';
  if (normalized.contains('en')) return AppLanguage.enUs;
  return AppLanguage.zhTw;
}

extension AppLanguageX on AppLanguage {
  String get code => this == AppLanguage.zhTw ? 'zh-TW' : 'en-US';

  // Use language-only locales because current l10n supports zh and en without region.
  Locale get locale => this == AppLanguage.zhTw
      ? const Locale('zh')
      : const Locale('en');

  AppLanguage get fallback =>
      this == AppLanguage.zhTw ? AppLanguage.enUs : AppLanguage.zhTw;
}
