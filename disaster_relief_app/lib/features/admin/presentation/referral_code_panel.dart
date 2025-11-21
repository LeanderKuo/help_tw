import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/referral_code_repository.dart';
import '../../../core/theme/app_colors.dart';

class ReferralCodePanel extends ConsumerStatefulWidget {
  const ReferralCodePanel({super.key});

  @override
  ConsumerState<ReferralCodePanel> createState() => _ReferralCodePanelState();
}

class _ReferralCodePanelState extends ConsumerState<ReferralCodePanel> {
  ReferralCode? _activeCode;
  List<ReferralCode> _history = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(referralCodeRepositoryProvider);
      final active = await repo.getActiveCodeForIssuer();
      final history = await repo.listCodesForIssuer();
      setState(() {
        _activeCode = active;
        _history = history;
      });
    } catch (e) {
      _showError('Failed to load referral codes: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  Future<void> _generate() async {
    try {
      final repo = ref.read(referralCodeRepositoryProvider);
      final code = await repo.generateReferralCode();
      setState(() => _activeCode = code);
      _showMessage('Generated code: ${code.code}');
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _revoke(String codeId) async {
    try {
      final repo = ref.read(referralCodeRepositoryProvider);
      await repo.revokeCode(codeId);
      await _load();
      _showMessage('Referral code revoked');
    } catch (e) {
      _showError('Failed to revoke code: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.success),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Referral Code',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (_activeCode == null)
                  const Text('No active code. Generate one to invite leaders.')
                else
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              _activeCode!.code,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Expires ${DateFormat('MM/dd HH:mm').format(_activeCode!.expiresAt)} · ${_activeCode!.usedCount}/${_activeCode!.maxUses} used',
                              style: const TextStyle(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _revoke(_activeCode!.id),
                        icon: const Icon(Icons.block),
                        label: const Text('Revoke'),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _activeCode == null ? _generate : null,
                  icon: const Icon(Icons.qr_code),
                  label: const Text('Generate new code'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('History', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (_history.isEmpty)
          const Text('No referral code history yet.')
        else
          ..._history.map(
            (code) => ListTile(
              title: Text(code.code),
              subtitle: Text(
                'Expires ${DateFormat('MM/dd HH:mm').format(code.expiresAt)} · ${code.usedCount}/${code.maxUses}',
              ),
              trailing: code.isActive
                  ? const Chip(
                      label: Text('Active'),
                      backgroundColor: AppColors.primaryLight,
                    )
                  : const Chip(
                      label: Text('Inactive'),
                      backgroundColor: AppColors.dividerLight,
                    ),
            ),
          ),
      ],
    );
  }
}
