import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/core/motion.dart';
import 'package:kanta_slip/core/widgets/app_scale_button.dart';
import 'package:kanta_slip/core/widgets/count_up_text.dart';
import 'package:kanta_slip/core/widgets/payment_success_check.dart';
import 'package:kanta_slip/core/widgets/staggered_list_row.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  testWidgets('CountUpText renders final formatted value instantly when animations are disabled', (tester) async {
    await AppMotion.setAnimationsSetting(false);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CountUpText(
            value: 12500,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );

    expect(find.text('₹12,500'), findsOneWidget);

    await AppMotion.setAnimationsSetting(true);
  });

  testWidgets('AppScaleButton executes onTap callback', (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppScaleButton(
            onTap: () => tapped = true,
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(tapped, isTrue);
  });

  testWidgets('StaggeredListRow and PaymentSuccessCheck build cleanly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              StaggeredListRow(index: 0, child: Text('Row 0')),
              PaymentSuccessCheck(size: 48),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Row 0'), findsOneWidget);
    expect(find.byType(PaymentSuccessCheck), findsOneWidget);
  });
}
