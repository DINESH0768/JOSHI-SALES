class FieldWithConfidence<T> {
  final T? value;
  final String confidence; // 'high' or 'low'

  FieldWithConfidence(this.value, [this.confidence = 'high']);

  bool get isHigh => confidence == 'high';
  bool get isLow => confidence == 'low';
}

class ScannedSlipData {
  final FieldWithConfidence<int> receiptNo;
  final FieldWithConfidence<String> dateStr;
  final FieldWithConfidence<String> customerName;
  final FieldWithConfidence<String> vehicleNo;
  final FieldWithConfidence<String> material;
  final FieldWithConfidence<int> grossKg;
  final FieldWithConfidence<int> tareKg;
  final FieldWithConfidence<int> emptyDriverKg;
  final String? scanPhotoPath;
  final bool isDuplicate;

  ScannedSlipData({
    required this.receiptNo,
    required this.dateStr,
    required this.customerName,
    required this.vehicleNo,
    required this.material,
    required this.grossKg,
    required this.tareKg,
    required this.emptyDriverKg,
    this.scanPhotoPath,
    this.isDuplicate = false,
  });

  // Net weight auto-recomputed
  int get calculatedNetKg {
    final g = grossKg.value ?? 0;
    final t = tareKg.value ?? 0;
    return g > t ? (g - t) : 0;
  }

  int get fieldCount {
    int count = 0;
    if (receiptNo.value != null) count++;
    if (dateStr.value != null) count++;
    if (customerName.value != null && customerName.value!.isNotEmpty) count++;
    if (vehicleNo.value != null && vehicleNo.value!.isNotEmpty) count++;
    if (material.value != null && material.value!.isNotEmpty) count++;
    if (grossKg.value != null) count++;
    if (tareKg.value != null) count++;
    if (emptyDriverKg.value != null) count++;
    if (calculatedNetKg > 0) count++;
    return count;
  }

  ScannedSlipData copyWith({
    FieldWithConfidence<int>? receiptNo,
    FieldWithConfidence<String>? dateStr,
    FieldWithConfidence<String>? customerName,
    FieldWithConfidence<String>? vehicleNo,
    FieldWithConfidence<String>? material,
    FieldWithConfidence<int>? grossKg,
    FieldWithConfidence<int>? tareKg,
    FieldWithConfidence<int>? emptyDriverKg,
    String? scanPhotoPath,
    bool? isDuplicate,
  }) {
    return ScannedSlipData(
      receiptNo: receiptNo ?? this.receiptNo,
      dateStr: dateStr ?? this.dateStr,
      customerName: customerName ?? this.customerName,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      material: material ?? this.material,
      grossKg: grossKg ?? this.grossKg,
      tareKg: tareKg ?? this.tareKg,
      emptyDriverKg: emptyDriverKg ?? this.emptyDriverKg,
      scanPhotoPath: scanPhotoPath ?? this.scanPhotoPath,
      isDuplicate: isDuplicate ?? this.isDuplicate,
    );
  }
}

