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
  final _titleZhController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descriptionZhController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  String _selectedType = 'Other';

  // Default to Taipei for now, ideally pick from map
  final double _latitude = 25.0330;
  final double _longitude = 121.5654;

  final List<String> _types = ['Water', 'Shelter', 'Medical', 'Food', 'Other'];

  @override
  void dispose() {
    _titleZhController.dispose();
    _titleEnController.dispose();
    _descriptionZhController.dispose();
    _descriptionEnController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Validate that both language versions are filled
      if (_titleZhController.text.trim().isEmpty ||
          _titleEnController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('請填寫中英文標題 / Please fill in both titles'),
          ),
        );
        return;
      }

      final newResource = ResourcePoint(
        id: const Uuid().v4(),
        title: _titleZhController.text.trim(),
        description: _descriptionZhController.text.trim(),
        type: _selectedType,
        latitude: _latitude,
        longitude: _longitude,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(resourceControllerProvider.notifier).addResourceWithTranslations(
        newResource,
        titleZh: _titleZhController.text.trim(),
        titleEn: _titleEnController.text.trim(),
        descriptionZh: _descriptionZhController.text.trim(),
        descriptionEn: _descriptionEnController.text.trim(),
      );

      if (mounted) context.pop();
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
              // Chinese Title
              TextFormField(
                controller: _titleZhController,
                decoration: const InputDecoration(
                  labelText: '標題 (中文) *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? '請填寫中文標題' : null,
              ),
              const SizedBox(height: 16),

              // English Title
              TextFormField(
                controller: _titleEnController,
                decoration: const InputDecoration(
                  labelText: 'Title (English) *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter English title' : null,
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

              // Chinese Description
              TextFormField(
                controller: _descriptionZhController,
                decoration: const InputDecoration(
                  labelText: '描述 (中文)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // English Description
              TextFormField(
                controller: _descriptionEnController,
                decoration: const InputDecoration(
                  labelText: 'Description (English)',
                  border: OutlineInputBorder(),
                ),
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
