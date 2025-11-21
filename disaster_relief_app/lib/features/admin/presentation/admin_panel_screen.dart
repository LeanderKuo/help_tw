import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import '../../../core/theme/app_colors.dart';
import 'referral_code_panel.dart';
import 'user_review_panel.dart';

class AdminPanelScreen extends ConsumerWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentUserRoleProvider).valueOrNull ?? AppRole.user;
    if (!role.isAdminOrAbove) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin Panel')),
        body: const Center(
          child: Text('Admin access required to view this page.'),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people_alt), text: 'User Review'),
              Tab(icon: Icon(Icons.qr_code), text: 'Referral Codes'),
              Tab(icon: Icon(Icons.receipt_long), text: 'Audit Logs'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Padding(padding: EdgeInsets.all(16), child: UserReviewPanel()),
            Padding(padding: EdgeInsets.all(16), child: ReferralCodePanel()),
            _AuditLogPlaceholder(),
          ],
        ),
      ),
    );
  }
}

class _AuditLogPlaceholder extends StatelessWidget {
  const _AuditLogPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.receipt, size: 40, color: AppColors.textSecondaryLight),
          SizedBox(height: 8),
          Text('Audit log viewer coming soon'),
        ],
      ),
    );
  }
}
