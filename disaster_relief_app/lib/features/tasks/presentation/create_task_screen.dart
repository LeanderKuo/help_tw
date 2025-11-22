import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'task_controller.dart';
import '../../../models/task_model.dart';
import '../../../l10n/app_localizations.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key, this.task, this.isEditing = false});

  final TaskModel? task;
  final bool isEditing;

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late String _priority;

  final List<String> _priorities = ['Low', 'Normal', 'High', 'Emergency'];

  @override
  void initState() {
    super.initState();
    _priority = widget.task?.priority ?? 'Normal';
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final isEditing = widget.isEditing && widget.task != null;
      final task = isEditing
          ? widget.task!.copyWith(
              title: _titleController.text,
              description: _descriptionController.text,
              priority: _priority,
              updatedAt: now,
            )
          : TaskModel(
              id: const Uuid().v4(),
              title: _titleController.text,
              description: _descriptionController.text,
              priority: _priority,
              status: 'Open',
              materialsStatus: '穩定',
              createdAt: now,
              updatedAt: now,
            );

      try {
        if (isEditing) {
          await ref.read(taskControllerProvider.notifier).updateTask(task);
        } else {
          await ref.read(taskControllerProvider.notifier).createTask(task);
        }
        if (mounted) context.pop();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('建立失敗: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final titleText = widget.isEditing ? 'Edit task' : l10n.createTask;
    return Scaffold(
      appBar: AppBar(title: Text(titleText)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: l10n.titleLabel),
                validator: (value) =>
                    value == null || value.isEmpty ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _priority,
                decoration: InputDecoration(labelText: l10n.priorityLabel),
                items: _priorities.map((p) {
                  return DropdownMenuItem(
                    value: p,
                    child: Text(_priorityLabel(p, l10n)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: l10n.descriptionLabel),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.isEditing ? 'Update task' : l10n.createTask),
              ),
            ],
          ),
        ),
      ),
    );
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
}
