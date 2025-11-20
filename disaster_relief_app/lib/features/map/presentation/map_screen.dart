import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import '../../resources/presentation/resource_controller.dart';
import '../../../models/resource_point.dart';
import '../../../l10n/app_localizations.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  
  // Default to Taiwan center
  static const CameraPosition _kDefaultLocation = CameraPosition(
    target: LatLng(23.6978, 120.9605),
    zoom: 7,
  );

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    await Permission.location.request();
  }

  Set<Marker> _createMarkers(List<ResourcePoint> resources) {
    return resources.map((resource) {
      return Marker(
        markerId: MarkerId(resource.id),
        position: LatLng(resource.latitude, resource.longitude),
        infoWindow: InfoWindow(
          title: resource.title,
          snippet: resource.type,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerHue(resource.type),
        ),
      );
    }).toSet();
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: resourcesAsync.when(
        data: (resources) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kDefaultLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _createMarkers(resources),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorWithMessage('$error'))),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
