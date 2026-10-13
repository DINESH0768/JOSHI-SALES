import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/motion.dart';
import '../../core/widgets/floating_bottom_nav.dart';
import '../../data/db/app_database.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/income/presentation/aaj_ki_income_screen.dart';
import '../../features/income/presentation/kamai_history_screen.dart';
import '../../features/payments/presentation/payment_post_save_screen.dart';
import '../../features/payments/presentation/upi_payment_screen.dart';
import '../../features/pending/presentation/pending_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/slips/domain/services/ocr_parser.dart';
import '../../features/slips/presentation/auto_scan_screen.dart';
import '../../features/slips/presentation/new_slip_screen.dart';
import '../../features/slips/presentation/scan_result_screen.dart';
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

Page<dynamic> buildSmoothPage({required BuildContext context, required GoRouterState state, required Widget child}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: AppMotion.base,
    reverseTransitionDuration: AppMotion.base,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (!AppMotion.isAnimationsEnabled(context)) {
        return child;
      }
      final slideAnim = Tween<Offset>(
        begin: const Offset(0.0, 0.08),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: AppMotion.easeOutCubic));

      final fadeAnim = CurvedAnimation(parent: animation, curve: AppMotion.easeOutCubic);

      return FadeTransition(
        opacity: fadeAnim,
        child: SlideTransition(
          position: slideAnim,
          child: child,
        ),
      );
    },
  );
}

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: const SplashScreen()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: const SettingsScreen()),
    ),
    GoRoute(
      path: '/slips/new',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: NewSlipScreen(db: _db)),
    ),
    GoRoute(
      path: '/slips/scan',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: AutoScanScreen(db: _db)),
    ),
    GoRoute(
      path: '/slips/scan-result',
      pageBuilder: (context, state) {
        final extra = state.extra as ScannedSlipData?;
        final data = extra ??
            OcrParser.parseText(
                'रसीद नं. 1031\n11/10/2026\nमोहन लाल\nRJ 31 GA 0987\nगेहूं\nवाहन सहित माल 52,350 kg\nखाली तुलाने पर 13,450 kg');
        return buildSmoothPage(context: context, state: state, child: ScanResultScreen(scannedData: data, db: _db));
      },
    ),
    GoRoute(
      path: '/slips/card/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return buildSmoothPage(context: context, state: state, child: SlipCardScreen(slipId: id, db: _db));
      },
    ),
    GoRoute(
      path: '/payments/post-save/:slipId',
      pageBuilder: (context, state) {
        final slipId = state.pathParameters['slipId'] ?? '';
        return buildSmoothPage(context: context, state: state, child: PaymentPostSaveScreen(slipId: slipId, db: _db));
      },
    ),
    GoRoute(
      path: '/income/today',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: AajKiIncomeScreen(db: _db)),
    ),
    GoRoute(
      path: '/income/history',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: KamaiHistoryScreen(db: _db)),
    ),
    GoRoute(
      path: '/payments/upi/:slipId',
      pageBuilder: (context, state) {
        final slipId = state.pathParameters['slipId'] ?? '';
        return buildSmoothPage(context: context, state: state, child: UpiPaymentScreen(slipId: slipId, db: _db));
      },
    ),
    GoRoute(
      path: '/udhar/customer/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return buildSmoothPage(context: context, state: state, child: CustomerDetailScreen(customerId: id, db: _db));
      },
    ),
    GoRoute(
      path: '/udhar/rasid/:paymentId',
      pageBuilder: (context, state) {
        final paymentId = state.pathParameters['paymentId'] ?? '';
        return buildSmoothPage(context: context, state: state, child: JamaRasidScreen(paymentId: paymentId, db: _db));
      },
    ),
    GoRoute(
      path: '/kharcha/suppliers',
      pageBuilder: (context, state) => buildSmoothPage(context: context, state: state, child: SupplierListScreen(db: _db)),
    ),
    GoRoute(
      path: '/kharcha/suppliers/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return buildSmoothPage(context: context, state: state, child: SupplierDetailScreen(supplierId: id, db: _db));
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
