import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import 'auth_controller.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String _countryCode = '+886';
  bool _otpSent = false;
  int _cooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_cooldown > 0) return;
    final phone = _formatPhone();
    if (phone.isEmpty) {
      _showSnack('Enter a phone number');
      return;
    }
    await ref.read(authControllerProvider.notifier).sendPhoneOtp(phone);
    if (mounted) {
      setState(() {
        _otpSent = true;
        _cooldown = 60;
      });
      _startCooldown();
      _showSnack('OTP sent to $phone', success: true);
    }
  }

  Future<void> _verifyOtp() async {
    final phone = _formatPhone();
    final code = _otpController.text.trim();
    if (phone.isEmpty || code.length < 6) {
      _showSnack('Enter the 6-digit code');
      return;
    }
    await ref
        .read(authControllerProvider.notifier)
        .verifyPhoneOtp(phone: phone, token: code);
    if (mounted) {
      Navigator.pop(context);
      _showSnack('Phone verified and signed in', success: true);
    }
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_cooldown <= 1) {
        timer.cancel();
        if (mounted) setState(() => _cooldown = 0);
        return;
      }
      if (mounted) {
        setState(() => _cooldown -= 1);
      }
    });
  }

  String _formatPhone() {
    final local = _phoneController.text.replaceAll(' ', '');
    return '$_countryCode$local';
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
    final state = ref.watch(authControllerProvider);

    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next.hasError) {
        _showSnack(next.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Phone login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField<String>(
                    value: _countryCode,
                    decoration: const InputDecoration(labelText: 'Code'),
                    items: const [
                      DropdownMenuItem(value: '+886', child: Text('+886')),
                      DropdownMenuItem(value: '+81', child: Text('+81')),
                      DropdownMenuItem(value: '+852', child: Text('+852')),
                    ],
                    onChanged: state.isLoading
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _countryCode = value);
                            }
                          },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      hintText: '912345678',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_otpSent)
              TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP code',
                  hintText: '6-digit code',
                ),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : _otpSent
                  ? _verifyOtp
                  : _sendOtp,
              child: state.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_otpSent ? 'Verify code' : 'Send OTP'),
            ),
            if (_otpSent)
              TextButton(
                onPressed: state.isLoading || _cooldown > 0 ? null : _sendOtp,
                child: Text(
                  _cooldown > 0 ? 'Resend in ${_cooldown}s' : 'Resend code',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
