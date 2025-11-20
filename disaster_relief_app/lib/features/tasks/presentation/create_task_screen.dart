import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'task_controller.dart';
import '../../../models/task_model.dart';
import '../../../l10n/app_localizations.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _priority = 'Normal';

  final List<String> _priorities = ['Low', 'Normal', 'High', 'Emergency'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newTask = TaskModel(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        priority: _priority,
        status: 'Open',
        materialsStatus: '穩定',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(taskControllerProvider.notifier).createTask(newTask);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.createTask)),
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
                child: Text(l10n.createTask),
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
