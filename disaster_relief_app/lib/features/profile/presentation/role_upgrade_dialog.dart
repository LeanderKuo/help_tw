import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/role.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/auth/role_providers.dart';
import '../../admin/data/referral_code_repository.dart';
import '../../admin/data/role_upgrade_repository.dart';

class RoleUpgradeDialog extends ConsumerStatefulWidget {
  const RoleUpgradeDialog({required this.currentRole, super.key});

  final AppRole currentRole;

  @override
  ConsumerState<RoleUpgradeDialog> createState() => _RoleUpgradeDialogState();
}

class _RoleUpgradeDialogState extends ConsumerState<RoleUpgradeDialog> {
  final _unitController = TextEditingController();
  final _reasonController = TextEditingController();
  final _referralController = TextEditingController();
  AppRole? _targetRole;
  bool _submitting = false;

  List<AppRole> get _eligibleTargets {
    switch (widget.currentRole) {
      case AppRole.user:
        return [AppRole.superuser];
      case AppRole.superuser:
        return [AppRole.leader];
      case AppRole.leader:
        return [AppRole.admin];
      default:
        return const [];
    }
  }

  @override
  void initState() {
    super.initState();
    final targets = _eligibleTargets;
    if (targets.isNotEmpty) {
      _targetRole = targets.first;
    }
  }

  @override
  void dispose() {
    _unitController.dispose();
    _reasonController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_targetRole == null) return;
    setState(() => _submitting = true);
    try {
      final profileAsync = ref.read(currentUserProfileProvider);
      final profile =
          profileAsync.asData?.value ??
          profileAsync.maybeWhen(data: (p) => p, orElse: () => null);
      if (widget.currentRole == AppRole.user &&
          (profile?.realPhone == null || profile!.realPhone!.isEmpty)) {
        throw Exception('Phone verification required before upgrade.');
      }
      if (widget.currentRole == AppRole.leader) {
        final code = _referralController.text.trim();
        if (code.isEmpty) {
          throw Exception('Referral code is required for Admin review.');
        }
        final valid = await ref
            .read(referralCodeRepositoryProvider)
            .validateReferralCode(code);
        if (!valid) {
          throw Exception('Referral code is invalid or expired.');
        }
      }
      await ref
          .read(roleUpgradeRepositoryProvider)
          .submitRoleUpgrade(
            currentRole: widget.currentRole,
            targetRole: _targetRole!,
            unit: _unitController.text.trim().isEmpty
                ? null
                : _unitController.text.trim(),
            reason: _reasonController.text.trim().isEmpty
                ? null
                : _reasonController.text.trim(),
            referralCode: _referralController.text.trim().isEmpty
                ? null
                : _referralController.text.trim(),
          );
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Role upgrade request submitted'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final targets = _eligibleTargets;
    if (targets.isEmpty) {
      return const SizedBox.shrink();
    }
    return AlertDialog(
      title: const Text('Request role upgrade'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<AppRole>(
              value: _targetRole,
              onChanged: (value) => setState(() => _targetRole = value),
              items: targets
                  .map(
                    (role) =>
                        DropdownMenuItem(value: role, child: Text(role.label)),
                  )
                  .toList(),
              decoration: const InputDecoration(labelText: 'Target role'),
            ),
            const SizedBox(height: 12),
            if (widget.currentRole == AppRole.superuser)
              TextField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: 'Unit/organization (required)',
                ),
              ),
            if (widget.currentRole == AppRole.superuser)
              TextField(
                controller: _reasonController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Reason'),
              ),
            if (widget.currentRole == AppRole.leader)
              TextField(
                controller: _referralController,
                decoration: const InputDecoration(
                  labelText: 'Referral code (required)',
                ),
              ),
            if (widget.currentRole == AppRole.user)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Phone verification is required for Superuser.',
                  style: TextStyle(color: AppColors.textSecondaryLight),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
}
