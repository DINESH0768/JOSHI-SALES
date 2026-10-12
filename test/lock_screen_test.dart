import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/features/lock/presentation/lock_screen.dart';

void main() {
  testWidgets('LockScreen renders PIN input and unlock button', (tester) async {
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

    expect(find.text('Kanta Slip Security'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Unlock'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '1234');
    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();

    expect(unlocked, isTrue);
  });
}
