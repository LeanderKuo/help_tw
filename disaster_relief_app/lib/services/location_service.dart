import 'package:geolocator/geolocator.dart';

/// Thin wrapper around geolocator to keep permission + service checks in one place.
class LocationService {
  /// Ensures location services are enabled and permission is granted.
  static Future<bool> ensureServiceAndPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Returns the current position or null when unavailable/denied.
  static Future<Position?> currentPosition() async {
    final allowed = await ensureServiceAndPermission();
    if (!allowed) return null;

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (_) {
      return null;
    }
  }
}
