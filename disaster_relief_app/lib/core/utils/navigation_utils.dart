import 'package:url_launcher/url_launcher.dart';

Future<void> launchGoogleMapsNavigation({
  required double lat,
  required double lng,
}) async {
  final url = Uri.parse(
    'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
  );
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw Exception('Could not launch Google Maps');
  }
}
