import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/core/services/hindi_number_speaker.dart';

void main() {
  test('HindiNumberSpeaker converts amounts into natural spoken Hindi words', () {
    expect(HindiNumberSpeaker.convertAmountToWords(0), 'shunya');
    expect(HindiNumberSpeaker.convertAmountToWords(50), 'pachaas');
    expect(HindiNumberSpeaker.convertAmountToWords(500), 'paanch sau');
    expect(HindiNumberSpeaker.convertAmountToWords(1500), 'pandrah sau');
    expect(HindiNumberSpeaker.convertAmountToWords(2345), 'do hazaar teen sau paintalis');
    expect(HindiNumberSpeaker.convertAmountToWords(12500), 'baarah hazaar paanch sau');
    expect(HindiNumberSpeaker.convertAmountToWords(184500), 'ek lakh churaasi hazaar paanch sau');
  });
}
