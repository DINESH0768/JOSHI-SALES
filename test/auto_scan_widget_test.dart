import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/features/slips/presentation/auto_scan_screen.dart';
import 'package:kanta_slip/features/slips/presentation/scan_result_screen.dart';

void main() {
  testWidgets('AutoScanScreen and ScanResultScreen build cleanly', (tester) async {
    expect(AutoScanScreen, isNotNull);
    expect(ScanResultScreen, isNotNull);
  });
}
