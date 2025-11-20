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

  // Keep region codes for persistence while still compatible with l10n (we map by language code in main).
  Locale get locale => this == AppLanguage.zhTw
      ? const Locale('zh', 'TW')
      : const Locale('en', 'US');

  AppLanguage get fallback =>
      this == AppLanguage.zhTw ? AppLanguage.enUs : AppLanguage.zhTw;
}
