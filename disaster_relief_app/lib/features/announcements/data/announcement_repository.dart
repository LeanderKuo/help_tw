import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../services/supabase_service.dart';

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return AnnouncementRepository(SupabaseService.client);
});

final activeEmergencyAnnouncementProvider =
    StreamProvider<AnnouncementModel?>((ref) {
  final repo = ref.watch(announcementRepositoryProvider);
  final localeState = ref.watch(localeControllerProvider);
  final language = localeState.valueOrNull ?? AppLanguage.zhTw;
  return repo.watchActiveEmergency(language);
});

class AnnouncementModel {
  final String id;
  final String type;
  final String? headline;
  final String body;
  final bool isActive;
  final DateTime? startsAt;
  final DateTime? endsAt;

  AnnouncementModel({
    required this.id,
    required this.type,
    required this.body,
    required this.isActive,
    this.headline,
    this.startsAt,
    this.endsAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json,
      {AppLanguage locale = AppLanguage.zhTw}) {
    final localizedTitle = _localizedText(json['title'], locale);
    final localizedBody = _localizedText(json['body'], locale);
    return AnnouncementModel(
      id: json['id'] as String,
      type: (json['type'] as String?) ?? 'general',
      headline: localizedTitle,
      body: localizedBody,
      isActive: (json['is_active'] as bool?) ?? false,
      startsAt: json['starts_at'] != null
          ? DateTime.tryParse(json['starts_at'] as String)
          : null,
      endsAt: json['ends_at'] != null
          ? DateTime.tryParse(json['ends_at'] as String)
          : null,
    );
  }

  static String _localizedText(dynamic payload, AppLanguage locale) {
    if (payload is Map) {
      final matching = payload[_localeKey(locale)] ??
          payload['zh-TW'] ??
          payload['en-US'];
      if (matching is String) return matching;
    }
    if (payload is String) return payload;
    return '';
  }

  static String _localeKey(AppLanguage locale) {
    switch (locale) {
      case AppLanguage.enUs:
        return 'en-US';
      case AppLanguage.zhTw:
        return 'zh-TW';
    }
  }
}

class AnnouncementRepository {
  AnnouncementRepository(this._supabase);

  final SupabaseClient _supabase;

  Stream<AnnouncementModel?> watchActiveEmergency(AppLanguage locale) {
    return _supabase.from('announcements').stream(primaryKey: ['id']).map((rows) {
      final filtered = rows
          .where((row) => row['type'] == 'emergency' && (row['is_active'] ?? false) == true)
          .toList();
      if (filtered.isEmpty) return null;
      filtered.sort((a, b) {
        final aStart = DateTime.tryParse(a['starts_at'] ?? '') ?? DateTime.now();
        final bStart = DateTime.tryParse(b['starts_at'] ?? '') ?? DateTime.now();
        return bStart.compareTo(aStart);
      });
      return AnnouncementModel.fromJson(filtered.first, locale: locale);
    });
  }
}
