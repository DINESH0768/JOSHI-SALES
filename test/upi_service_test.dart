import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/features/payments/domain/services/upi_service.dart';

void main() {
  group('UpiService Unit Tests', () {
    test('buildUpiUri constructs correct standard UPI URI', () {
      final uri = UpiService.buildUpiUri(
        upiId: '9214848519@upi',
        payeeName: 'Joshi Kanta',
        amount: 800.0,
        note: 'Slip 1032',
      );

      expect(uri, 'upi://pay?pa=9214848519@upi&pn=Joshi%20Kanta&am=800.00&tn=Slip%201032');
    });
  });
}
