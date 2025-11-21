import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'services/supabase_service.dart';
import 'services/offline_queue_service.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/app_language.dart';
import 'core/localization/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  // Initialize Services
  await SupabaseService.initialize();
  await OfflineQueueService.instance.initialize();

  runApp(const ProviderScope(child: DisasterReliefApp()));
}

class DisasterReliefApp extends ConsumerWidget {
  const DisasterReliefApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final localeState = ref.watch(localeControllerProvider);
    final selectedLocale = localeState.when(
      data: (language) => language.locale,
      loading: () => const Locale('zh', 'TW'),
      error: (_, __) => const Locale('zh', 'TW'),
    );

    return MaterialApp.router(
      title: AppConfig.appName,
      locale: selectedLocale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: router,

      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('en', 'US'),
        Locale('zh'),
        Locale('zh', 'TW'),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // Prefer the selected locale by language code; fall back to device, else first supported.
        final selectedMatch = supportedLocales.firstWhere(
          (l) => l.languageCode == selectedLocale.languageCode,
          orElse: () => supportedLocales.first,
        );
        return selectedMatch;
      },
    );
  }
}
