import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/floating_bottom_nav.dart';
import '../../data/db/app_database.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/income/presentation/aaj_ki_income_screen.dart';
import '../../features/income/presentation/kamai_history_screen.dart';
import '../../features/payments/presentation/payment_post_save_screen.dart';
import '../../features/payments/presentation/upi_payment_screen.dart';
import '../../features/pending/presentation/pending_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/slips/presentation/new_slip_screen.dart';
import '../../features/slips/presentation/slip_card_screen.dart';
import '../../features/slips/presentation/slips_list_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/kharcha/presentation/kharcha_screen.dart';
import '../../features/kharcha/presentation/supplier_detail_screen.dart';
import '../../features/kharcha/presentation/supplier_list_screen.dart';
import '../../features/udhar/presentation/customer_detail_screen.dart';
import '../../features/udhar/presentation/jama_rasid_screen.dart';
import '../../features/udhar/presentation/udhar_list_screen.dart';

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
    GoRoute(
      path: '/payments/post-save/:slipId',
      builder: (context, state) {
        final slipId = state.pathParameters['slipId'] ?? '';
        return PaymentPostSaveScreen(slipId: slipId, db: _db);
      },
    ),
    GoRoute(
      path: '/income/today',
      builder: (context, state) => AajKiIncomeScreen(db: _db),
    ),
    GoRoute(
      path: '/income/history',
      builder: (context, state) => KamaiHistoryScreen(db: _db),
    ),
    GoRoute(
      path: '/payments/upi/:slipId',
      builder: (context, state) {
        final slipId = state.pathParameters['slipId'] ?? '';
        return UpiPaymentScreen(slipId: slipId, db: _db);
      },
    ),
    GoRoute(
      path: '/udhar/customer/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return CustomerDetailScreen(customerId: id, db: _db);
      },
    ),
    GoRoute(
      path: '/udhar/rasid/:paymentId',
      builder: (context, state) {
        final paymentId = state.pathParameters['paymentId'] ?? '';
        return JamaRasidScreen(paymentId: paymentId, db: _db);
      },
    ),
    GoRoute(
      path: '/kharcha/suppliers',
      builder: (context, state) => SupplierListScreen(db: _db),
    ),
    GoRoute(
      path: '/kharcha/suppliers/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return SupplierDetailScreen(supplierId: id, db: _db);
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
              builder: (context, state) => HomeScreen(db: _db),
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
              builder: (context, state) => PendingScreen(db: _db),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/udhar',
              builder: (context, state) => UdharListScreen(db: _db),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/kharcha',
              builder: (context, state) => KharchaScreen(db: _db),
            ),
          ],
        ),
      ],
    ),
  ],
);
