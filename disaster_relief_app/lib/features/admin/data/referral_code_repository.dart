import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/supabase_service.dart';

final referralCodeRepositoryProvider = Provider<ReferralCodeRepository>((ref) {
  return ReferralCodeRepository(SupabaseService.client);
});

class ReferralCode {
  final String id;
  final String code;
  final String issuerId;
  final DateTime expiresAt;
  final bool isActive;
  final int maxUses;
  final int usedCount;

  const ReferralCode({
    required this.id,
    required this.code,
    required this.issuerId,
    required this.expiresAt,
    required this.isActive,
    required this.maxUses,
    required this.usedCount,
  });

  factory ReferralCode.fromJson(Map<String, dynamic> json) {
    return ReferralCode(
      id: json['id'] as String,
      code: json['code'] as String,
      issuerId: json['issuer_id'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      isActive: (json['is_active'] as bool?) ?? false,
      maxUses: (json['max_uses'] as num?)?.toInt() ?? 1,
      usedCount: (json['used_count'] as num?)?.toInt() ?? 0,
    );
  }
}

class ReferralCodeRepository {
  ReferralCodeRepository(this._client);

  final SupabaseClient _client;

  String _requireUserId() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('User not authenticated');
    }
    return userId;
  }

  Future<ReferralCode?> getActiveCodeForIssuer([String? issuerId]) async {
    final id = issuerId ?? _requireUserId();
    final List<dynamic> rows = await _client
        .from('referral_codes')
        .select()
        .eq('issuer_id', id)
        .eq('is_active', true)
        .gt('expires_at', DateTime.now().toIso8601String());
    if (rows.isEmpty) return null;
    return ReferralCode.fromJson(Map<String, dynamic>.from(rows.first as Map));
  }

  Future<List<ReferralCode>> listCodesForIssuer([String? issuerId]) async {
    final id = issuerId ?? _requireUserId();
    final List<dynamic> rows = await _client
        .from('referral_codes')
        .select()
        .eq('issuer_id', id)
        .order('created_at', ascending: false);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(ReferralCode.fromJson)
        .toList();
  }

  Future<ReferralCode> generateReferralCode() async {
    final issuerId = _requireUserId();
    final active = await getActiveCodeForIssuer(issuerId);
    if (active != null) {
      throw Exception('You already have an active referral code');
    }
    final code = _generateSecureCode(length: 8);
    final expiresAt = DateTime.now().add(const Duration(hours: 1));
    final payload = {
      'code': code,
      'issuer_id': issuerId,
      'expires_at': expiresAt.toIso8601String(),
      'max_uses': 3,
      'is_active': true,
    };

    final Map<String, dynamic> result = await _client
        .from('referral_codes')
        .insert(payload)
        .select()
        .single();
    return ReferralCode.fromJson(result);
  }

  Future<void> revokeCode(String codeId) async {
    await _client
        .from('referral_codes')
        .update({
          'is_active': false,
          'expires_at': DateTime.now().toIso8601String(),
        })
        .eq('id', codeId);
  }

  Future<bool> validateReferralCode(String code) async {
    final List<dynamic> rows = await _client
        .from('referral_codes')
        .select('code, expires_at, is_active, used_count, max_uses')
        .eq('code', code)
        .limit(1);
    if (rows.isEmpty) return false;
    final row = Map<String, dynamic>.from(rows.first as Map);
    final expiresAt = DateTime.tryParse(row['expires_at'] as String? ?? '');
    final used = (row['used_count'] as num?)?.toInt() ?? 0;
    final maxUses = (row['max_uses'] as num?)?.toInt() ?? 1;
    final isActive = (row['is_active'] as bool?) ?? false;
    return isActive &&
        expiresAt != null &&
        expiresAt.isAfter(DateTime.now()) &&
        used < maxUses;
  }

  Future<void> redeemReferralCode(String code) async {
    final userId = _requireUserId();
    // Prefer server-side function for atomic increment; fall back to update.
    try {
      await _client.rpc(
        'redeem_referral_code',
        params: {'code_input': code, 'user_id': userId},
      );
      return;
    } catch (_) {
      final List<dynamic> rows = await _client
          .from('referral_codes')
          .select()
          .eq('code', code)
          .eq('is_active', true)
          .limit(1);
      if (rows.isEmpty) {
        throw Exception('Invalid or expired referral code');
      }
      final row = Map<String, dynamic>.from(rows.first as Map);
      final used = (row['used_count'] as num?)?.toInt() ?? 0;
      final maxUses = (row['max_uses'] as num?)?.toInt() ?? 1;
      final expiresAt = DateTime.tryParse(row['expires_at'] as String? ?? '');
      if (expiresAt == null ||
          expiresAt.isBefore(DateTime.now()) ||
          used >= maxUses) {
        throw Exception('Referral code expired or exhausted');
      }
      await _client
          .from('referral_codes')
          .update({'used_count': used + 1, 'is_active': used + 1 < maxUses})
          .eq('code', code);
    }
  }

  String _generateSecureCode({int length = 8}) {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random.secure();
    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
