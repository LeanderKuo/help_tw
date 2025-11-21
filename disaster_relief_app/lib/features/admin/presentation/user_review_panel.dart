import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/role.dart';
import '../../../core/theme/app_colors.dart';
import '../data/role_upgrade_repository.dart';

class UserReviewPanel extends ConsumerStatefulWidget {
  const UserReviewPanel({super.key});

  @override
  ConsumerState<UserReviewPanel> createState() => _UserReviewPanelState();
}

class _UserReviewPanelState extends ConsumerState<UserReviewPanel> {
  List<RoleUpgradeRequest> _requests = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(roleUpgradeRepositoryProvider);
      final pending = await repo.fetchPendingRequests();
      setState(() => _requests = pending);
    } catch (e) {
      _showSnack('Failed to load review queue: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSnack(String message, {bool success = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.success : null,
      ),
    );
  }

  Future<void> _approve(RoleUpgradeRequest req) async {
    try {
      final repo = ref.read(roleUpgradeRepositoryProvider);
      final targetRole = roleFromString(req.requestedRole);
      await repo.approveRequest(request: req, newRole: targetRole);
      await _load();
      _showSnack('Approved ${req.requestedRole}', success: true);
    } catch (e) {
      _showSnack('Approval failed: $e');
    }
  }

  Future<void> _reject(RoleUpgradeRequest req) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reject request'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(labelText: 'Reason (optional)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
    if (confirmed != true) return;
    try {
      final repo = ref.read(roleUpgradeRepositoryProvider);
      await repo.rejectRequest(
        requestId: req.id,
        reason: reasonController.text.trim().isEmpty
            ? null
            : reasonController.text.trim(),
      );
      await _load();
      _showSnack('Rejected request');
    } catch (e) {
      _showSnack('Rejection failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_requests.isEmpty) {
      return const Center(child: Text('No pending role upgrade requests.'));
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _requests.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final req = _requests[index];
        return ListTile(
          title: Text('${req.currentRole} → ${req.requestedRole}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (req.unit != null && req.unit!.isNotEmpty)
                Text('Unit: ${req.unit}'),
              if (req.reason != null && req.reason!.isNotEmpty)
                Text('Reason: ${req.reason}'),
              if (req.referralCode != null && req.referralCode!.isNotEmpty)
                Text('Referral: ${req.referralCode}'),
              Text('Submitted: ${req.createdAt.toLocal()}'),
            ],
          ),
          trailing: Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => _reject(req),
                child: const Text('Reject'),
              ),
              ElevatedButton(
                onPressed: () => _approve(req),
                child: const Text('Approve'),
              ),
            ],
          ),
        );
      },
    );
  }
}
