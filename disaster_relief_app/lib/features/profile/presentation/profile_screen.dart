import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../auth/data/auth_repository.dart';
import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import 'role_upgrade_dialog.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(authRepositoryProvider).currentUser;
    final profileAsync = ref.watch(currentUserProfileProvider);
    final profile = profileAsync.valueOrNull;
    final role = ref.watch(currentUserRoleProvider);
    final rawDisplayName = profile?.nickname ?? user?.email ?? l10n.noEmail;
    final displayName = rawDisplayName.trim().isEmpty
        ? l10n.noEmail
        : rawDisplayName;
    final displayInitial = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : 'U';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryLight, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        displayInitial,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        role.label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: Responsive.getResponsiveContentPadding(context),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      context,
                      title: l10n.accountInfo,
                      children: [
                        _buildInfoTile(
                          icon: Icons.email_outlined,
                          label: l10n.emailLabel,
                          value: user?.email ?? 'N/A',
                        ),
                        const Divider(),
                        _buildInfoTile(
                          icon: Icons.badge_outlined,
                          label: l10n.userIdLabel,
                          value: user?.id ?? 'N/A',
                        ),
                        const Divider(),
                        _buildInfoTile(
                          icon: Icons.verified_user_outlined,
                          label: l10n.roleUser,
                          value: role.label,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (role.rank < AppRole.root.rank)
                      _buildInfoCard(
                        context,
                        title: 'Roles & permissions',
                        children: [
                          if (!role.isAdminOrAbove)
                            _buildActionTile(
                              icon: Icons.upgrade,
                              label: 'Request role upgrade',
                              onTap: () async {
                                await showDialog<bool>(
                                  context: context,
                                  builder: (_) =>
                                      RoleUpgradeDialog(currentRole: role),
                                );
                              },
                            ),
                          if (role.isLeaderOrAbove)
                            Column(
                              children: [
                                const Divider(),
                                _buildActionTile(
                                  icon: Icons.verified,
                                  label: 'Apply for Admin (referral)',
                                  onTap: () =>
                                      context.push('/profile/apply-admin'),
                                ),
                              ],
                            ),
                          if (role.isAdminOrAbove)
                            Column(
                              children: [
                                const Divider(),
                                _buildActionTile(
                                  icon: Icons.admin_panel_settings_outlined,
                                  label: 'Open Admin Panel',
                                  onTap: () => context.push('/admin'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    if (role.rank < AppRole.root.rank)
                      const SizedBox(height: 16),
                    _buildInfoCard(
                      context,
                      title: l10n.appSettingsSection,
                      children: [
                        _buildActionTile(
                          icon: Icons.language,
                          label: l10n.languageSettings,
                          onTap: () {},
                        ),
                        const Divider(),
                        _buildActionTile(
                          icon: Icons.notifications_outlined,
                          label: l10n.notificationSettings,
                          onTap: () {},
                        ),
                        const Divider(),
                        _buildActionTile(
                          icon: Icons.privacy_tip_outlined,
                          label: l10n.privacySettings,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      context,
                      title: l10n.aboutSection,
                      children: [
                        _buildActionTile(
                          icon: Icons.help_outline,
                          label: l10n.helpCenter,
                          onTap: () {},
                        ),
                        const Divider(),
                        _buildActionTile(
                          icon: Icons.info_outline,
                          label: l10n.aboutApp,
                          onTap: () {},
                        ),
                        const Divider(),
                        _buildActionTile(
                          icon: Icons.description_outlined,
                          label: l10n.terms,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showLogoutDialog(context, ref, l10n);
                        },
                        icon: const Icon(Icons.logout, color: AppColors.error),
                        label: Text(
                          l10n.logout,
                          style: const TextStyle(color: AppColors.error),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoCard(
  BuildContext context, {
  required String title,
  required List<Widget> children,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
}

Widget _buildInfoTile({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondaryLight),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionTile({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondaryLight),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryLight,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 20,
            color: AppColors.textSecondaryLight,
          ),
        ],
      ),
    ),
  );
}

void _showLogoutDialog(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.logoutConfirmTitle),
      content: Text(l10n.logoutConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ref.read(authControllerProvider.notifier).signOut();
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          child: Text(l10n.logout),
        ),
      ],
    ),
  );
}
