import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';
import 'package:kanta_slip/features/slips/presentation/new_slip_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('NewSlipScreen saves slip to database when form is valid', (WidgetTester tester) async {
    // Set explicit physical screen dimensions for CI environment
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    bool navigated = false;

    final router = GoRouter(
      initialLocation: '/slips/new',
      routes: [
        GoRoute(
          path: '/slips/new',
          builder: (context, state) => NewSlipScreen(db: db),
        ),
        GoRoute(
          path: '/payments/post-save/:slipId',
          builder: (context, state) {
            navigated = true;
            return const Scaffold(body: Text('Payment Post Save'));
          },
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));

    // Verify screen title
    expect(find.text('Nayi slip'), findsOneWidget);

    // Fill customer name, vehicle, weights, charge
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(2), 'Suresh Kumar'); // customer name
    await tester.enterText(fields.at(3), 'RJ 31 GA 5555'); // vehicle no
    await tester.enterText(fields.at(5), '25000'); // gross 1
    await tester.enterText(fields.at(6), '5000'); // tare 1
    await tester.enterText(fields.at(9), '400'); // charge

    await tester.pump(const Duration(milliseconds: 300));

    // Tap Save karo button using Key('save_slip_button')
    final saveBtnKey = find.byKey(const Key('save_slip_button'));
    expect(saveBtnKey, findsOneWidget);

    await tester.ensureVisible(saveBtnKey);
    await tester.tap(saveBtnKey);
    await tester.pump(const Duration(milliseconds: 500));

    // Verify database record
    final repo = SlipRepository(db);
    final allSlips = await repo.getAllSlips();
    expect(allSlips.isNotEmpty, isTrue);

    final saved = allSlips.firstWhere((s) => s.customerName == 'Suresh Kumar');
    expect(saved.customerName, 'Suresh Kumar');
    expect(saved.vehicleNo, 'RJ 31 GA 5555');
    expect(saved.charge, 400);

    // Verify rounds
    final rounds = await repo.getRoundsForSlip(saved.id);
    expect(rounds.isNotEmpty, isTrue);
    expect(rounds.first.grossKg, 25000);
    expect(rounds.first.emptyTulaneKg, 5000);
    expect(rounds.first.netKg, 20000);

    expect(navigated, isTrue);
  }, timeout: const Timeout(Duration(seconds: 15)));
}
