import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/floating_bottom_nav.dart';
import '../../core/widgets/placeholder_screen.dart';
import '../../features/home/presentation/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        int index = 0;
        final location = state.uri.toString();
        if (location.startsWith('/slips')) {
          index = 1;
        } else if (location.startsWith('/pending')) {
          index = 2;
        } else if (location.startsWith('/udhar')) {
          index = 3;
        } else if (location.startsWith('/kharcha')) {
          index = 4;
        }

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: child),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: FloatingBottomNav(
                  currentIndex: index,
                  onTap: (newIndex) {
                    switch (newIndex) {
                      case 0:
                        context.go('/home');
                        break;
                      case 1:
                        context.go('/slips');
                        break;
                      case 2:
                        context.go('/pending');
                        break;
                      case 3:
                        context.go('/udhar');
                        break;
                      case 4:
                        context.go('/kharcha');
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/slips',
          builder: (context, state) => const PlaceholderScreen(title: 'Slips'),
        ),
        GoRoute(
          path: '/pending',
          builder: (context, state) => const PlaceholderScreen(title: 'Pending'),
        ),
        GoRoute(
          path: '/udhar',
          builder: (context, state) => const PlaceholderScreen(title: 'Udhar'),
        ),
        GoRoute(
          path: '/kharcha',
          builder: (context, state) => const PlaceholderScreen(title: 'Kharcha'),
        ),
      ],
    ),
  ],
);
