import 'ocr_parser.dart';

class OcrVotingService {
  final List<ScannedSlipData> _frames = [];

  void addFrame(ScannedSlipData data) {
    _frames.add(data);
  }

  void clear() {
    _frames.clear();
  }

  int get frameCount => _frames.length;

  bool get isSteadyMatch {
    if (_frames.length < 3) return false;

    // Check if key fields (receiptNo or vehicleNo or grossKg) have consistent top votes
    final receiptCounts = <int, int>{};
    final vehicleCounts = <String, int>{};
    final grossCounts = <int, int>{};

    for (final f in _frames) {
      if (f.receiptNo.value != null) {
        receiptCounts[f.receiptNo.value!] = (receiptCounts[f.receiptNo.value!] ?? 0) + 1;
      }
      if (f.vehicleNo.value != null && f.vehicleNo.value!.isNotEmpty) {
        vehicleCounts[f.vehicleNo.value!] = (vehicleCounts[f.vehicleNo.value!] ?? 0) + 1;
      }
      if (f.grossKg.value != null) {
        grossCounts[f.grossKg.value!] = (grossCounts[f.grossKg.value!] ?? 0) + 1;
      }
    }

    final topReceiptCount = receiptCounts.values.isEmpty ? 0 : receiptCounts.values.reduce((a, b) => a > b ? a : b);
    final topVehicleCount = vehicleCounts.values.isEmpty ? 0 : vehicleCounts.values.reduce((a, b) => a > b ? a : b);
    final topGrossCount = grossCounts.values.isEmpty ? 0 : grossCounts.values.reduce((a, b) => a > b ? a : b);

    // Steady if at least two key fields have 2+ matching occurrences or any single key field has 3+ matching occurrences
    return (topReceiptCount >= 2 && topVehicleCount >= 2) ||
        (topReceiptCount >= 2 && topGrossCount >= 2) ||
        (topVehicleCount >= 2 && topGrossCount >= 2) ||
        topReceiptCount >= 3 ||
        topVehicleCount >= 3 ||
        topGrossCount >= 3;
  }

  ScannedSlipData getConsolidatedResult() {
    if (_frames.isEmpty) {
      return ScannedSlipData(
        receiptNo: FieldWithConfidence(null, 'low'),
        dateStr: FieldWithConfidence(null, 'low'),
        customerName: FieldWithConfidence(null, 'low'),
        vehicleNo: FieldWithConfidence(null, 'low'),
        material: FieldWithConfidence(null, 'low'),
        grossKg: FieldWithConfidence(null, 'low'),
        tareKg: FieldWithConfidence(null, 'low'),
        emptyDriverKg: FieldWithConfidence(null, 'low'),
      );
    }

    T? getTopVoted<T>(List<FieldWithConfidence<T>> fields) {
      final map = <T, int>{};
      for (final f in fields) {
        if (f.value != null) {
          map[f.value!] = (map[f.value!] ?? 0) + 1;
        }
      }
      if (map.isEmpty) return null;
      return map.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    }

    String getConfidence<T>(List<FieldWithConfidence<T>> fields, T? topValue) {
      if (topValue == null) return 'low';
      int highCount = 0;
      int matchCount = 0;
      for (final f in fields) {
        if (f.value == topValue) {
          matchCount++;
          if (f.isHigh) highCount++;
        }
      }
      return (matchCount >= 2 || highCount >= 1) ? 'high' : 'low';
    }

    final receipts = _frames.map((f) => f.receiptNo).toList();
    final topReceipt = getTopVoted(receipts);

    final dates = _frames.map((f) => f.dateStr).toList();
    final topDate = getTopVoted(dates);

    final names = _frames.map((f) => f.customerName).toList();
    final topName = getTopVoted(names);

    final vehicles = _frames.map((f) => f.vehicleNo).toList();
    final topVehicle = getTopVoted(vehicles);

    final materials = _frames.map((f) => f.material).toList();
    final topMaterial = getTopVoted(materials);

    final grosses = _frames.map((f) => f.grossKg).toList();
    final topGross = getTopVoted(grosses);

    final tares = _frames.map((f) => f.tareKg).toList();
    final topTare = getTopVoted(tares);

    final emptyDrivers = _frames.map((f) => f.emptyDriverKg).toList();
    final topEmptyDriver = getTopVoted(emptyDrivers);

    final photoPath = _frames.lastWhere((f) => f.scanPhotoPath != null, orElse: () => _frames.last).scanPhotoPath;

    return ScannedSlipData(
      receiptNo: FieldWithConfidence(topReceipt, getConfidence(receipts, topReceipt)),
      dateStr: FieldWithConfidence(topDate, getConfidence(dates, topDate)),
      customerName: FieldWithConfidence(topName, getConfidence(names, topName)),
      vehicleNo: FieldWithConfidence(topVehicle, getConfidence(vehicles, topVehicle)),
      material: FieldWithConfidence(topMaterial, getConfidence(materials, topMaterial)),
      grossKg: FieldWithConfidence(topGross, getConfidence(grosses, topGross)),
      tareKg: FieldWithConfidence(topTare, getConfidence(tares, topTare)),
      emptyDriverKg: FieldWithConfidence(topEmptyDriver, getConfidence(emptyDrivers, topEmptyDriver)),
      scanPhotoPath: photoPath,
    );
  }
}
