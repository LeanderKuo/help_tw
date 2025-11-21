import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../resources/presentation/resource_controller.dart';
import '../../tasks/data/task_repository.dart';
import '../../shuttles/data/shuttle_repository.dart';
import '../../../models/resource_point.dart';
import '../../../models/task_model.dart';
import '../../../models/shuttle_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/location_service.dart';

final tasksWithLocationProvider = FutureProvider<List<TaskModel>>((ref) async {
  final tasks = await ref.watch(taskRepositoryProvider).getTasks();
  return tasks.where((t) => t.latitude != null && t.longitude != null).toList();
});

final shuttlesWithLocationProvider = FutureProvider<List<ShuttleModel>>((
  ref,
) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  return shuttles
      .where((s) => s.routeStartLat != null && s.routeStartLng != null)
      .toList();
});

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Position? _userPosition;
  bool _locationLoading = false;
  String? _locationError;

  // Default to Taiwan center
  static const CameraPosition _kDefaultLocation = CameraPosition(
    target: LatLng(23.6978, 120.9605),
    zoom: 7,
  );

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  CameraPosition get _initialCamera {
    if (_userPosition != null) {
      return CameraPosition(
        target: LatLng(_userPosition!.latitude, _userPosition!.longitude),
        zoom: 13.5,
      );
    }
    return _kDefaultLocation;
  }

  Future<void> _initLocation() async {
    setState(() {
      _locationLoading = true;
      _locationError = null;
    });

    final position = await LocationService.currentPosition();
    if (!mounted) return;

    if (position == null) {
      setState(() {
        _locationError = '無法取得定位，請確認權限與定位服務。';
        _locationLoading = false;
      });
      return;
    }

    setState(() {
      _userPosition = position;
      _locationLoading = false;
      _locationError = null;
    });
    await _moveCamera(
      LatLng(position.latitude, position.longitude),
      zoom: 14.0,
    );
  }

  Future<void> _moveCamera(LatLng target, {double zoom = 14}) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
  }

  Set<Marker> _createMarkers(List<ResourcePoint> resources) {
    return resources.map((resource) {
      return Marker(
        markerId: MarkerId(resource.id),
        position: LatLng(resource.latitude, resource.longitude),
        infoWindow: InfoWindow(title: resource.title, snippet: resource.type),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerHue(resource.type),
        ),
      );
    }).toSet();
  }

  Set<Marker> _createTaskMarkers(List<TaskModel> tasks) {
    return tasks.where((t) => t.latitude != null && t.longitude != null).map((
      task,
    ) {
      return Marker(
        markerId: MarkerId('task-${task.id}'),
        position: LatLng(task.latitude!, task.longitude!),
        infoWindow: InfoWindow(title: task.title, snippet: task.roleLabel),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
    }).toSet();
  }

  Set<Marker> _createShuttleMarkers(List<ShuttleModel> shuttles) {
    final markers = <Marker>{};
    for (final shuttle in shuttles) {
      if (shuttle.routeStartLat != null && shuttle.routeStartLng != null) {
        markers.add(
          Marker(
            markerId: MarkerId('shuttle-origin-${shuttle.id}'),
            position: LatLng(shuttle.routeStartLat!, shuttle.routeStartLng!),
            infoWindow: InfoWindow(title: shuttle.title, snippet: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            ),
          ),
        );
      }
      if (shuttle.routeEndLat != null && shuttle.routeEndLng != null) {
        markers.add(
          Marker(
            markerId: MarkerId('shuttle-dest-${shuttle.id}'),
            position: LatLng(shuttle.routeEndLat!, shuttle.routeEndLng!),
            infoWindow: InfoWindow(
              title: shuttle.title,
              snippet: 'Destination',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          ),
        );
      }
    }
    return markers;
  }

  double _getMarkerHue(String type) {
    switch (type) {
      case 'Water':
        return BitmapDescriptor.hueBlue;
      case 'Shelter':
        return BitmapDescriptor.hueOrange;
      case 'Medical':
        return BitmapDescriptor.hueRed;
      case 'Food':
        return BitmapDescriptor.hueGreen;
      default:
        return BitmapDescriptor.hueViolet;
    }
  }

  @override
  Widget build(BuildContext context) {
    final resourcesAsync = ref.watch(resourceControllerProvider);
    final tasksAsync = ref.watch(tasksWithLocationProvider);
    final shuttlesAsync = ref.watch(shuttlesWithLocationProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          if (resourcesAsync.isLoading ||
              tasksAsync.isLoading ||
              shuttlesAsync.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (resourcesAsync.hasError ||
              tasksAsync.hasError ||
              shuttlesAsync.hasError)
            Center(
              child: Text(
                l10n.errorWithMessage(
                  '${resourcesAsync.error ?? tasksAsync.error ?? shuttlesAsync.error}',
                ),
              ),
            )
          else
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCamera,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                ..._createMarkers(resourcesAsync.value ?? const []),
                ..._createTaskMarkers(tasksAsync.value ?? const []),
                ..._createShuttleMarkers(shuttlesAsync.value ?? const []),
              },
              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
              },
            ),
          if (_locationLoading)
            const Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text('正在取得定位…'),
                    ],
                  ),
                ),
              ),
            ),
          if (_locationError != null)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _locationError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: _initLocation,
                        child: const Text('重試'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'locate',
            onPressed: _initLocation,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'list',
            onPressed: () => context.push('/map/resources'),
            child: const Icon(Icons.list),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () => context.push('/map/resources/create'),
            child: const Icon(Icons.add_location_alt),
          ),
        ],
      ),
    );
  }
}
