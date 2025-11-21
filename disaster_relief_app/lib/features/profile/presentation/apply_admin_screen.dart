import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/role.dart';
import '../../../core/theme/app_colors.dart';
import '../../admin/data/referral_code_repository.dart';
import '../../admin/data/role_upgrade_repository.dart';

class ApplyAdminScreen extends ConsumerStatefulWidget {
  const ApplyAdminScreen({super.key});

  @override
  ConsumerState<ApplyAdminScreen> createState() => _ApplyAdminScreenState();
}

class _ApplyAdminScreenState extends ConsumerState<ApplyAdminScreen> {
  final _codeController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _codeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      _showSnack('Referral code is required');
      return;
    }
    setState(() => _submitting = true);
    try {
      final repo = ref.read(referralCodeRepositoryProvider);
      final isValid = await repo.validateReferralCode(code);
      if (!isValid) {
        throw Exception('Referral code invalid or expired');
      }
      await ref
          .read(roleUpgradeRepositoryProvider)
          .submitRoleUpgrade(
            currentRole: AppRole.leader,
            targetRole: AppRole.admin,
            reason: _reasonController.text.trim().isEmpty
                ? null
                : _reasonController.text.trim(),
            referralCode: code,
          );
      if (!mounted) return;
      _showSnack('Request submitted for review', success: true);
      Navigator.pop(context);
    } catch (e) {
      _showSnack(e.toString());
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showSnack(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.success : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Admin')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaders need a valid referral code from an Admin to apply.',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Referral code'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Reason (optional)'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
