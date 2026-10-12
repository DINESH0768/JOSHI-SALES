import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/core/widgets/floating_bottom_nav.dart';

void main() {
  testWidgets('FloatingBottomNav renders 5 items and responds to tap', (tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: FloatingBottomNav(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
            },
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long_rounded), findsOneWidget);
    expect(find.byIcon(Icons.pending_actions_rounded), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
    expect(find.byIcon(Icons.payments_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.pending_actions_rounded));
    expect(selectedIndex, equals(2));
  });
}
