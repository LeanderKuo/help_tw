import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/pending_mutation.dart';
import 'isar_service.dart';
import 'supabase_service.dart';

class OfflineQueueService {
  OfflineQueueService._internal();

  static final OfflineQueueService instance = OfflineQueueService._internal();

  final IsarService _isarService = IsarService();
  final SupabaseClient _client = SupabaseService.client;
  StreamSubscription<dynamic>? _connectivitySub;

  Future<void> initialize() async {
    _connectivitySub?.cancel();
    _connectivitySub = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.any((r) => r != ConnectivityResult.none)) {
        syncPendingMutations();
      }
    });
  }

  Future<void> dispose() async {
    await _connectivitySub?.cancel();
  }

  Future<void> enqueue({
    required String table,
    required Map<String, dynamic> payload,
  }) async {
    final isar = await _isarService.db;
    final mutation = PendingMutation(
      table: table,
      payload: jsonEncode(payload),
      createdAt: DateTime.now(),
    );
    await isar.writeTxn((isar) async {
      await isar.pendingMutations.put(mutation);
    });
  }

  Future<void> syncPendingMutations() async {
    final isar = await _isarService.db;
    final pending = await isar.pendingMutations.where().findAll();
    for (final mutation in pending) {
      try {
        final payload = jsonDecode(mutation.payload) as Map<String, dynamic>;
        await _client.from(mutation.table).insert(payload);
        await isar.writeTxn((isar) async {
          await isar.pendingMutations.delete(mutation.id);
        });
      } catch (_) {
        // Keep mutation for next attempt.
      }
    }
  }
}
