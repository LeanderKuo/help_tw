import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/locale_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeState = ref.watch(localeControllerProvider);
    final lang = localeState.valueOrNull ?? AppLanguage.zhTw;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        child: SingleChildScrollView(
          padding: Responsive.getResponsiveContentPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroSection(context, ref, l10n, lang),
              const SizedBox(height: 32),
              _buildQuickActions(context, lang),
              const SizedBox(height: 32),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildLanguageToggle(ref, lang),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _tr(
              lang,
              zh: '在同一平台協調任務、人員、物資與運輸，加速救援。',
              en:
                  'Coordinate relief tasks, people, supplies, resource sites, and transport in one shared place to respond faster.',
            ),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.5,
            ),
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

  Widget _buildQuickActions(BuildContext context, AppLanguage lang) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/tasks'),
            icon: const Icon(Icons.search),
            label: Text(_tr(lang, zh: '瀏覽任務', en: 'Browse tasks')),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Navigate to register
            },
            icon: const Icon(Icons.app_registration),
            label: Text(_tr(lang, zh: '立即註冊', en: 'Register now')),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(AppLanguage lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _tr(lang, zh: '平台重點', en: 'Platform highlights'),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 16),
        ResponsiveBuilder(
          mobile: (context) => Column(
            children: [
              _buildFeatureCard(
                icon: Icons.map,
                title: _tr(lang, zh: '地圖總覽', en: 'Map overview'),
                description: _tr(
                  lang,
                  zh: '在共享地圖上查看人員、資源點與路線，協調現場應變。',
                  en:
                      'See people, resource points, and transport routes on a shared map to coordinate field response.',
                ),
                color: AppColors.primary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.assignment,
                title: _tr(lang, zh: '任務看板', en: 'Task board'),
                description: _tr(
                  lang,
                  zh: '建立、排序並追蹤任務，提供即時更新與指派。',
                  en:
                      'Create, prioritize, and track missions with real-time updates and assignees.',
                ),
                color: AppColors.secondary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.directions_bus,
                title: _tr(lang, zh: '接駁派遣', en: 'Shuttle dispatch'),
                description: _tr(
                  lang,
                  zh: '管理救援運輸、路線與座位，協助人員與物資調度。',
                  en:
                      'Manage relief transportation, routes, and seat availability for responders and supplies.',
                ),
                color: AppColors.warning,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.inventory_2,
                title: _tr(lang, zh: '資源管理', en: 'Resource tracking'),
                description: _tr(
                  lang,
                  zh: '監控物資點、庫存與狀態，確保關鍵用品可用。',
                  en:
                      'Monitor supply points, quantities, and status to keep critical items available.',
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
                icon: Icons.map,
                title: _tr(lang, zh: '地圖總覽', en: 'Map overview'),
                description: _tr(
                  lang,
                  zh: '在共享地圖上查看人員、資源點與路線，協調現場應變。',
                  en:
                      'See people, resource points, and transport routes on a shared map to coordinate field response.',
                ),
                color: AppColors.primary,
              ),
              _buildFeatureCard(
                icon: Icons.assignment,
                title: _tr(lang, zh: '任務看板', en: 'Task board'),
                description: _tr(
                  lang,
                  zh: '建立、排序並追蹤任務，提供即時更新與指派。',
                  en:
                      'Create, prioritize, and track missions with real-time updates and assignees.',
                ),
                color: AppColors.secondary,
              ),
              _buildFeatureCard(
                icon: Icons.directions_bus,
                title: _tr(lang, zh: '接駁派遣', en: 'Shuttle dispatch'),
                description: _tr(
                  lang,
                  zh: '管理救援運輸、路線與座位，協助人員與物資調度。',
                  en:
                      'Manage relief transportation, routes, and seat availability for responders and supplies.',
                ),
                color: AppColors.warning,
              ),
              _buildFeatureCard(
                icon: Icons.inventory_2,
                title: _tr(lang, zh: '資源管理', en: 'Resource tracking'),
                description: _tr(
                  lang,
                  zh: '監控物資點、庫存與狀態，確保關鍵用品可用。',
                  en:
                      'Monitor supply points, quantities, and status to keep critical items available.',
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
              fontWeight: FontWeight.w600,
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
