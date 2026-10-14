import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/core/utils/hindi_number_to_words.dart';

void main() {
  group('Hindi Number to Words Tests', () {
    test('Converts 0, single digits, teens', () {
      expect(hindiNumberToWords(0), 'शून्य रुपये मात्र');
      expect(hindiNumberToWords(5), 'पाँच रुपये मात्र');
      expect(hindiNumberToWords(10), 'दस रुपये मात्र');
      expect(hindiNumberToWords(50), 'पचास रुपये मात्र');
      expect(hindiNumberToWords(99), 'निन्नान्वे रुपये मात्र');
    });

    test('Converts hundreds and thousands', () {
      expect(hindiNumberToWords(100), 'एक सौ रुपये मात्र');
      expect(hindiNumberToWords(500), 'पाँच सौ रुपये मात्र');
      expect(hindiNumberToWords(1032), 'एक हजार बत्तीस रुपये मात्र');
      expect(hindiNumberToWords(2500), 'दो हजार पाँच सौ रुपये मात्र');
      expect(hindiNumberToWords(15000), 'पंद्रह हजार रुपये मात्र');
      expect(hindiNumberToWords(50000), 'पचास हजार रुपये मात्र');
    });

    test('Converts lakhs', () {
      expect(hindiNumberToWords(100000), 'एक लाख रुपये मात्र');
      expect(hindiNumberToWords(250000), 'दो लाख पचास हजार रुपये मात्र');
    });
  });
}
