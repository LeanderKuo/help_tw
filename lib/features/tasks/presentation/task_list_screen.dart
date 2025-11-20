import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'task_controller.dart';
import '../../../models/task_model.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskControllerProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Tasks'),
              Tab(text: 'Drafts'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () {
                ref.read(taskControllerProvider.notifier).syncDrafts();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/tasks/create'),
            ),
          ],
        ),
        body: tasksAsync.when(
          data: (tasks) {
            final allTasks = tasks.where((t) => !t.isDraft).toList();
            final drafts = tasks.where((t) => t.isDraft).toList();

            return TabBarView(
              children: [
                _TaskListView(tasks: allTasks),
                _TaskListView(tasks: drafts, isDraft: true),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class _TaskListView extends StatelessWidget {
  final List<TaskModel> tasks;
  final bool isDraft;

  const _TaskListView({required this.tasks, this.isDraft = false});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks found.'));
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _getPriorityColor(task.priority),
            child: Text(task.priority[0]),
          ),
          title: Text(task.title),
          subtitle: Text(task.status),
          trailing: isDraft ? const Icon(Icons.cloud_off) : null,
          onTap: () {
            context.push('/tasks/${task.id}');
          },
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
      case 'Emergency':
        return Colors.red;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