class OcrParser {
  static ScannedSlipData parseText(String rawText, [String? photoPath]) {
    final lines = rawText.split(RegExp(r'[\r\n]+'));

    int? receiptNoVal;
    String receiptConf = 'high';

    String? dateVal;
    String dateConf = 'high';

    String? nameVal;
    String nameConf = 'high';

    String? vehicleVal;
    String vehicleConf = 'high';

    String? materialVal;
    String materialConf = 'high';

    int? grossVal;
    String grossConf = 'high';

    int? tareVal;
    String tareConf = 'high';

    int? emptyDriverVal;
    String emptyDriverConf = 'high';

    // 1. Receipt No
    final receiptMatch = RegExp(r'(?:रसीद|स्लिप|क्रमांक|रसीद\s*नं|Slip\s*No|Receipt\s*No|Kramank)[:.\s#]*([0-9]{3,6})', caseSensitive: false).firstMatch(rawText);
    if (receiptMatch != null) {
      receiptNoVal = int.tryParse(receiptMatch.group(1)!);
    } else {
      final standaloneNum = RegExp(r'\b([0-9]{4})\b').firstMatch(rawText);
      if (standaloneNum != null) {
        receiptNoVal = int.tryParse(standaloneNum.group(1)!);
        receiptConf = 'low';
      }
    }

    // 2. Date
    final dateMatch = RegExp(r'(?:दिनांक|तिथि|Date)[:.\s]*([0-3]?[0-9][/\-.][0-1]?[0-9][/\-.][2][0][2-3][0-9])', caseSensitive: false).firstMatch(rawText);
    if (dateMatch != null) {
      dateVal = dateMatch.group(1);
    } else {
      final standaloneDate = RegExp(r'\b([0-3]?[0-9][/\-.][0-1]?[0-9][/\-.][2][0][2-3][0-9])\b').firstMatch(rawText);
      if (standaloneDate != null) {
        dateVal = standaloneDate.group(1);
        dateConf = 'low';
      }
    }

    // Extract year from dateVal if present to filter out from weight regexes
    int? yearVal;
    if (dateVal != null) {
      final yearMatch = RegExp(r'(202[0-9])').firstMatch(dateVal);
      if (yearMatch != null) {
        yearVal = int.tryParse(yearMatch.group(1)!);
      }
    }

    // 3. Vehicle No
    final vehicleMatch = RegExp(r'\b([A-Z]{2}\s*[-–]?\s*[0-9]{1,2}\s*[-–]?\s*[A-Z]{1,3}\s*[-–]?\s*[0-9]{3,4})\b', caseSensitive: false).firstMatch(rawText);
    if (vehicleMatch != null) {
      vehicleVal = vehicleMatch.group(1)!.toUpperCase().replaceAll(RegExp(r'\s+'), ' ');
    }

    // 4. Customer Name
    final nameMatch = RegExp(r'(?:नाम\s*श्री|नाम|श्री|M/s|Name)[:.\s]*([\u0900-\u097FA-Za-z\s]{2,20})', caseSensitive: false).firstMatch(rawText);
    if (nameMatch != null) {
      var rawName = nameMatch.group(1)!.trim();
      rawName = rawName.replaceAll(RegExp(r'^(श्री|नाम|Name|M/s)[:.\s]*', caseSensitive: false), '').trim();
      if (rawName.contains('\n')) {
        rawName = rawName.split('\n').first.trim();
      }
      if (rawName.isNotEmpty) {
        nameVal = rawName;
        if (rawName.length < 3) nameConf = 'low';
      }
    }

    if (nameVal == null) {
      for (final line in lines) {
        if (RegExp(r'(लाल|राम|सिंह|कुमार|Kumar|Singh|Lal|Mohan)', caseSensitive: false).hasMatch(line) && !line.contains('रसीद') && !line.contains('दिनांक')) {
          nameVal = line.replaceAll(RegExp(r'[^\u0900-\u097FA-Za-z\s]'), '').trim();
          nameConf = 'low';
          break;
        }
      }
    }

    // 5. Material
    final matMatch = RegExp(r'(?:माल\s*किसम|माल\s*किस्म|माल|जिंस|वस्तु|Material)[:.\s]*([\u0900-\u097FA-Za-z\s]{2,15})', caseSensitive: false).firstMatch(rawText);
    if (matMatch != null) {
      var rawMat = matMatch.group(1)!.trim();
      rawMat = rawMat.replaceAll(RegExp(r'^(किस्म|किसम)[:.\s]*', caseSensitive: false), '').trim();
      if (rawMat.contains('\n')) {
        rawMat = rawMat.split('\n').first.trim();
      }
      if (rawMat.isNotEmpty) {
        materialVal = rawMat;
      }
    }

    if (materialVal == null) {
      final commonMats = ['गेहूं', 'धान', 'मक्का', 'सरसों', 'चना', 'सीमेंट', 'सरिया', 'कोयला', 'Wheat', 'Cement', 'Rice'];
      for (final mat in commonMats) {
        if (rawText.toLowerCase().contains(mat.toLowerCase())) {
          materialVal = mat;
          break;
        }
      }
    }

    // 6. Gross Weight
    final grossMatch = RegExp(r'(?:वाहन\s*सहित\s*माल|सकल\s*भार|Gross\s*Weight|Gross)[:.\s]*([0-9,]{3,7})', caseSensitive: false).firstMatch(rawText);
    if (grossMatch != null) {
      grossVal = int.tryParse(grossMatch.group(1)!.replaceAll(',', ''));
    }

    // 7. Tare Weight
    final tareMatch = RegExp(r'(?:खाली\s*तुलाने\s*पर|खाली\s*भार|Tare\s*Weight|Tare)[:.\s]*([0-9,]{3,7})', caseSensitive: false).firstMatch(rawText);
    if (tareMatch != null) {
      tareVal = int.tryParse(tareMatch.group(1)!.replaceAll(',', ''));
    }

    // Fallback weight extraction if gross/tare labels were missed
    if (grossVal == null || tareVal == null) {
      final numbers = RegExp(r'\b([0-9]{1,2}[,][0-9]{3}|[0-9]{4,6})\b')
          .allMatches(rawText)
          .map((m) => int.tryParse(m.group(1)!.replaceAll(',', '')) ?? 0)
          .where((n) => n >= 1000 && n <= 100000 && n != receiptNoVal && n != yearVal)
          .toList();

      if (numbers.length >= 2) {
        numbers.sort(); // Lowest to highest
        if (tareVal == null) {
          tareVal = numbers.first;
          tareConf = 'low';
        }
        if (grossVal == null) {
          grossVal = numbers.last;
          grossConf = 'low';
        }
      }
    }

    return ScannedSlipData(
      receiptNo: FieldWithConfidence(receiptNoVal, receiptConf),
      dateStr: FieldWithConfidence(dateVal, dateConf),
      customerName: FieldWithConfidence(nameVal, nameConf),
      vehicleNo: FieldWithConfidence(vehicleVal, vehicleConf),
      material: FieldWithConfidence(materialVal, materialConf),
      grossKg: FieldWithConfidence(grossVal, grossConf),
      tareKg: FieldWithConfidence(tareVal, tareConf),
      emptyDriverKg: FieldWithConfidence(emptyDriverVal, emptyDriverConf),
      scanPhotoPath: photoPath,
    );
  }
}
