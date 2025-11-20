import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'shuttle_controller.dart';

class ShuttleListScreen extends ConsumerWidget {
  const ShuttleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shuttlesAsync = ref.watch(shuttleControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shuttles')),
      body: shuttlesAsync.when(
        data: (shuttles) {
          if (shuttles.isEmpty) {
            return const Center(child: Text('No shuttles available.'));
          }
          return ListView.builder(
            itemCount: shuttles.length,
            itemBuilder: (context, index) {
              final shuttle = shuttles[index];
              return ListTile(
                leading: const Icon(Icons.directions_bus),
                title: Text(shuttle.title),
                subtitle: Text('${shuttle.status} • ${shuttle.seatsTaken}/${shuttle.capacity} seats'),
                onTap: () {
                  context.push('/shuttles/${shuttle.id}');
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
