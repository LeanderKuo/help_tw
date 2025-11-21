import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String appName = 'Disaster Relief';

  // Build-time dart-define values remain the primary source; fall back to .env.
  static String get supabaseUrl {
    const define = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    if (define.isNotEmpty) return define;
    return dotenv.env['SUPABASE_URL'] ?? '';
  }

  static String get supabaseAnonKey {
    const define = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );
    if (define.isNotEmpty) return define;
    return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  }

  static String get googleMapsApiKey {
    const define = String.fromEnvironment(
      'GOOGLE_MAPS_API_KEY',
      defaultValue: '',
    );
    if (define.isNotEmpty) return define;
    return dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  }

  // Feature Flags
  static const bool enableCapAlerts = true;
}
