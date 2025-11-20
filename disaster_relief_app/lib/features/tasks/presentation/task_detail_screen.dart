import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../models/task_model.dart';
import '../../../models/chat_message.dart';
import '../data/task_repository.dart';
import '../../chat/data/chat_repository.dart';
import '../../auth/data/auth_repository.dart';
import '../../../l10n/app_localizations.dart';

final taskDetailProvider = FutureProvider.family<TaskModel?, String>((ref, id) async {
  final tasks = await ref.watch(taskRepositoryProvider).getTasks();
  try {
    return tasks.firstWhere((t) => t.id == id);
  } catch (e) {
    return null;
  }
});

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>((ref, taskId) {
  return ref.watch(chatRepositoryProvider).subscribeToTaskMessages(taskId);
});

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailScreen({required this.taskId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskAsync = ref.watch(taskDetailProvider(taskId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.taskDetails)),
      body: taskAsync.when(
        data: (task) {
          if (task == null) return Center(child: Text(l10n.taskNotFound));
          return Column(
            children: [
              _buildTaskInfo(task, l10n),
              const Divider(),
              Expanded(child: _ChatSection(taskId: taskId)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(l10n.errorWithMessage('$e'))),
      ),
    );
  }

  Widget _buildTaskInfo(TaskModel task, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(label: Text(_statusLabel(task.status, l10n))),
              const SizedBox(width: 8),
              Chip(label: Text(_priorityLabel(task.priority, l10n))),
            ],
          ),
          const SizedBox(height: 8),
          Text(task.description ?? l10n.noDescriptionAvailable),
        ],
      ),
    );
  }
}

String _statusLabel(String status, AppLocalizations l10n) {
  switch (status.toLowerCase()) {
    case 'in_progress':
    case 'in progress':
      return l10n.taskStatusInProgress;
    case 'done':
    case 'completed':
      return l10n.taskStatusCompleted;
    case 'canceled':
    case 'cancelled':
      return l10n.taskStatusCancelled;
    default:
      return l10n.taskStatusOpen;
  }
}

String _priorityLabel(String priority, AppLocalizations l10n) {
  switch (priority.toLowerCase()) {
    case 'low':
      return l10n.priorityLow;
    case 'high':
      return l10n.priorityHigh;
    case 'emergency':
      return l10n.priorityEmergency;
    default:
      return l10n.priorityNormal;
  }
}

class _ChatSection extends ConsumerStatefulWidget {
  final String taskId;

  const _ChatSection({required this.taskId});

  @override
  ConsumerState<_ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends ConsumerState<_ChatSection> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final message = ChatMessage(
      id: '', // Supabase generates ID
      taskId: widget.taskId,
      senderId: user.id,
      content: _messageController.text,
    );

    ref.read(chatRepositoryProvider).sendTaskMessage(message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.taskId));
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              return ListView.builder(
                reverse: true, // Show newest at bottom if we reverse list, but stream is ordered asc.
                // Actually standard chat is bottom-up. Let's keep it simple.
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = msg.senderId == ref.read(authRepositoryProvider).currentUser?.id;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(msg.content ?? ''),
                          Text(
                            msg.createdAt != null ? timeago.format(msg.createdAt!) : '',
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text(l10n.errorLoadingChat('$e'))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: l10n.messageHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
