import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../features/auth/data/auth_repository.dart';
import '../../../models/task_model.dart';
import '../data/task_repository.dart';
import 'task_controller.dart';

final joinedTaskIdsProvider = FutureProvider<Set<String>>((ref) {
  return ref.watch(taskRepositoryProvider).getJoinedTaskIds();
});

class MyTasksScreen extends ConsumerStatefulWidget {
  const MyTasksScreen({super.key});

  @override
  ConsumerState<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends ConsumerState<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _completeTask(TaskModel task) async {
    final confirmed = await _confirm(
      title: 'Complete task',
      message: 'Mark this task as completed?',
    );
    if (!confirmed) return;
    await ref.read(taskControllerProvider.notifier).completeTask(task.id);
    ref.invalidate(joinedTaskIdsProvider);
  }

  Future<void> _deleteTask(TaskModel task) async {
    final confirmed = await _confirm(
      title: 'Delete task',
      message: 'Delete ${task.title}? This cannot be undone.',
      isDestructive: true,
    );
    if (!confirmed) return;
    await ref.read(taskControllerProvider.notifier).deleteTask(task.id);
    ref.invalidate(joinedTaskIdsProvider);
  }

  Future<bool> _confirm({
    required String title,
    required String message,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              isDestructive ? 'Delete' : 'Confirm',
              style: TextStyle(
                color: isDestructive ? Colors.red : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskControllerProvider);
    final joinedAsync = ref.watch(joinedTaskIdsProvider);
    final role = ref.watch(currentUserRoleProvider);
    final userId = ref.watch(authRepositoryProvider).currentUser?.id;

    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: joinedAsync.when(
        data: (joinedIds) {
          return tasksAsync.when(
            data: (tasks) {
              final created = tasks
                  .where((t) => t.createdBy == userId && !_isHistory(t.status))
                  .toList();
              final inProgress = tasks
                  .where(
                    (t) => _isInProgress(t.status) && joinedIds.contains(t.id),
                  )
                  .toList();
              final history = tasks
                  .where(
                    (t) =>
                        _isHistory(t.status) &&
                        (t.createdBy == userId || joinedIds.contains(t.id)),
                  )
                  .toList();

              return Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondaryLight,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'Created'),
                      Tab(text: 'In Progress'),
                      Tab(text: 'History'),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref
                            .read(taskControllerProvider.notifier)
                            .loadTasks();
                        ref.invalidate(joinedTaskIdsProvider);
                      },
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _MyTaskList(
                            tasks: created,
                            emptyMessage: 'No tasks created yet.',
                            role: role,
                            currentUserId: userId,
                            onEdit: (task) => context.push(
                              '/tasks/${task.id}/edit',
                              extra: task,
                            ),
                            onComplete: _completeTask,
                            onDelete: _deleteTask,
                          ),
                          _MyTaskList(
                            tasks: inProgress,
                            emptyMessage: 'No tasks in progress.',
                            role: role,
                            currentUserId: userId,
                            onEdit: null,
                            onComplete: _completeTask,
                            onDelete: null,
                          ),
                          _MyTaskList(
                            tasks: history,
                            emptyMessage: 'No completed tasks yet.',
                            role: role,
                            currentUserId: userId,
                            isHistory: true,
                            onEdit: null,
                            onComplete: null,
                            onDelete: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => EmptyState(
              icon: Icons.error_outline,
              title: 'Load failed',
              message: error.toString(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => EmptyState(
          icon: Icons.error_outline,
          title: 'Load failed',
          message: error.toString(),
        ),
      ),
    );
  }
}

class _MyTaskList extends StatelessWidget {
  const _MyTaskList({
    required this.tasks,
    required this.emptyMessage,
    required this.role,
    required this.currentUserId,
    this.isHistory = false,
    this.onEdit,
    this.onComplete,
    this.onDelete,
  });

  final List<TaskModel> tasks;
  final String emptyMessage;
  final AppRole role;
  final String? currentUserId;
  final bool isHistory;
  final void Function(TaskModel task)? onEdit;
  final void Function(TaskModel task)? onComplete;
  final void Function(TaskModel task)? onDelete;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyState(
        icon: Icons.task_alt,
        title: emptyMessage,
        message: 'Tasks you create or join will appear here.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _MyTaskCard(
          task: task,
          isHistory: isHistory,
          role: role,
          isAuthor: currentUserId != null && task.createdBy == currentUserId,
          onEdit: onEdit,
          onComplete: onComplete,
          onDelete: onDelete,
        );
      },
    );
  }
}

class _MyTaskCard extends StatelessWidget {
  const _MyTaskCard({
    required this.task,
    required this.isHistory,
    required this.role,
    required this.isAuthor,
    this.onEdit,
    this.onComplete,
    this.onDelete,
  });

  final TaskModel task;
  final bool isHistory;
  final AppRole role;
  final bool isAuthor;
  final void Function(TaskModel task)? onEdit;
  final void Function(TaskModel task)? onComplete;
  final void Function(TaskModel task)? onDelete;

  bool get _isComplete =>
      task.status.toLowerCase() == 'done' ||
      task.status.toLowerCase() == 'canceled';

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(task.status);
    final requiredText = task.requiredParticipants <= 0
        ? 'n/a'
        : '${task.requiredParticipants}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () => context.push('/tasks/${task.id}'),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatusChip(
                    label: _statusLabel(task.status),
                    backgroundColor: statusColor.withValues(alpha: 0.12),
                    textColor: statusColor,
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(task.updatedAt ?? task.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              if (task.description != null && task.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    task.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondaryLight),
                  ),
                ),
              const SizedBox(height: 8),
              _infoTile(
                icon: Icons.place_outlined,
                label: task.address ?? 'Location not set',
              ),
              _infoTile(
                icon: Icons.people_alt_outlined,
                label: 'Participants: ${task.participantCount} / $requiredText',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => context.push('/tasks/${task.id}'),
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      label: const Text('Details'),
                    ),
                  ),
                  if (isAuthor && onEdit != null && !_isComplete)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => onEdit!(task),
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit'),
                      ),
                    ),
                  if (onComplete != null && !_isComplete) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (isAuthor || role.isLeaderOrAbove)
                            ? () => onComplete!(task)
                            : null,
                        icon: const Icon(Icons.check_circle, size: 18),
                        label: const Text('Complete'),
                      ),
                    ),
                  ],
                  if (onDelete != null && isAuthor && !_isComplete)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.redAccent,
                        onPressed: () => onDelete!(task),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondaryLight),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondaryLight),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColors.primary;
      case 'in_progress':
      case 'in progress':
        return AppColors.warning;
      case 'done':
        return AppColors.success;
      case 'canceled':
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return 'Open';
      case 'in_progress':
      case 'in progress':
        return 'In progress';
      case 'done':
        return 'Completed';
      case 'canceled':
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
}

bool _isInProgress(String status) {
  final normalized = status.toLowerCase();
  return normalized == 'in_progress' || normalized == 'in progress';
}

bool _isHistory(String status) {
  final normalized = status.toLowerCase();
  return normalized == 'done' || normalized == 'canceled';
}
