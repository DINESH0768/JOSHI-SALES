import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/features/lock/presentation/lock_screen.dart';

void main() {
  testWidgets('LockScreen renders keypad digits and fingerprint icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LockScreen(
          onUnlocked: () {},
        ),
      ),
    );

    expect(find.text('Kanta Slip Security'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint), findsOneWidget);
    expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
  });

  testWidgets('Entering correct 4-digit PIN triggers onUnlocked', (tester) async {
    bool unlocked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: LockScreen(
          onUnlocked: () {
            unlocked = true;
          },
        ),
      ),
    );

    // Default pin is 1234
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('4'));
    await tester.pumpAndSettle();

    expect(unlocked, isTrue);
  });

  testWidgets('Entering wrong 4-digit PIN displays error text', (tester) async {
    bool unlocked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: LockScreen(
          onUnlocked: () {
            unlocked = true;
          },
        ),
      ),
    );

    // Enter wrong PIN: 9999
    await tester.tap(find.text('9'));
    await tester.pump();
    await tester.tap(find.text('9'));
    await tester.pump();
    await tester.tap(find.text('9'));
    await tester.pump();
    await tester.tap(find.text('9'));
    await tester.pump();

    expect(find.text('Galat PIN, phir se koshish karein'), findsOneWidget);
    expect(unlocked, isFalse);
  });
}
