import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
import '../../../services/offline_queue_service.dart';
import '../../../models/task_model.dart';
import '../../../models/resource_point.dart'; // for fastHash

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return TaskRepository(SupabaseService.client, isarService);
});

class TaskRepository {
  final SupabaseClient _supabase;
  final IsarService _isarService;

  TaskRepository(this._supabase, this._isarService);

  // Fetch tasks (Network first, then Cache)
  Future<List<TaskModel>> getTasks() async {
    try {
      const selectColumns = [
        'id',
        'title',
        'description',
        'status',
        'priority',
        'requirements',
        'location',
        'participant_count',
        'creator_id',
        'created_at',
        'updated_at',
      ];
      // Supabase -> short timeout so the UI doesn't hang on web.
      final data = await _supabase
          .from('missions')
          .select(selectColumns.join(','))
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 12));

      final tasks = (data as List)
          .map((json) => TaskModel.fromSupabase(json as Map<String, dynamic>))
          .toList();
      final tasksWithIds = tasks
          .map((t) => t.copyWith(isarId: fastHash(t.id)))
          .toList();

      // Web builds don't ship Isar (per spec), so return immediately.
      if (kIsWeb) return tasksWithIds;

      // Cache to Isar
      final isar = await _isarService.db;
      await isar.writeTxn((isar) async {
        await isar.taskModels.putAll(tasksWithIds);
      });

      return tasksWithIds;
    } catch (e) {
      if (kIsWeb) {
        debugPrint('Task fetch failed on web: $e');
        rethrow;
      }

      // Fallback to Isar
      final isar = await _isarService.db;
      return await isar.taskModels.where().findAll();
    }
  }

  // Create Task (Offline first approach)
  Future<void> createTask(TaskModel task) async {
    final List<ConnectivityResult> connectivityStatus = await Connectivity()
        .checkConnectivity();
    final authorId = _supabase.auth.currentUser?.id ?? task.createdBy;

    final bool isOffline = connectivityStatus.contains(ConnectivityResult.none);

    if (isOffline && !kIsWeb) {
      final isar = await _isarService.db;
      final payload = task.toSupabasePayload(
        authorId: authorId ?? task.createdBy,
      );
      await OfflineQueueService.instance.enqueue(
        table: 'missions',
        payload: payload,
      );
      await isar.writeTxn((isar) async {
        await isar.taskModels.put(
          task.copyWith(isDraft: true, isarId: fastHash(task.id)),
        );
      });
      return;
    }

    // Send to server
    await _supabase
        .from('missions')
        .insert(task.toSupabasePayload(authorId: authorId));

    // Cache locally (skip on web)
    if (!kIsWeb) {
      final isar = await _isarService.db;
      await isar.writeTxn((isar) async {
        await isar.taskModels.put(
          task.copyWith(isDraft: false, isarId: fastHash(task.id)),
        );
      });
    }
  }

  // Sync Drafts
  Future<void> syncDrafts() async {
    final isar = await _isarService.db;
    final drafts = await isar.taskModels
        .filter()
        .isDraftEqualTo(true)
        .findAll();

    for (final task in drafts) {
      try {
        final authorId = _supabase.auth.currentUser?.id ?? task.createdBy;
        await _supabase
            .from('missions')
            .insert(task.toSupabasePayload(authorId: authorId));
        await isar.writeTxn((isar) async {
          await isar.taskModels.put(task.copyWith(isDraft: false));
        });
      } catch (e) {
        // Keep as draft
        print('Failed to sync task ${task.id}: $e');
      }
    }
  }

  Future<bool> isUserParticipant(String taskId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final rows =
        await _supabase
                .from('mission_participants')
                .select('user_id')
                .eq('mission_id', taskId)
                .eq('user_id', userId)
                .limit(1)
            as List;
    return rows.isNotEmpty;
  }

  Future<void> joinTask(String taskId, {bool isVisible = true}) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Check if user has already joined
    final alreadyJoined = await isUserParticipant(taskId);
    if (alreadyJoined) {
      debugPrint('User already joined task $taskId');
      return; // Silently return, user is already in the task
    }

    await _supabase.from('mission_participants').insert({
      'mission_id': taskId,
      'user_id': userId,
      'is_visible': isVisible,
    });
  }

  Future<void> leaveTask(String taskId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase
        .from('mission_participants')
        .delete()
        .eq('mission_id', taskId)
        .eq('user_id', userId);
  }

  Future<void> updateTask(TaskModel task) async {
    final authorId = _supabase.auth.currentUser?.id ?? task.createdBy;
    await _supabase
        .from('missions')
        .update(task.toSupabasePayload(authorId: authorId))
        .eq('id', task.id);
  }

  Future<void> completeTask(String taskId) async {
    await _supabase.from('missions').update({'status': 'done'}).eq('id', taskId);
  }

  Future<void> deleteTask(String taskId) async {
    await _supabase.from('missions').delete().eq('id', taskId);
  }

  Future<Set<String>> getJoinedTaskIds() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return {};

    final rows =
        await _supabase
                .from('mission_participants')
                .select('mission_id')
                .eq('user_id', userId)
            as List<dynamic>;

    return rows
        .map((row) => (row as Map<String, dynamic>)['mission_id'] as String)
        .toSet();
  }
}
