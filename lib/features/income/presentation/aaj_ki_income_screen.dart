import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../payments/domain/services/payment_service.dart';

class AajKiIncomeScreen extends StatefulWidget {
  final AppDatabase db;

  const AajKiIncomeScreen({super.key, required this.db});

  @override
  State<AajKiIncomeScreen> createState() => _AajKiIncomeScreenState();
}

class _AajKiIncomeScreenState extends State<AajKiIncomeScreen> {
  late PaymentService _paymentService;
  DateTime _selectedDate = DateTime.now();

  int _totalIncome = 0;
  int _cashTotal = 0;
  int _upiTotal = 0;
  int _cashCount = 0;
  int _upiCount = 0;
  List<PaymentsTableData> _payments = [];
  bool _isLoading = true;

  String _filterMode = 'sab'; // 'sab', 'cash', 'upi'

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(widget.db);
    _loadIncome();
  }

  Future<void> _loadIncome() async {
    final summary = await _paymentService.getIncomeSummaryForDate(_selectedDate);

    if (mounted) {
      setState(() {
        _totalIncome = summary['totalIncome'] as int;
        _cashTotal = summary['cashTotal'] as int;
        _upiTotal = summary['upiTotal'] as int;
        _cashCount = summary['cashCount'] as int;
        _upiCount = summary['upiCount'] as int;
        _payments = summary['payments'] as List<PaymentsTableData>;
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.lime,
              onPrimary: AppColors.onLime,
              surface: AppColors.surface,
              onSurface: AppColors.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isLoading = true;
      });
      _loadIncome();
    }
  }

  List<PaymentsTableData> _getFilteredPayments() {
    if (_filterMode == 'cash') {
      return _payments.where((p) => p.mode == 'cash').toList();
    } else if (_filterMode == 'upi') {
      return _payments.where((p) => p.mode == 'upi').toList();
    }
    return _payments;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFilteredPayments();
    final dateStr = DateFormat('dd MMM').format(_selectedDate);

    double cashRatio = _totalIncome > 0 ? (_cashTotal / _totalIncome) : 0.5;
    double upiRatio = _totalIncome > 0 ? (_upiTotal / _totalIncome) : 0.5;

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
                  const Text('Aaj ki income', style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded, color: AppColors.text, size: 12),
                          const SizedBox(width: 4),
                          Text(dateStr, style: const TextStyle(color: AppColors.text, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Total Mila Card (.card)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total mila', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹${NumberFormat('#,##0').format(_totalIncome)}', style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // Split bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (cashRatio * 100).toInt().clamp(1, 99),
                            child: Container(color: AppColors.lime),
                          ),
                          Expanded(
                            flex: (upiRatio * 100).toInt().clamp(1, 99),
                            child: Container(color: AppColors.upiBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Cash & UPI cards row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.limeTintBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.limeTintBorder, width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Cash', style: TextStyle(color: AppColors.lime, fontSize: 11)),
                          Text('₹${NumberFormat('#,##0').format(_cashTotal)}', style: const TextStyle(color: AppColors.text, fontSize: 19, fontWeight: FontWeight.bold)),
                          Text('$_cashCount payment', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.upiBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.upiBorder, width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('UPI', style: TextStyle(color: AppColors.upiBlue, fontSize: 11)),
                          Text('₹${NumberFormat('#,##0').format(_upiTotal)}', style: const TextStyle(color: AppColors.text, fontSize: 19, fontWeight: FontWeight.bold)),
                          Text('$_upiCount payment', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Cash in hand (.s2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cash in hand (cash - kharcha)', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                    Text('₹${NumberFormat('#,##0').format(_cashTotal)}', style: const TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Filter chips
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _filterMode = 'sab'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _filterMode == 'sab' ? AppColors.lime : AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Sab', style: TextStyle(color: _filterMode == 'sab' ? AppColors.onLime : AppColors.text, fontSize: 11, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => setState(() => _filterMode = 'cash'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _filterMode == 'cash' ? AppColors.lime : AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Cash', style: TextStyle(color: _filterMode == 'cash' ? AppColors.onLime : AppColors.text, fontSize: 11, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => setState(() => _filterMode = 'upi'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _filterMode == 'upi' ? AppColors.lime : AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('UPI', style: TextStyle(color: _filterMode == 'upi' ? AppColors.onLime : AppColors.text, fontSize: 11, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Payments list
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.lime))
              else if (filtered.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: const Text('Is din koi payment nahi hui', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: filtered.map((p) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: p.mode == 'cash' ? AppColors.limeTintBg : AppColors.upiBg,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                p.mode == 'cash' ? Icons.payments_rounded : Icons.qr_code_2_rounded,
                                color: p.mode == 'cash' ? AppColors.lime : AppColors.upiBlue,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Payment (${p.mode.toUpperCase()})', style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                  Text(DateFormat('hh:mm a').format(p.receivedAt), style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                ],
                              ),
                            ),
                            Text(
                              '+₹${p.amount}',
                              style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
