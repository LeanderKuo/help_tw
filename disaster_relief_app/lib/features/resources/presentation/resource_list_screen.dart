import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'resource_controller.dart';

class ResourceListScreen extends ConsumerWidget {
  const ResourceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourcesAsync = ref.watch(resourceControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/resources/create'),
          ),
        ],
      ),
      body: resourcesAsync.when(
        data: (resources) {
          if (resources.isEmpty) {
            return const Center(child: Text('No resources found.'));
          }
          return ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(_getIconForType(resource.type)),
                ),
                title: Text(resource.title),
                subtitle: Text(
                  '${resource.type} • ${resource.description ?? ""}',
                ),
                onTap: () {
                  // TODO: Navigate to detail
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Water':
        return Icons.water_drop;
      case 'Shelter':
        return Icons.home;
      case 'Medical':
        return Icons.local_hospital;
      case 'Food':
        return Icons.restaurant;
      default:
        return Icons.place;
    }
  }
}
