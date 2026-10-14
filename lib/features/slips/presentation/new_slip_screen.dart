import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_scale_button.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/slip_repository.dart';
import '../../slips/domain/services/slip_calculator.dart';

class NewSlipScreen extends StatefulWidget {
  final AppDatabase db;

  const NewSlipScreen({super.key, required this.db});

  @override
  State<NewSlipScreen> createState() => _NewSlipScreenState();
}

class _NewSlipScreenState extends State<NewSlipScreen> {
  late SlipRepository _repository;
  int _receiptNo = 1032;
  final String _dateStr = DateFormat('dd/MM/yyyy').format(DateTime.now());

  final _customerController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _chargeController = TextEditingController();

  // Round 1
  final _mat1Controller = TextEditingController();
  final _gross1Controller = TextEditingController();
  final _tare1Controller = TextEditingController();
  final _driverTare1Controller = TextEditingController();
  final _bagExtra1Controller = TextEditingController();

  // Round 2 (optional)
  bool _hasRound2 = false;
  final _mat2Controller = TextEditingController();
  final _gross2Controller = TextEditingController();
  final _tare2Controller = TextEditingController();
  final _driverTare2Controller = TextEditingController();
  final _bagExtra2Controller = TextEditingController();

  List<String> _recentCustomers = ['मोहन लाल', 'सोनु', 'राम अवतार'];
  List<String> _recentVehicles = ['RJ 31 GA 0987', 'RJ 13 GB 4421', 'RJ 07 CC 8812'];
  final List<String> _recentMaterials = ['सीमेंट', 'गेहूं', 'सरिया', 'नरमा', 'कपास'];
  final List<int> _recentCharges = [400, 450, 500];

  @override
  void initState() {
    super.initState();
    _repository = SlipRepository(widget.db);
    _initData();
  }

  Future<void> _initData() async {
    final nextNo = await _repository.peekNextReceiptNumber();
    final custSuggestions = await _repository.getCustomerSuggestions();
    final vehSuggestions = await _repository.getVehicleSuggestions();

    final draft = await SlipDraftStorage.loadDraft();

    if (mounted) {
      setState(() {
        _receiptNo = nextNo;
        if (custSuggestions.isNotEmpty) _recentCustomers = custSuggestions;
        if (vehSuggestions.isNotEmpty) _recentVehicles = vehSuggestions;

        if (draft != null) {
          _customerController.text = draft['customer'] ?? '';
          _vehicleController.text = draft['vehicle'] ?? '';
          _chargeController.text = draft['charge'] ?? '';

          _mat1Controller.text = draft['mat1'] ?? '';
          _gross1Controller.text = draft['gross1'] ?? '';
          _tare1Controller.text = draft['tare1'] ?? '';
          _driverTare1Controller.text = draft['driverTare1'] ?? '';
          _bagExtra1Controller.text = draft['bagExtra1'] ?? '';

          if (draft['hasRound2'] == true) {
            _hasRound2 = true;
            _mat2Controller.text = draft['mat2'] ?? '';
            _gross2Controller.text = draft['gross2'] ?? '';
            _tare2Controller.text = draft['tare2'] ?? '';
            _driverTare2Controller.text = draft['driverTare2'] ?? '';
            _bagExtra2Controller.text = draft['bagExtra2'] ?? '';
          }
        }
      });
    }

    _customerController.addListener(_onFormChanged);
    _vehicleController.addListener(_onFormChanged);
    _chargeController.addListener(_onFormChanged);
    _mat1Controller.addListener(_onFormChanged);
    _gross1Controller.addListener(_onFormChanged);
    _tare1Controller.addListener(_onFormChanged);
    _driverTare1Controller.addListener(_onFormChanged);
    _bagExtra1Controller.addListener(_onFormChanged);
    _mat2Controller.addListener(_onFormChanged);
    _gross2Controller.addListener(_onFormChanged);
    _tare2Controller.addListener(_onFormChanged);
    _driverTare2Controller.addListener(_onFormChanged);
    _bagExtra2Controller.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
    _saveDraft();
  }

