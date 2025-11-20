import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'services/supabase_service.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/app_language.dart';
import 'core/localization/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Services
  await SupabaseService.initialize();

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
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (supportedLocales.contains(selectedLocale)) return selectedLocale;
        return supportedLocales.first;
      },
    );
  }
}
