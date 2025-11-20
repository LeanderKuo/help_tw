import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/config/app_config.dart';

class SupabaseService {
  static Future<void> initialize() async {
    if (AppConfig.supabaseUrl.isEmpty || AppConfig.supabaseAnonKey.isEmpty) {
      throw Exception(
        'Missing Supabase config. Pass SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define at build/run time.',
      );
    }

    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
