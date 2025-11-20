import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'resource_controller.dart';
import '../../../models/resource_point.dart';
import '../../../l10n/app_localizations.dart';

class CreateResourceScreen extends ConsumerStatefulWidget {
  const CreateResourceScreen({super.key});

  @override
  ConsumerState<CreateResourceScreen> createState() =>
      _CreateResourceScreenState();
}

class _CreateResourceScreenState extends ConsumerState<CreateResourceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'Other';

  // Default to Taipei for now, ideally pick from map
  final double _latitude = 25.0330;
  final double _longitude = 121.5654;

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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addResource)),
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
                initialValue: _selectedType,
                decoration: InputDecoration(labelText: l10n.typeLabel),
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_typeLabel(type, l10n)),
                  );
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
                decoration: InputDecoration(labelText: l10n.descriptionLabel),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              // TODO: Add Map Picker
              Text('${l10n.locationLabel}: $_latitude, $_longitude'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.createResource),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(String type, AppLocalizations l10n) {
    switch (type) {
      case 'Water':
        return l10n.resourceTypeWater;
      case 'Shelter':
        return l10n.resourceTypeShelter;
      case 'Medical':
        return l10n.resourceTypeMedical;
      case 'Food':
        return l10n.resourceTypeFood;
      case 'Other':
      default:
        return l10n.resourceTypeOther;
    }
  }
}
