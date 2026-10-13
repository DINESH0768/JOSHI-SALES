import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/slip_repository.dart';
import '../domain/services/ocr_parser.dart';

class ScanResultScreen extends StatefulWidget {
  final ScannedSlipData scannedData;
  final AppDatabase db;

  const ScanResultScreen({
    super.key,
    required this.scannedData,
    required this.db,
  });

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  late SlipRepository _slipRepo;

  late int _receiptNo;
  late String _dateStr;
  late String _customerName;
  late String _vehicleNo;
  late String _material;
  late int _grossKg;
  late int _tareKg;
  int? _emptyDriverKg;

  late String _receiptConf;
  late String _dateConf;
  late String _nameConf;
  late String _vehicleConf;
  late String _materialConf;

  final TextEditingController _chargeController = TextEditingController(text: '');
  String? _chargeError;

  bool _isDuplicateReceipt = false;
  String? _existingSlipId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _slipRepo = SlipRepository(widget.db);

    final d = widget.scannedData;
    _receiptNo = d.receiptNo.value ?? 1031;
    _receiptConf = d.receiptNo.confidence;

    _dateStr = d.dateStr.value ?? DateFormat('dd/MM/yyyy').format(DateTime.now());
    _dateConf = d.dateStr.confidence;

    _customerName = d.customerName.value ?? 'मोहन लाल';
    _nameConf = d.customerName.confidence;

    _vehicleNo = d.vehicleNo.value ?? 'RJ 31 GA 0987';
    _vehicleConf = d.vehicleNo.confidence;

    _material = d.material.value ?? 'गेहूं';
    _materialConf = d.material.confidence;

    _grossKg = d.grossKg.value ?? 52350;
    _tareKg = d.tareKg.value ?? 13450;
    _emptyDriverKg = d.emptyDriverKg.value;

