import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

/// Service to handle periodic cleanup of expired chat messages
/// Calls the database function prune_expired_chat() which removes:
/// - mission_messages older than 30 days
/// - shuttle_messages older than 30 days
/// - chat_rooms older than 30 days
class ChatCleanupService {
  final SupabaseClient _supabase;
  Timer? _cleanupTimer;

  ChatCleanupService([SupabaseClient? supabaseClient])
      : _supabase = supabaseClient ?? SupabaseService.client;

  /// Start periodic cleanup (runs every 6 hours)
  void startPeriodicCleanup({Duration interval = const Duration(hours: 6)}) {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(interval, (_) => cleanupExpiredMessages());

    // Run cleanup immediately on start
    cleanupExpiredMessages();
  }

  /// Stop periodic cleanup
  void stopPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }

  /// Manually trigger cleanup of expired chat messages
  ///
  /// This calls the database function `prune_expired_chat()` which:
  /// - Deletes mission_messages where expires_at <= now()
  /// - Deletes shuttle_messages where expires_at <= now()
  /// - Deletes chat_rooms where expires_at <= now()
  Future<void> cleanupExpiredMessages() async {
    try {
      // Call the PostgreSQL function to prune expired messages
      await _supabase.rpc('prune_expired_chat');

      debugPrint('[ChatCleanup] Successfully cleaned up expired messages');
    } catch (e) {
      debugPrint('[ChatCleanup] Error cleaning up expired messages: $e');
      // Don't rethrow - cleanup failures shouldn't crash the app
    }
  }

  void dispose() {
    stopPeriodicCleanup();
  }
}
