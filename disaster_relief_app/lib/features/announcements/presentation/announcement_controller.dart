import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';
import '../data/announcement_repository.dart';

final announcementControllerProvider = Provider<AnnouncementController>((ref) {
  return AnnouncementController(ref);
});

class AnnouncementController {
  AnnouncementController(this._ref);

  final Ref _ref;

  AnnouncementRepository get _repo =>
      _ref.read(announcementRepositoryProvider);

  AppLanguage get _locale =>
      _ref.read(localeControllerProvider).valueOrNull ?? AppLanguage.zhTw;

  Future<void> upsert({
    String? id,
    required String title,
    required String body,
    required String type,
    bool isActive = true,
    bool isPinned = false,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return _repo.createOrUpdate(
      id: id,
      title: title,
      body: body,
      type: type,
      isActive: isActive,
      isPinned: isPinned,
      startsAt: startsAt,
      endsAt: endsAt,
      locale: _locale,
    );
  }

  Future<void> updateFlags({
    required String id,
    required String type,
    bool? isActive,
    bool? isPinned,
  }) {
    return _repo.updateFlags(
      id: id,
      type: type,
      isActive: isActive,
      isPinned: isPinned,
    );
  }
}
