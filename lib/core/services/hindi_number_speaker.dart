class HindiNumberSpeaker {
  static const List<String> _units = [
    '',
    'ek',
    'do',
    'teen',
    'chaar',
    'paanch',
    'chhah',
    'saat',
    'aath',
    'nau',
    'das',
    'gyaarah',
    'baarah',
    'terah',
    'chaudah',
    'pandrah',
    'soleh',
    'satraah',
    'athaarah',
    'unnees',
    'bees',
    'ikkees',
    'baas',
    'tees',
    'chaubees',
    'pachchees',
    'chhabbees',
    'sattaees',
    'atthaees',
    'unattees',
    'tees',
    'ikattees',
    'battees',
    'taintees',
    'chauntees',
    'paintees',
    'chattees',
    'saintees',
    'adhtees',
    'untalis',
    'chaalis',
    'iktaalis',
    'byaalis',
    'taintaalis',
    'chawalis',
    'paintalis',
    'chhiyalis',
    'saintaalis',
    'adhtaalis',
    'unchaas',
    'pachaas',
    'ikyaavan',
    'baavan',
    'tirpan',
    'chawwan',
    'pachpan',
    'chhappan',
    'sattaavan',
    'atthaavan',
    'unsath',
    'saath',
    'iksath',
    'baasath',
    'tirsath',
    'chaunsath',
    'painsath',
    'chhiyasaath',
    'satsath',
    'athsath',
    'unhattar',
    'sattar',
    'ikhattar',
    'bahattar',
    'tihattar',
    'chauhattar',
    'pachhattar',
    'chhihattar',
    'sathattar',
    'athhattar',
    'unasi',
    'assi',
    'ikyaasi',
    'byaasi',
    'tiraasi',
    'churaasi',
    'pachaasi',
    'chhiyaasi',
    'sattaasi',
    'atthaasi',
    'nawaasi',
    'nabbe',
    'ikyaanbe',
    'baanbe',
    'tiraanbe',
    'churaanbe',
    'pachaanbe',
    'chhiyaanbe',
    'sattaanbe',
    'atthaanbe',
    'ninyaanbe',
  ];

  static String convertAmountToWords(int amount) {
    if (amount <= 0) return 'shunya';

    // Special natural Hindi phrasing for 1100-1900 exact hundreds
    if (amount >= 1100 && amount <= 1900 && amount % 100 == 0) {
      final h = amount ~/ 100;
      return '${_units[h]} sau';
    }

    final buffer = StringBuffer();

    // Lakhs (1,00,000)
    final lakh = amount ~/ 100000;
    var remainder = amount % 100000;
    if (lakh > 0) {
      buffer.write('${convertAmountToWords(lakh)} lakh ');
    }

    // Thousands (1,000)
    final thousand = remainder ~/ 1000;
    remainder = remainder % 1000;
    if (thousand > 0) {
      buffer.write('${_getTwoDigitString(thousand)} hazaar ');
    }

    // Hundreds (100)
    final hundred = remainder ~/ 100;
    remainder = remainder % 100;
    if (hundred > 0) {
      buffer.write('${_getTwoDigitString(hundred)} sau ');
    }

    // Remainder (<100)
    if (remainder > 0) {
      buffer.write(_getTwoDigitString(remainder));
    }

    return buffer.toString().trim();
  }

  static String _getTwoDigitString(int n) {
    if (n >= 0 && n < _units.length) {
      return _units[n];
    }
    return n.toString();
  }
}
