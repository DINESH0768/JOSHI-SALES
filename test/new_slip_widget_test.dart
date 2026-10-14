import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Sanity check widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Kanta Slip'),
        ),
      ),
    );
    expect(find.text('Kanta Slip'), findsOneWidget);
  });
}
