import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/shuttle_model.dart';
import '../data/shuttle_repository.dart';
import '../../auth/data/auth_repository.dart';
import 'shuttle_controller.dart';
import '../../../l10n/app_localizations.dart';

final shuttleDetailProvider = FutureProvider.family<ShuttleModel?, String>((ref, id) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  try {
    return shuttles.firstWhere((s) => s.id == id);
  } catch (e) {
    return null;
  }
});

class ShuttleDetailScreen extends ConsumerWidget {
  final String shuttleId;

  const ShuttleDetailScreen({required this.shuttleId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shuttleAsync = ref.watch(shuttleDetailProvider(shuttleId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.shuttleDetails)),
      body: shuttleAsync.when(
        data: (shuttle) {
          if (shuttle == null) return Center(child: Text(l10n.shuttleNotFound));
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(shuttle.routeStartLat ?? 25.0330, shuttle.routeStartLng ?? 121.5654),
                    zoom: 12,
                  ),
                  markers: {
                    if (shuttle.routeStartLat != null)
                      Marker(
                        markerId: const MarkerId('start'),
                        position: LatLng(shuttle.routeStartLat!, shuttle.routeStartLng!),
                        infoWindow: InfoWindow(title: l10n.startPoint),
                      ),
                    if (shuttle.routeEndLat != null)
                      Marker(
                        markerId: const MarkerId('end'),
                        position: LatLng(shuttle.routeEndLat!, shuttle.routeEndLng!),
                        infoWindow: InfoWindow(title: l10n.endPoint),
                      ),
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shuttle.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(l10n.statusWithValue(_statusLabel(shuttle.status, l10n))),
                    Text(l10n.capacityWithValue(shuttle.seatsTaken, shuttle.capacity)),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final user = ref.read(authRepositoryProvider).currentUser;
                          if (user != null) {
                            ref.read(shuttleControllerProvider.notifier).joinShuttle(shuttleId, user.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.joinedShuttleSuccess)),
                            );
                          }
                        },
                        child: Text(l10n.joinShuttle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(l10n.errorWithMessage('$e'))),
      ),
    );
  }
}

String _statusLabel(String status, AppLocalizations l10n) {
  switch (status.toLowerCase()) {
    case 'scheduled':
      return l10n.shuttleStatusScheduled;
    case 'en route':
      return l10n.shuttleStatusEnRoute;
    case 'arrived':
      return l10n.shuttleStatusArrived;
    case 'cancelled':
      return l10n.shuttleStatusCancelled;
    default:
      return status;
  }
}
