import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
              _buildHeroSection(context, l10n),
              const SizedBox(height: 32),
              _buildQuickActions(context, l10n),
              const SizedBox(height: 32),
              _buildFeaturesSection(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, AppLocalizations l10n) {
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
          Text(
            l10n.appTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '整合救災任務、人力、物資與資源點，提供地區現場化與時序分析，支援台灣災急狀況高效應對。',
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

  Widget _buildQuickActions(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/tasks'),
            icon: const Icon(Icons.search),
            label: const Text('查看任務'),
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
            label: const Text('立即註冊'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '平台功能介紹',
          style: TextStyle(
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
                title: '地區視覺化',
                description: '以地圖為中心，直觀顯示在各個資源點與人力分布，支援地理定位與搜尋。',
                color: AppColors.primary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.assignment,
                title: '任務管理',
                description: '建立與管理救災任務，支援協作、即時更新與狀態追蹤。',
                color: AppColors.secondary,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.directions_bus,
                title: '班車調度',
                description: '管理救災交通班車，提供路線規劃與座位管理。',
                color: AppColors.warning,
              ),
              const SizedBox(height: 12),
              _buildFeatureCard(
                icon: Icons.inventory_2,
                title: '資源管理',
                description: '追蹤與管理物資資源點，確保資源有效分配。',
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
                title: '地區視覺化',
                description: '以地圖為中心，直觀顯示在各個資源點與人力分布。',
                color: AppColors.primary,
              ),
              _buildFeatureCard(
                icon: Icons.assignment,
                title: '任務管理',
                description: '建立與管理救災任務，支援協作與即時更新。',
                color: AppColors.secondary,
              ),
              _buildFeatureCard(
                icon: Icons.directions_bus,
                title: '班車調度',
                description: '管理救災交通班車，提供路線規劃。',
                color: AppColors.warning,
              ),
              _buildFeatureCard(
                icon: Icons.inventory_2,
                title: '資源管理',
                description: '追蹤與管理物資資源點。',
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondaryLight,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
