import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeState = ref.watch(localeControllerProvider);
    final currentLanguage = localeState.valueOrNull ?? AppLanguage.zhTw;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.language,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  RadioListTile<AppLanguage>(
                    value: AppLanguage.zhTw,
                    groupValue: currentLanguage,
                    title: Text(l10n.languageTraditional),
                    subtitle: Text(l10n.languageTraditionalSubtitle),
                    onChanged: localeState.isLoading
                        ? null
                        : (value) => _onLanguageChanged(value, ref, context),
                  ),
                  const Divider(height: 0),
                  RadioListTile<AppLanguage>(
                    value: AppLanguage.enUs,
                    groupValue: currentLanguage,
                    title: Text(l10n.languageEnglish),
                    subtitle: Text(l10n.languageEnglishSubtitle),
                    onChanged: localeState.isLoading
                        ? null
                        : (value) => _onLanguageChanged(value, ref, context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.languageNote,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryLight,
                height: 1.4,
              ),
            ),
            if (localeState.isLoading) ...[
              const SizedBox(height: 16),
              const LinearProgressIndicator(minHeight: 2),
            ],
            if (localeState.hasError) ...[
              const SizedBox(height: 8),
              Text(
                l10n.saveLanguageFailed,
                style: const TextStyle(color: AppColors.error),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _onLanguageChanged(
    AppLanguage? language,
    WidgetRef ref,
    BuildContext context,
  ) async {
    if (language == null) return;
    await ref.read(localeControllerProvider.notifier).updateLanguage(language);
  }
}
