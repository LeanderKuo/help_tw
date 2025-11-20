import 'app_language.dart';

/// Returns localized text with automatic fallback.
/// - Prefers the user's language key (e.g. zh-TW / en-US).
/// - Falls back to the alternate language if the preferred value is empty.
String localizedText(Map<String, dynamic>? data, AppLanguage preference) {
  if (data == null) return '';

  String? pick(String key) {
    final value = data[key];
    if (value is String && value.trim().isNotEmpty) return value;
    return null;
  }

  final primaryKey = preference.code;
  final altKey = preference.fallback.code;

  return pick(primaryKey) ??
      // Allow underscore variants from Supabase json -> Dart conversions
      pick(primaryKey.replaceAll('-', '_')) ??
      pick(altKey) ??
      pick(altKey.replaceAll('-', '_')) ??
      '';
}
