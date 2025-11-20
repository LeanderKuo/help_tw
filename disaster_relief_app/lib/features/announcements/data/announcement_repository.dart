import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../services/supabase_service.dart';

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return AnnouncementRepository(SupabaseService.client);
});

final announcementsProvider = StreamProvider<List<AnnouncementModel>>((ref) {
  final repo = ref.watch(announcementRepositoryProvider);
  final localeState = ref.watch(localeControllerProvider);
  final language = localeState.valueOrNull ?? AppLanguage.zhTw;
  return repo.watchAnnouncements(language);
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
  final String type; // general | emergency
  final String title;
  final String body;
  final bool isActive;
  final bool isPinned;
  final DateTime? startsAt;
  final DateTime? endsAt;

  const AnnouncementModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isActive,
    required this.isPinned,
    this.startsAt,
    this.endsAt,
  });

  factory AnnouncementModel.fromJson(
    Map<String, dynamic> json, {
    AppLanguage locale = AppLanguage.zhTw,
  }) {
    return AnnouncementModel(
      id: json['id'] as String,
      type: (json['type'] as String?) ?? 'general',
      title: _localizedText(json['title'], locale),
      body: _localizedText(json['body'], locale),
      isActive: (json['is_active'] as bool?) ?? false,
      isPinned: (json['is_pinned'] as bool?) ?? false,
      startsAt: _parseDate(json['starts_at']),
      endsAt: _parseDate(json['ends_at']),
    );
  }

  Map<String, dynamic> toPayload({
    required AppLanguage locale,
    required String creatorId,
    bool? activeOverride,
    bool? pinnedOverride,
    DateTime? startsAtOverride,
    DateTime? endsAtOverride,
  }) {
    final localizedTitle = {
      'zh-TW': title,
      'en-US': title,
    };
    final localizedBody = {
      'zh-TW': body,
      'en-US': body,
    };
    return {
      'id': id,
      'type': type,
      'title': localizedTitle,
      'body': localizedBody,
      'is_active': activeOverride ?? isActive,
      'is_pinned': pinnedOverride ?? isPinned,
      'starts_at': (startsAtOverride ?? startsAt)?.toIso8601String(),
      'ends_at': (endsAtOverride ?? endsAt)?.toIso8601String(),
      'created_by': creatorId,
    }..removeWhere((key, value) => value == null);
  }
}

class AnnouncementRepository {
  AnnouncementRepository(this._supabase);

  final SupabaseClient _supabase;

  Stream<List<AnnouncementModel>> watchAnnouncements(AppLanguage locale) {
    return _supabase
        .from('announcements')
        .stream(primaryKey: ['id'])
        .order('starts_at', ascending: false)
        .map((rows) {
      final models = rows
          .map((row) => AnnouncementModel.fromJson(
                Map<String, dynamic>.from(row as Map),
                locale: locale,
              ))
          .toList()
        ..sort((a, b) {
          final aTime = a.startsAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          final bTime = b.startsAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          return bTime.compareTo(aTime);
        });
      return models;
    });
  }

  Stream<AnnouncementModel?> watchActiveEmergency(AppLanguage locale) {
    return watchAnnouncements(locale).map((list) {
      final active = list
          .where((a) => a.type == 'emergency' && a.isActive)
          .toList(growable: false);
      if (active.isEmpty) return null;
      return active.first;
    });
  }

  Future<void> createOrUpdate({
    String? id,
    required String title,
    required String body,
    required String type,
    bool isActive = true,
    bool isPinned = false,
    DateTime? startsAt,
    DateTime? endsAt,
    AppLanguage locale = AppLanguage.zhTw,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    if (type == 'emergency' && isActive) {
      await _deactivateActiveEmergency(excludeId: id);
    }

    final model = AnnouncementModel(
      id: id ?? const Uuid().v4(),
      type: type,
      title: title,
      body: body,
      isActive: isActive,
      isPinned: isPinned,
      startsAt: startsAt ?? DateTime.now(),
      endsAt: endsAt,
    );

    await _supabase.from('announcements').upsert(
          model.toPayload(
            locale: locale,
            creatorId: userId,
          ),
        );
  }

  Future<void> updateFlags({
    required String id,
    required String type,
    bool? isActive,
    bool? isPinned,
  }) async {
    if (isActive == true && type == 'emergency') {
      await _deactivateActiveEmergency(excludeId: id);
    }
    final payload = <String, dynamic>{
      if (isActive != null) 'is_active': isActive,
      if (isPinned != null) 'is_pinned': isPinned,
    };
    if (payload.isEmpty) return;
    await _supabase.from('announcements').update(payload).eq('id', id);
  }

  Future<void> _deactivateActiveEmergency({String? excludeId}) async {
    final query = _supabase
        .from('announcements')
        .update({'is_active': false})
        .eq('type', 'emergency');
    if (excludeId != null) {
      query.neq('id', excludeId);
    }
    await query;
  }
}

String _localizedText(dynamic payload, AppLanguage locale) {
  if (payload is Map) {
    final matching =
        payload[_localeKey(locale)] ?? payload['zh-TW'] ?? payload['en-US'];
    if (matching is String) return matching;
  }
  if (payload is String) return payload;
  return '';
}

String _localeKey(AppLanguage locale) {
  switch (locale) {
    case AppLanguage.enUs:
      return 'en-US';
    case AppLanguage.zhTw:
      return 'zh-TW';
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  return DateTime.tryParse(value.toString());
}