  void _saveDraft() {
    SlipDraftStorage.saveDraft({
      'customer': _customerController.text,
      'vehicle': _vehicleController.text,
      'charge': _chargeController.text,
      'mat1': _mat1Controller.text,
      'gross1': _gross1Controller.text,
      'tare1': _tare1Controller.text,
      'driverTare1': _driverTare1Controller.text,
      'bagExtra1': _bagExtra1Controller.text,
      'hasRound2': _hasRound2,
      'mat2': _mat2Controller.text,
      'gross2': _gross2Controller.text,
      'tare2': _tare2Controller.text,
      'driverTare2': _driverTare2Controller.text,
      'bagExtra2': _bagExtra2Controller.text,
    });
  }

  double _getNet1() {
    final g = double.tryParse(_gross1Controller.text) ?? 0;
    final t = double.tryParse(_tare1Controller.text) ?? 0;
    return SlipCalculator.calculateRoundNetWeight(g, t);
  }

  double _getNet2() {
    if (!_hasRound2) return 0;
    final g = double.tryParse(_gross2Controller.text) ?? 0;
    final t = double.tryParse(_tare2Controller.text) ?? 0;
    return SlipCalculator.calculateRoundNetWeight(g, t);
  }

  double _getTotalNet() => _getNet1() + _getNet2();

