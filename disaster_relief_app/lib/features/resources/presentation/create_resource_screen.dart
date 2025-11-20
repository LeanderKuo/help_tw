import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'resource_controller.dart';
import '../../../models/resource_point.dart';

class CreateResourceScreen extends ConsumerStatefulWidget {
  const CreateResourceScreen({super.key});

  @override
  ConsumerState<CreateResourceScreen> createState() => _CreateResourceScreenState();
}

class _CreateResourceScreenState extends ConsumerState<CreateResourceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'Other';
  
  // Default to Taipei for now, ideally pick from map
  double _latitude = 25.0330;
  double _longitude = 121.5654;

  final List<String> _types = ['Water', 'Shelter', 'Medical', 'Food', 'Other'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newResource = ResourcePoint(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        type: _selectedType,
        latitude: _latitude,
        longitude: _longitude,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(resourceControllerProvider.notifier).addResource(newResource);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Resource')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: _types.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              // TODO: Add Map Picker
              Text('Location: $_latitude, $_longitude'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create Resource'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
