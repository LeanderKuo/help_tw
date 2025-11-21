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

  Future<void> joinTask(String taskId, {bool isVisible = true}) async {
    await _repository.joinTask(taskId, isVisible: isVisible);
    await loadTasks();
  }

  Future<void> leaveTask(String taskId) async {
    await _repository.leaveTask(taskId);
    await loadTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    await _repository.updateTask(task);
    await loadTasks();
  }

  Future<void> completeTask(String taskId) async {
    await _repository.completeTask(taskId);
    await loadTasks();
  }

  Future<void> deleteTask(String taskId) async {
    await _repository.deleteTask(taskId);
    await loadTasks();
  }

  Future<Set<String>> myJoinedTaskIds() {
    return _repository.getJoinedTaskIds();
  }
}