  List<RoundInput> _buildRoundInputs() {
    final list = <RoundInput>[
      RoundInput(
        material: _mat1Controller.text.trim(),
        grossWeight: double.tryParse(_gross1Controller.text) ?? 0,
        tareWeight: double.tryParse(_tare1Controller.text) ?? 0,
        driverClaimedTare: double.tryParse(_driverTare1Controller.text),
        bagExtra: _bagExtra1Controller.text.trim(),
      )
    ];

    if (_hasRound2) {
      list.add(
        RoundInput(
          material: _mat2Controller.text.trim(),
          grossWeight: double.tryParse(_gross2Controller.text) ?? 0,
          tareWeight: double.tryParse(_tare2Controller.text) ?? 0,
          driverClaimedTare: double.tryParse(_driverTare2Controller.text),
          bagExtra: _bagExtra2Controller.text.trim(),
        ),
      );
    }

    return list;
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.surface3,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _validateAndProcess() {
    final rounds = _buildRoundInputs();
    final charge = double.tryParse(_chargeController.text);

    final validation = SlipCalculator.validateSlipForm(
      customerName: _customerController.text,
      vehicleNumber: _vehicleController.text,
      charge: charge,
      rounds: rounds,
    );

    if (!validation.isValid) {
      _showToast(validation.errorMessage!);
      return false;
    }
    return true;
  }

  Future<void> _onSave() async {
    if (!_validateAndProcess()) return;

    try {
      final rounds = _buildRoundInputs();

      // Check duplicate warning
      final allSlips = await _repository.getAllSlips();
      final existingChecks = <ExistingSlipCheck>[];

      for (var s in allSlips) {
        final sRounds = await _repository.getRoundsForSlip(s.id);
        existingChecks.add(
          ExistingSlipCheck(
            vehicleNumber: s.vehicleNo,
            date: DateFormat('dd/MM/yyyy').format(s.date),
            grossWeights: sRounds.map((r) => r.grossKg.toDouble()).toList(),
            tareWeights: sRounds.map((r) => (r.emptyTulaneKg ?? 0).toDouble()).toList(),
          ),
        );
      }

      final isDuplicate = SlipCalculator.isDuplicateSlip(
        vehicleNumber: _vehicleController.text,
        date: _dateStr,
        rounds: rounds,
        existingSlips: existingChecks,
      );

      if (isDuplicate && mounted) {
        final shouldProceed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              title: const Text('Aisi slip pehle se hai', style: TextStyle(color: AppColors.text, fontSize: 16)),
              content: const Text('Isi gaadi no, tareekh aur vajan ki slip pehle se bani hui hai. Kya aap ise fir bhi save karna chahte hain?', style: TextStyle(color: AppColors.muted, fontSize: 13)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Radd karein', style: TextStyle(color: AppColors.muted)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Save karein', style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );

        if (shouldProceed != true) return;
      }

      final actualReceiptNo = await _repository.getNextReceiptNumber();
      final charge = double.parse(_chargeController.text);
      final roundMaps = [
        {
          'material': _mat1Controller.text,
          'gross': double.parse(_gross1Controller.text),
          'tare': double.parse(_tare1Controller.text),
          'driverTare': double.tryParse(_driverTare1Controller.text),
          'bagExtra': _bagExtra1Controller.text,
        }
      ];

      if (_hasRound2) {
        roundMaps.add({
          'material': _mat2Controller.text,
          'gross': double.parse(_gross2Controller.text),
          'tare': double.parse(_tare2Controller.text),
          'driverTare': double.tryParse(_driverTare2Controller.text),
          'bagExtra': _bagExtra2Controller.text,
        });
      }

      final slipId = await _repository.saveSlip(
        receiptNo: actualReceiptNo,
        dateStr: _dateStr,
        customerName: _customerController.text.trim(),
        vehicleNo: _vehicleController.text.trim().toUpperCase(),
        totalNetWeight: _getTotalNet(),
        charge: charge,
        rounds: roundMaps,
      );

      await SlipDraftStorage.clearDraft();

      if (mounted) {
        context.go('/payments/post-save/$slipId');
      }
    } catch (e) {
      if (mounted) {
        _showToast('Error: ${e.toString()}');
      }
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hint,
    bool readOnly = false,
    bool isLimeBorder = false,
    List<TextInputFormatter>? formatters,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isLimeBorder ? AppColors.lime : AppColors.border,
          width: isLimeBorder ? 1.0 : 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              color: isLimeBorder ? AppColors.lime : AppColors.muted,
            ),
          ),
          const SizedBox(height: 2),
          TextField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType,
            inputFormatters: formatters,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: readOnly ? AppColors.muted : AppColors.text,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundCard({
    required String title,
    required TextEditingController matCtrl,
    required TextEditingController grossCtrl,
    required TextEditingController tareCtrl,
    required TextEditingController driverTareCtrl,
    required TextEditingController bagExtraCtrl,
    required double netWeight,
    VoidCallback? onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F11),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.lime, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: const Text(
                    'Hatao',
                    style: TextStyle(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildField(label: 'माल किस्म (kuch bhi likho)', controller: matCtrl, hint: 'उदा. सीमेंट, गेहूं'),
          // Material quick chips
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _recentMaterials.map((m) {
              return GestureDetector(
                onTap: () => matCtrl.text = m,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface3,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(m, style: const TextStyle(fontSize: 11, color: AppColors.text)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          _buildField(
            label: 'वाहन सहित माल का वजन (kg)',
            controller: grossCtrl,
            keyboardType: TextInputType.number,
            formatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          _buildField(
            label: 'खाली वाहन (तुलाने पर)',
            controller: tareCtrl,
            keyboardType: TextInputType.number,
            formatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          _buildField(
            label: 'खाली वाहन (ड्राइवर के कहने पर)',
            controller: driverTareCtrl,
            hint: 'Optional',
            keyboardType: TextInputType.number,
            formatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          // Net weight auto box (.s2 lime tint)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.limeTintBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.limeTintBorder, width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('असल माल ', style: TextStyle(color: AppColors.lime, fontSize: 12)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('auto', style: TextStyle(color: AppColors.lime, fontSize: 11)),
                    ),
                  ],
                ),
                Text(
                  '${NumberFormat('#,##0').format(netWeight)} kg',
                  style: const TextStyle(color: AppColors.lime, fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          _buildField(label: 'Bag / extra', controller: bagExtraCtrl, hint: 'उदा. 400 bag cement'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header (.hd)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.chevron_left_rounded, color: AppColors.text, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Nayi slip', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.limeTintBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('No. $_receiptNo', style: const TextStyle(color: AppColors.lime, fontSize: 11)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Auto Receipt No & Date row
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      label: 'रसीद नं. (auto)',
                      controller: TextEditingController(text: '$_receiptNo'),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildField(
                      label: 'दिनांक',
                      controller: TextEditingController(text: _dateStr),
                      readOnly: true,
                    ),
                  ),
                ],
              ),

              // Customer Name
              _buildField(
                label: 'नाम श्री (customer)',
                controller: _customerController,
                hint: 'उदा. मोहन लाल',
              ),
              if (_recentCustomers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: _recentCustomers.map((c) {
                      return GestureDetector(
                        onTap: () => _customerController.text = c,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.surface3,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(c, style: const TextStyle(fontSize: 11, color: AppColors.text)),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              const Text('ya', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted, fontSize: 11)),
              const SizedBox(height: 4),

              // Vehicle No
              _buildField(
                label: 'वाहन नं. (gaadi number)',
                controller: _vehicleController,
                hint: 'उदा. RJ 31 GA 0987',
                formatters: [UpperCaseTextFormatter()],
              ),
              if (_recentVehicles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: _recentVehicles.map((v) {
                      return GestureDetector(
                        onTap: () => _vehicleController.text = v,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.surface3,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(v, style: const TextStyle(fontSize: 11, color: AppColors.text)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              const Text('Dono mein se koi ek kaafi hai', style: TextStyle(color: AppColors.muted, fontSize: 11)),
              const SizedBox(height: 10),

              // Round 1
              _buildRoundCard(
                title: 'पहला राउंड',
                matCtrl: _mat1Controller,
                grossCtrl: _gross1Controller,
                tareCtrl: _tare1Controller,
                driverTareCtrl: _driverTare1Controller,
                bagExtraCtrl: _bagExtra1Controller,
                netWeight: _getNet1(),
              ),

              // Round 2 (if added)
              if (_hasRound2)
                _buildRoundCard(
                  title: 'दूसरा राउंड',
                  matCtrl: _mat2Controller,
                  grossCtrl: _gross2Controller,
                  tareCtrl: _tare2Controller,
                  driverTareCtrl: _driverTare2Controller,
                  bagExtraCtrl: _bagExtra2Controller,
                  netWeight: _getNet2(),
                  onRemove: () {
                    setState(() {
                      _hasRound2 = false;
                      _mat2Controller.clear();
                      _gross2Controller.clear();
                      _tare2Controller.clear();
                      _driverTare2Controller.clear();
                      _bagExtra2Controller.clear();
                    });
                    _onFormChanged();
                  },
                ),

              // Add Round 2 Button (dashed lime)
              if (!_hasRound2)
                GestureDetector(
                  onTap: () {
                    setState(() => _hasRound2 = true);
                    _onFormChanged();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.lime, width: 1.0, style: BorderStyle.solid),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_rounded, color: AppColors.lime, size: 16),
                        SizedBox(width: 6),
                        Text('Dusra round jodo', style: TextStyle(color: AppColors.lime, fontSize: 13)),
                      ],
                    ),
                  ),
                ),

              // Total Net Weight Summary Bar (.s2 lime bar)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('कुल असल माल', style: TextStyle(color: AppColors.onLime, fontSize: 12, fontWeight: FontWeight.w500)),
                    Text(
                      '${NumberFormat('#,##0').format(_getTotalNet())} kg',
                      style: const TextStyle(color: AppColors.onLime, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Charge field
              _buildField(
                label: 'Charge (poori slip ka)',
                controller: _chargeController,
                hint: '₹ 400',
                isLimeBorder: true,
                keyboardType: TextInputType.number,
                formatters: [FilteringTextInputFormatter.digitsOnly],
              ),

              // Quick charge chips
              Wrap(
                spacing: 6,
                children: _recentCharges.map((ch) {
                  final isSelected = _chargeController.text == '$ch';
                  return GestureDetector(
                    onTap: () => _chargeController.text = '$ch',
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.lime : AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '₹$ch',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? AppColors.onLime : AppColors.text,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_validateAndProcess()) {
                      _showToast('Form ekdam sahi hai! Preview ready hai.');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface3,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_rounded, color: AppColors.text, size: 16),
                        SizedBox(width: 6),
                        Text('Preview', style: TextStyle(color: AppColors.text, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppScaleButton(
                  key: const Key('save_slip_button'),
                  onTap: _onSave,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.lime,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Save karo',
                      style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
