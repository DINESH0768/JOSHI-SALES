import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/floating_bottom_nav.dart';
import '../../core/widgets/placeholder_screen.dart';
import '../../data/db/app_database.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/slips/presentation/new_slip_screen.dart';
import '../../features/slips/presentation/slip_card_screen.dart';
import '../../features/slips/presentation/slips_list_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final AppDatabase _db = AppDatabase();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/slips/new',
      builder: (context, state) => NewSlipScreen(db: _db),
    ),
    GoRoute(
      path: '/slips/card/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return SlipCardScreen(slipId: id, db: _db);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: navigationShell),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: FloatingBottomNav(
                  currentIndex: navigationShell.currentIndex,
                  onTap: (newIndex) {
                    navigationShell.goBranch(
                      newIndex,
                      initialLocation: newIndex == navigationShell.currentIndex,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/slips',
              builder: (context, state) => SlipsListScreen(db: _db),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/pending',
              builder: (context, state) => const PlaceholderScreen(title: 'Pending'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/udhar',
              builder: (context, state) => const PlaceholderScreen(title: 'Udhar'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/kharcha',
              builder: (context, state) => const PlaceholderScreen(title: 'Kharcha'),
            ),
          ],
        ),
      ],
    ),
  ],
);
