import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/features/slips/domain/services/slip_calculator.dart';

void main() {
  group('SlipCalculator Net Weight Tests', () {
    test('calculateRoundNetWeight returns gross minus tare', () {
      final net = SlipCalculator.calculateRoundNetWeight(52350, 13450);
      expect(net, 38900);
    });

    test('calculateRoundNetWeight returns 0 if gross < tare', () {
      final net = SlipCalculator.calculateRoundNetWeight(10000, 13450);
      expect(net, 0);
    });

    test('calculateTotalNetWeight calculates total across rounds', () {
      final rounds = [
        RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        RoundInput(material: 'Sariya', grossWeight: 41200, tareWeight: 13450),
      ];
      final total = SlipCalculator.calculateTotalNetWeight(rounds);
      expect(total, 66650);
    });
  });

  group('SlipCalculator Validation Tests', () {
    test('Fails when both name and vehicle number are empty', () {
      final res = SlipCalculator.validateSlipForm(
        customerName: ' ',
        vehicleNumber: '',
        charge: 400,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
      );
      expect(res.isValid, isFalse);
      expect(res.errorMessage, 'Naam ya gaadi number mein se ek likho');
    });

    test('Passes when either name or vehicle number is provided', () {
      final resWithCustomer = SlipCalculator.validateSlipForm(
        customerName: 'Mohan Lal',
        vehicleNumber: '',
        charge: 400,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
      );
      expect(resWithCustomer.isValid, isTrue);

      final resWithVehicle = SlipCalculator.validateSlipForm(
        customerName: '',
        vehicleNumber: 'RJ 31 GA 0987',
        charge: 400,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
      );
      expect(resWithVehicle.isValid, isTrue);
    });

    test('Fails when charge is missing or zero', () {
      final res = SlipCalculator.validateSlipForm(
        customerName: 'Mohan Lal',
        vehicleNumber: 'RJ 31 GA 0987',
        charge: 0,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
      );
      expect(res.isValid, isFalse);
      expect(res.errorMessage, 'Pehle charge likho');
    });

    test('Fails when tare weight > gross weight', () {
      final res = SlipCalculator.validateSlipForm(
        customerName: 'Mohan Lal',
        vehicleNumber: 'RJ 31 GA 0987',
        charge: 400,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 10000, tareWeight: 13450),
        ],
      );
      expect(res.isValid, isFalse);
      expect(res.errorMessage, 'Khali vajan bhare vajan se zyada nahi ho sakta');
    });

    test('Fails when second round weight is missing or 0', () {
      final res = SlipCalculator.validateSlipForm(
        customerName: 'Mohan Lal',
        vehicleNumber: 'RJ 31 GA 0987',
        charge: 400,
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
          RoundInput(material: 'Sariya', grossWeight: 0, tareWeight: 0),
        ],
      );
      expect(res.isValid, isFalse);
      expect(res.errorMessage, 'Dusre round ka vajan bharo ya use hata do');
    });
  });

  group('SlipCalculator Duplicate Detection Tests', () {
    final existingSlips = [
      ExistingSlipCheck(
        vehicleNumber: 'RJ 31 GA 0987',
        date: '11/10/2026',
        grossWeights: [52350],
        tareWeights: [13450],
      )
    ];

    test('Detects duplicate slip with same vehicle, weights, and date', () {
      final isDup = SlipCalculator.isDuplicateSlip(
        vehicleNumber: 'rj 31 ga 0987',
        date: '11/10/2026',
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
        existingSlips: existingSlips,
      );
      expect(isDup, isTrue);
    });

    test('Does not flag duplicate if weights or date differ', () {
      final isDupDifferentWeights = SlipCalculator.isDuplicateSlip(
        vehicleNumber: 'RJ 31 GA 0987',
        date: '11/10/2026',
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 50000, tareWeight: 13450),
        ],
        existingSlips: existingSlips,
      );
      expect(isDupDifferentWeights, isFalse);

      final isDupDifferentDate = SlipCalculator.isDuplicateSlip(
        vehicleNumber: 'RJ 31 GA 0987',
        date: '12/10/2026',
        rounds: [
          RoundInput(material: 'Cement', grossWeight: 52350, tareWeight: 13450),
        ],
        existingSlips: existingSlips,
      );
      expect(isDupDifferentDate, isFalse);
    });
  });
}
