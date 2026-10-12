import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/main.dart';

void main() {
  testWidgets('Tapping + button on Home header navigates to Nayi slip screen', (tester) async {
    await tester.pumpWidget(const KantaSlipApp());
    await tester.pumpAndSettle();

    // Verify Home screen loaded
    expect(find.text('Kanta Slip'), findsWidgets);

    // Find and tap + button on Home header
    final plusFinder = find.byIcon(Icons.add_rounded);
    expect(plusFinder, findsWidgets);

    await tester.tap(plusFinder.first);
    await tester.pumpAndSettle();

    // Verify Nayi slip screen opened
    expect(find.text('Nayi slip'), findsOneWidget);
    expect(find.text('रसीद नं. (auto)'), findsOneWidget);
    expect(find.text('Save karo'), findsOneWidget);
  });
}
