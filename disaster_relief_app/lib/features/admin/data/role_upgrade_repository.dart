import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/auth/role.dart';
import '../../../services/supabase_service.dart';

final roleUpgradeRepositoryProvider = Provider<RoleUpgradeRepository>((ref) {
  return RoleUpgradeRepository(SupabaseService.client);
});

class RoleUpgradeRequest {
  final String id;
  final String userId;
  final String currentRole;
  final String requestedRole;
  final String? unit;
  final String? reason;
  final String? referralCode;
  final String status;
  final DateTime createdAt;

  const RoleUpgradeRequest({
    required this.id,
    required this.userId,
    required this.currentRole,
    required this.requestedRole,
    required this.status,
    required this.createdAt,
    this.unit,
    this.reason,
    this.referralCode,
  });

  factory RoleUpgradeRequest.fromJson(Map<String, dynamic> json) {
    return RoleUpgradeRequest(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      currentRole: json['current_role'] as String,
      requestedRole: json['requested_role'] as String,
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] as String),
      unit: json['unit'] as String?,
      reason: json['reason'] as String?,
      referralCode: json['referral_code'] as String?,
    );
  }
}

class RoleUpgradeRepository {
  RoleUpgradeRepository(this._client);

  final SupabaseClient _client;

  String _requireUserId() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('User not authenticated');
    }
    return userId;
  }

  Future<bool> hasPendingRequest(AppRole targetRole) async {
    final userId = _requireUserId();
    final List<dynamic> rows = await _client
        .from('role_upgrade_requests')
        .select('id')
        .eq('user_id', userId)
        .eq('requested_role', targetRole.name)
        .eq('status', 'pending');
    return rows.isNotEmpty;
  }

  Future<void> submitRoleUpgrade({
    required AppRole currentRole,
    required AppRole targetRole,
    String? unit,
    String? reason,
    String? referralCode,
  }) async {
    final userId = _requireUserId();
    if (await hasPendingRequest(targetRole)) {
      throw Exception('You already have a pending request for this role');
    }
    await _client.from('role_upgrade_requests').insert({
      'user_id': userId,
      'current_role': currentRole.name,
      'requested_role': targetRole.name,
      'unit': unit,
      'reason': reason,
      'referral_code': referralCode,
      'status': 'pending',
    });
  }

  Future<List<RoleUpgradeRequest>> fetchPendingRequests() async {
    final List<dynamic> rows = await _client
        .from('role_upgrade_requests')
        .select()
        .eq('status', 'pending')
        .order('created_at', ascending: true);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(RoleUpgradeRequest.fromJson)
        .toList();
  }

  Future<void> approveRequest({
    required RoleUpgradeRequest request,
    required AppRole newRole,
  }) async {
    final reviewerId = _requireUserId();
    await _client
        .from('role_upgrade_requests')
        .update({
          'status': 'approved',
          'reviewed_by': reviewerId,
          'reviewed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', request.id);
    await _client
        .from('profiles_public')
        .update({'role': newRole.name})
        .eq('id', request.userId);
  }

  Future<void> rejectRequest({
    required String requestId,
    String? reason,
  }) async {
    final reviewerId = _requireUserId();
    await _client
        .from('role_upgrade_requests')
        .update({
          'status': 'rejected',
          'reviewed_by': reviewerId,
          'reviewed_at': DateTime.now().toIso8601String(),
          if (reason != null) 'review_reason': reason,
        })
        .eq('id', requestId);
  }
}
