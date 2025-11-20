import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/announcements/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/map/presentation/map_screen.dart';
import '../../features/resources/presentation/resource_list_screen.dart';
import '../../features/resources/presentation/create_resource_screen.dart';
import '../../features/tasks/presentation/task_list_screen.dart';
import '../../features/tasks/presentation/create_task_screen.dart';
import '../../features/tasks/presentation/task_detail_screen.dart';
import '../../features/shuttles/presentation/shuttle_list_screen.dart';
import '../../features/shuttles/presentation/shuttle_detail_screen.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../features/announcements/data/announcement_repository.dart';
import '../widgets/global_chrome.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      // ShellRoute for Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/map',
            builder: (context, state) => const MapScreen(),
            routes: [
              GoRoute(
                path: 'resources',
                builder: (context, state) => const ResourceListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreateResourceScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TaskListScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateTaskScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    TaskDetailScreen(taskId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: '/shuttles',
            builder: (context, state) => const ShuttleListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    ShuttleDetailScreen(shuttleId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final session = authRepository.currentUser;
      final isLoggingIn =
          state.uri.path == '/login' || state.uri.path == '/register';

      if (session == null && !isLoggingIn) {
        return '/login';
      }

      if (session != null && isLoggingIn) {
        return '/home';
      }

      if (session != null && state.uri.path == '/') {
        return '/home';
      }

      return null;
    },
  );
});

class ScaffoldWithBottomNavBar extends ConsumerWidget {
  const ScaffoldWithBottomNavBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final emergencyAsync = ref.watch(activeEmergencyAnnouncementProvider);
    final hasMarquee = emergencyAsync.maybeWhen(
      data: (a) => a != null,
      orElse: () => false,
    );
    const marqueeHeight = 52.0;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPadding(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: hasMarquee ? marqueeHeight : 0),
            child: child,
          ),
          const EmergencyMarquee(height: marqueeHeight),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: hasMarquee ? marqueeHeight : 0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _calculateSelectedIndex(context),
          onTap: (int idx) => _onItemTapped(idx, context),
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
            BottomNavigationBarItem(icon: const Icon(Icons.map), label: l10n.map),
            BottomNavigationBarItem(icon: const Icon(Icons.task), label: l10n.tasks),
            BottomNavigationBarItem(
              icon: const Icon(Icons.directions_bus),
              label: l10n.shuttles,
            ),
            BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n.profile),
          ],
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/map')) return 1;
    if (location.startsWith('/tasks')) return 2;
    if (location.startsWith('/shuttles')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/map');
        break;
      case 2:
        GoRouter.of(context).go('/tasks');
        break;
      case 3:
        GoRouter.of(context).go('/shuttles');
        break;
      case 4:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
