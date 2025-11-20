import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeState = ref.watch(localeControllerProvider);
    final lang = localeState.valueOrNull ?? AppLanguage.zhTw;

    return Scaffold(
      appBar: GlobalTopNavBar(
        title: l10n.appTitle,
        onNotificationTap: () {},
        onAvatarTap: () => context.push('/profile'),
      ),
      body: ResponsiveLayout(
        child: SingleChildScrollView(
          padding: Responsive.getResponsiveContentPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroSection(context, ref, l10n, lang),
              const SizedBox(height: 28),
              _buildFeaturesSection(lang),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AppLanguage lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.16),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _tr(
                        lang,
                        zh: '整合救災任務、人力、物資與資源點，提供地圖視覺化與即時協作，支援台灣緊急狀況高效應對。',
                        en:
                            'Coordinate relief tasks, people, supplies, and resource hubs with real-time collaboration and map visualization.',
                      ),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              _buildLanguageToggle(ref, lang),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/tasks'),
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: Text(_tr(lang, zh: '查看任務', en: 'View missions')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/register'),
                  icon: const Icon(Icons.app_registration),
                  label: Text(_tr(lang, zh: '立即註冊', en: 'Register now')),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(WidgetRef ref, AppLanguage selected) {
    return SegmentedButton<AppLanguage>(
      segments: const [
        ButtonSegment<AppLanguage>(
          value: AppLanguage.zhTw,
          label: Text('繁中'),
        ),
        ButtonSegment<AppLanguage>(
          value: AppLanguage.enUs,
          label: Text('EN'),
        ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (value) {
        if (value.isEmpty) return;
        final lang = value.first;
        ref.read(localeControllerProvider.notifier).updateLanguage(lang);
      },
    );
  }

  Widget _buildFeaturesSection(AppLanguage lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '平台功能介紹',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        ResponsiveBuilder(
          mobile: (context) => Column(
            children: [
              _buildFeatureCard(
                icon: Icons.map_outlined,
                title: _tr(lang, zh: '地圖視覺化', en: 'Map visualization'),
                description: _tr(
                  lang,
                  zh: '以地圖集中作戰，直觀展示任務、資源點與人力分佈，支援場景任務與調度。',
                  en:
                      'A shared map to reveal missions, resources, and responders for quick situational awareness.',
                ),
                color: AppColors.primary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.assignment_turned_in_outlined,
                title: _tr(lang, zh: '任務看板', en: 'Mission board'),
                description: _tr(
                  lang,
                  zh: '建立、排序並追蹤任務進度，支援即時更新與分派人員。',
                  en:
                      'Create, prioritize, and track missions with real-time updates and assignments.',
                ),
                color: AppColors.secondary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.directions_bus_rounded,
                title: _tr(lang, zh: '班車派遣', en: 'Shuttle service'),
                description: _tr(
                  lang,
                  zh: '管理救援運輸、路線與座位，指派集合地與搭乘資訊。',
                  en:
                      'Coordinate transport routes, seats, and pickup points for teams and supplies.',
                ),
                color: AppColors.warning,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.inventory_2_outlined,
                title: _tr(lang, zh: '資源管理', en: 'Resource tracking'),
                description: _tr(
                  lang,
                  zh: '監控資源點、庫存與狀態，確保關鍵物資可用。',
                  en: 'Track hubs, inventory, and status to keep critical supplies available.',
                ),
                color: AppColors.success,
              ),
            ],
          ),
          tablet: (context) => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildFeatureCard(
                icon: Icons.map_outlined,
                title: _tr(lang, zh: '地圖視覺化', en: 'Map visualization'),
                description: _tr(
                  lang,
                  zh: '以地圖集中作戰，直觀展示任務、資源點與人力分佈，支援場景任務與調度。',
                  en:
                      'A shared map to reveal missions, resources, and responders for quick situational awareness.',
                ),
                color: AppColors.primary,
              ),
              _buildFeatureCard(
                icon: Icons.assignment_turned_in_outlined,
                title: _tr(lang, zh: '任務看板', en: 'Mission board'),
                description: _tr(
                  lang,
                  zh: '建立、排序並追蹤任務進度，支援即時更新與分派人員。',
                  en:
                      'Create, prioritize, and track missions with real-time updates and assignments.',
                ),
                color: AppColors.secondary,
              ),
              _buildFeatureCard(
                icon: Icons.directions_bus_rounded,
                title: _tr(lang, zh: '班車派遣', en: 'Shuttle service'),
                description: _tr(
                  lang,
                  zh: '管理救援運輸、路線與座位，指派集合地與搭乘資訊。',
                  en:
                      'Coordinate transport routes, seats, and pickup points for teams and supplies.',
                ),
                color: AppColors.warning,
              ),
              _buildFeatureCard(
                icon: Icons.inventory_2_outlined,
                title: _tr(lang, zh: '資源管理', en: 'Resource tracking'),
                description: _tr(
                  lang,
                  zh: '監控資源點、庫存與狀態，確保關鍵物資可用。',
                  en: 'Track hubs, inventory, and status to keep critical supplies available.',
                ),
                color: AppColors.success,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondaryLight,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _tr(AppLanguage lang, {required String zh, required String en}) {
    return lang == AppLanguage.zhTw ? zh : en;
  }
}