    _checkDuplicateReceipt();
  }

  Future<void> _checkDuplicateReceipt() async {
    final existing = await _slipRepo.getSlipByReceiptNo(_receiptNo);
    if (existing != null && mounted) {
      setState(() {
        _isDuplicateReceipt = true;
        _existingSlipId = existing.id;
      });
    }
  }

  // Auto-recomputed net weight
  int get _netKg => (_grossKg > _tareKg) ? (_grossKg - _tareKg) : 0;

  void _editField({
    required String title,
    required String initialValue,
    required Function(String) onSave,
    bool isNumeric = false,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('$title badlein', style: const TextStyle(color: AppColors.text, fontSize: 16)),
        content: TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          style: const TextStyle(color: AppColors.text),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface2,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.lime, width: 1),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Radd karein', style: TextStyle(color: AppColors.muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.lime),
            onPressed: () {
              onSave(controller.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: AppColors.onLime)),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSlipAndProceed() async {
    final chargeText = _chargeController.text.trim();
    final charge = int.tryParse(chargeText) ?? 0;

    if (charge <= 0) {
      setState(() {
        _chargeError = 'Charge bharna zaroori hai';
      });
      return;
    }

    setState(() => _isSaving = true);

    try {
      final slipId = await _slipRepo.saveSlip(
        receiptNo: _receiptNo,
        dateStr: _dateStr,
        customerName: _customerName,
        vehicleNo: _vehicleNo,
        totalNetWeight: _netKg.toDouble(),
        charge: charge.toDouble(),
        scanPhotoPath: widget.scannedData.scanPhotoPath,
        rounds: [
          {
            'material': _material,
            'gross': _grossKg,
            'tare': _tareKg,
            'emptyDriver': _emptyDriverKg,
            'net': _netKg,
          }
        ],
      );

      if (mounted) {
        context.pushReplacement('/payments/post-save/$slipId');
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save nahi ho paya, kripya dobara koshish karein')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldCount = widget.scannedData.fieldCount;

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
                  const Text('Scan result', style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surface3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('$fieldCount fields mile', style: const TextStyle(color: AppColors.text, fontSize: 11)),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              const Text('Jo galat ho wo tap karke theek karo', style: TextStyle(color: AppColors.muted, fontSize: 11)),
              const SizedBox(height: 10),

              // Duplicate Warning Banner
              if (_isDuplicateReceipt) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.expenseBg,
                    border: Border.all(color: AppColors.expenseBorder, width: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppColors.expense, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ye slip pehle se saved hai', style: TextStyle(color: AppColors.expense, fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('Raseed no. $_receiptNo database mein maujood hai', style: const TextStyle(color: AppColors.muted, fontSize: 10)),
                          ],
                        ),
                      ),
                      if (_existingSlipId != null)
                        GestureDetector(
                          onTap: () => context.push('/slips/card/$_existingSlipId'),
                          child: const Text('Dekhein', style: TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // Scanned Info List (.s2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _buildFieldRow(
                      label: 'रसीद नं.',
                      value: '$_receiptNo',
                      confidence: _receiptConf,
                      onTap: () => _editField(
                        title: 'रसीद नं.',
                        initialValue: '$_receiptNo',
                        isNumeric: true,
                        onSave: (v) {
                          final n = int.tryParse(v);
                          if (n != null) {
                            setState(() => _receiptNo = n);
                            _checkDuplicateReceipt();
                          }
                        },
                      ),
                    ),
                    _buildFieldRow(
                      label: 'दिनांक',
                      value: _dateStr,
                      confidence: _dateConf,
                      onTap: () => _editField(
                        title: 'दिनांक',
                        initialValue: _dateStr,
                        onSave: (v) => setState(() => _dateStr = v),
                      ),
                    ),
                    _buildFieldRow(
                      label: 'नाम श्री',
                      value: _customerName,
                      confidence: _nameConf,
                      onTap: () => _editField(
                        title: 'नाम श्री',
                        initialValue: _customerName,
                        onSave: (v) => setState(() => _customerName = v),
                      ),
                    ),
                    _buildFieldRow(
                      label: 'वाहन नं.',
                      value: _vehicleNo,
                      confidence: _vehicleConf,
                      onTap: () => _editField(
                        title: 'वाहन नं.',
                        initialValue: _vehicleNo,
                        onSave: (v) => setState(() => _vehicleNo = v.toUpperCase()),
                      ),
                    ),
                    _buildFieldRow(
                      label: 'माल किस्म',
                      value: _material,
                      confidence: _materialConf,
                      isLast: true,
                      onTap: () => _editField(
                        title: 'माल किस्म',
                        initialValue: _material,
                        onSave: (v) => setState(() => _material = v),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Weight Breakdown Card (.s2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _buildWeightRow(
                      label: 'वाहन सहित माल',
                      value: '${NumberFormat('#,##0').format(_grossKg)} kg',
                      onTap: () => _editField(
                        title: 'वाहन सहित माल (Gross)',
                        initialValue: '$_grossKg',
                        isNumeric: true,
                        onSave: (v) {
                          final n = int.tryParse(v);
                          if (n != null) setState(() => _grossKg = n);
                        },
                      ),
                    ),
                    _buildWeightRow(
                      label: 'खाली (तुलाने पर)',
                      value: '${NumberFormat('#,##0').format(_tareKg)} kg',
                      onTap: () => _editField(
                        title: 'खाली भार (Tare)',
                        initialValue: '$_tareKg',
                        isNumeric: true,
                        onSave: (v) {
                          final n = int.tryParse(v);
                          if (n != null) setState(() => _tareKg = n);
                        },
                      ),
                    ),
                    _buildWeightRow(
                      label: 'खाली (ड्राइवर)',
                      value: _emptyDriverKg != null ? '$_emptyDriverKg kg' : 'khali',
                    ),
                    // Auto-recomputed Net Weight
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text('असल माल', style: TextStyle(color: AppColors.lime, fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.surface3,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('auto', style: TextStyle(color: AppColors.muted, fontSize: 9)),
                              ),
                            ],
                          ),
                          Text(
                            '${NumberFormat('#,##0').format(_netKg)} kg',
                            style: const TextStyle(color: AppColors.lime, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Charge Input (.f.lime)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.lime, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Charge (aap bharo) *', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _chargeController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: const TextStyle(color: AppColors.muted),
                        prefixText: '₹ ',
                        prefixStyle: const TextStyle(color: AppColors.lime, fontSize: 20, fontWeight: FontWeight.bold),
                        errorText: _chargeError,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Save & Payment Flow Action Button (.btn.bl)
              GestureDetector(
                onTap: _isSaving ? null : _saveSlipAndProceed,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: _isSaving
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.onLime, strokeWidth: 2))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Slip Save Karein & Payment', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded, color: AppColors.onLime, size: 18),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldRow({
    required String label,
    required String value,
    required String confidence,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    final isHigh = confidence == 'high';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            Row(
              children: [
                Text(value, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                if (isHigh)
                  const Icon(Icons.check_rounded, color: AppColors.lime, size: 16)
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.pendingBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Check karo',
                      style: TextStyle(color: AppColors.pendingFg, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightRow({
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            Text(value, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
