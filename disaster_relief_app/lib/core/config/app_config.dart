class AppConfig {
  static const String appName = 'Disaster Relief';

  // Read at build time via `--dart-define`.
  static const String supabaseUrl =
      String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  static const String googleMapsApiKey = 'AIzaSyBlZKrqGHxzspAmMO1Edy2DNAxNWsY3heg';

  // Feature Flags
  static const bool enableCapAlerts = true;
}
