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
    await tester.enterText(fields.at(8), '400'); // charge

    await tester.pump(const Duration(milliseconds: 300));

    // Tap Save karo button
    final saveBtn = find.text('Save karo');
    expect(saveBtn, findsOneWidget);

    await tester.tap(saveBtn);
    await tester.pump(const Duration(milliseconds: 500));

    // Verify database record
    final repo = SlipRepository(db);
    final allSlips = await repo.getAllSlips();
    expect(allSlips.isNotEmpty, isTrue);

    final saved = allSlips.first;
    expect(saved.customerName, 'Suresh Kumar');
    expect(saved.vehicleNo, 'RJ 31 GA 5555');
    expect(saved.charge, 400);
    expect(navigated, isTrue);
  });
}
