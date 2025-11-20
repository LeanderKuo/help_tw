import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/task_model.dart';
import '../data/task_repository.dart';

final taskControllerProvider =
    StateNotifierProvider<TaskController, AsyncValue<List<TaskModel>>>((ref) {
  return TaskController(ref.watch(taskRepositoryProvider));
});

class TaskController extends StateNotifier<AsyncValue<List<TaskModel>>> {
  final TaskRepository _repository;

  TaskController(this._repository) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getTasks());
  }

  Future<void> createTask(TaskModel task) async {
    await _repository.createTask(task);
    await loadTasks();
  }

  Future<void> syncDrafts() async {
    await _repository.syncDrafts();
    await loadTasks();
  }
}
