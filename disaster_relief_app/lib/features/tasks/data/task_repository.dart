import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../services/supabase_service.dart';
import '../../../services/isar_service.dart';
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
      final data = await _supabase
          .from('tasks')
          .select()
          .order('created_at', ascending: false);

      final tasks = (data as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();
      final tasksWithIds = tasks
          .map((t) => t.copyWith(isarId: fastHash(t.id)))
          .toList();

      // Cache to Isar
      final isar = await _isarService.db;
      await isar.writeTxn((isar) async {
        await isar.taskModels.putAll(tasksWithIds);
      });

      return tasksWithIds;
    } catch (e) {
      // Fallback to Isar
      final isar = await _isarService.db;
      return await isar.taskModels.where().findAll();
    }
  }

  // Create Task (Offline first approach)
  Future<void> createTask(TaskModel task) async {
    final isar = await _isarService.db;
    
    // 1. Save to local as draft (or not draft if we are optimistic)
    // For now, let's try to send to server, if fail, mark as draft.
    try {
      await _supabase.from('tasks').insert(task.toJson());
      // If success, save to local as synced
      await isar.writeTxn((isar) async {
        await isar.taskModels.put(
          task.copyWith(isDraft: false, isarId: fastHash(task.id)),
        );
      });
    } catch (e) {
      // If fail, save as draft
      await isar.writeTxn((isar) async {
        await isar.taskModels.put(
          task.copyWith(isDraft: true, isarId: fastHash(task.id)),
        );
      });
      rethrow; // Optional: rethrow to let UI know it's offline
    }
  }

  // Sync Drafts
  Future<void> syncDrafts() async {
    final isar = await _isarService.db;
    final drafts = await isar.taskModels.filter().isDraftEqualTo(true).findAll();

    for (final task in drafts) {
      try {
        await _supabase.from('tasks').insert(task.toJson());
        await isar.writeTxn((isar) async {
          await isar.taskModels.put(task.copyWith(isDraft: false));
        });
      } catch (e) {
        // Keep as draft
        print('Failed to sync task ${task.id}: $e');
      }
    }
  }
}
