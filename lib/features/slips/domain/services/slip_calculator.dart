class RoundInput {
  final String material;
  final double grossWeight;
  final double tareWeight;
  final double? driverClaimedTare;
  final String? bagExtra;

  RoundInput({
    required this.material,
    required this.grossWeight,
    required this.tareWeight,
    this.driverClaimedTare,
    this.bagExtra,
  });

  double get netWeight => grossWeight - tareWeight;
}

class ExistingSlipCheck {
  final String? vehicleNumber;
  final String date;
  final List<double> grossWeights;
  final List<double> tareWeights;

  ExistingSlipCheck({
    this.vehicleNumber,
    required this.date,
    required this.grossWeights,
    required this.tareWeights,
  });
}

class SlipValidationResult {
  final bool isValid;
  final String? errorMessage;

  SlipValidationResult.valid()
      : isValid = true,
        errorMessage = null;

  SlipValidationResult.invalid(this.errorMessage) : isValid = false;
}

class SlipCalculator {
  /// Calculate net weight for a single round
  static double calculateRoundNetWeight(double grossWeight, double tareWeight) {
    if (grossWeight < tareWeight) return 0;
    return grossWeight - tareWeight;
  }

  /// Calculate total net weight across multiple rounds
  static double calculateTotalNetWeight(List<RoundInput> rounds) {
    double total = 0;
    for (var round in rounds) {
      if (round.grossWeight >= round.tareWeight) {
        total += (round.grossWeight - round.tareWeight);
      }
    }
    return total;
  }

  /// Validate form inputs
  static SlipValidationResult validateSlipForm({
    required String? customerName,
    required String? vehicleNumber,
    required double? charge,
    required List<RoundInput> rounds,
  }) {
    // 1. Either Customer Name or Vehicle Number is required
    final cleanCustomer = customerName?.trim() ?? '';
    final cleanVehicle = vehicleNumber?.trim() ?? '';
    if (cleanCustomer.isEmpty && cleanVehicle.isEmpty) {
      return SlipValidationResult.invalid('Naam ya gaadi number mein se ek likho');
    }

    // 2. Charge is required
    if (charge == null || charge <= 0) {
      return SlipValidationResult.invalid('Pehle charge likho');
    }

    // 3. Round validation
    if (rounds.isEmpty) {
      return SlipValidationResult.invalid('Kam se kam ek round zaroori hai');
    }

    for (int i = 0; i < rounds.length; i++) {
      final round = rounds[i];
      if (round.tareWeight > round.grossWeight) {
        return SlipValidationResult.invalid('Khali vajan bhare vajan se zyada nahi ho sakta');
      }
      if (i > 0 && (round.grossWeight <= 0 || round.tareWeight <= 0)) {
        return SlipValidationResult.invalid('Dusre round ka vajan bharo ya use hata do');
      }
    }

    return SlipValidationResult.valid();
  }

  /// Check if a slip is duplicate (same vehicle + same weights + same date)
  static bool isDuplicateSlip({
    required String? vehicleNumber,
    required String date,
    required List<RoundInput> rounds,
    required List<ExistingSlipCheck> existingSlips,
  }) {
    if (vehicleNumber == null || vehicleNumber.trim().isEmpty) return false;

    final cleanVehicle = vehicleNumber.trim().toUpperCase();
    final currentGross = rounds.map((r) => r.grossWeight).toList();
    final currentTare = rounds.map((r) => r.tareWeight).toList();

    for (var existing in existingSlips) {
      if (existing.vehicleNumber?.trim().toUpperCase() == cleanVehicle &&
          existing.date == date) {
        if (_areListsEqual(existing.grossWeights, currentGross) &&
            _areListsEqual(existing.tareWeights, currentTare)) {
          return true;
        }
      }
    }
    return false;
  }

  static bool _areListsEqual(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if ((a[i] - b[i]).abs() > 0.001) return false;
    }
    return true;
  }
}
