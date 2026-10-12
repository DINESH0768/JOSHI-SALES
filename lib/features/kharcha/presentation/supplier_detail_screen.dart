import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/supplier_pdf_generator.dart';
import '../domain/services/supplier_service.dart';

class SupplierDetailScreen extends StatefulWidget {
  final String supplierId;
  final AppDatabase db;

  const SupplierDetailScreen({
    super.key,
    required this.supplierId,
    required this.db,
  });

  @override
  State<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends State<SupplierDetailScreen> {
  late SupplierService _supplierService;

  SuppliersTableData? _supplier;
  ShopSettingsTableData? _shopSettings;
  int _denaBaki = 0;
  int _todayCount = 4;
  List<Map<String, dynamic>> _pooraHisaab = [];
  List<SupplierPaymentsTableData> _diyeHuePaise = [];
  bool _isLoading = true;

  String _selectedTab = 'poora_hisaab'; // 'poora_hisaab' or 'diye_hue_paise'

  @override
  void initState() {
    super.initState();
    _supplierService = SupplierService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final s = await _supplierService.getSupplierById(widget.supplierId);
    final bal = await _supplierService.getSupplierBalance(widget.supplierId);
    final hisaab = await _supplierService.getPooraHisaab(widget.supplierId);
    final payments = await _supplierService.getDiyeHuePaise(widget.supplierId);
    final shop = await (widget.db.select(widget.db.shopSettingsTable)).getSingleOrNull();

    if (mounted) {
      setState(() {
        _supplier = s;
        _denaBaki = bal;
        _pooraHisaab = hisaab;
        _diyeHuePaise = payments;
        _shopSettings = shop;
        _isLoading = false;
      });
    }
  }

  Future<void> _addTodayEntry() async {
    if (_supplier == null) return;
    final rate = _supplier!.ratePerUnit ?? 10;
    final amount = _todayCount * rate;

    await _supplierService.addSupplierEntry(
      supplierId: _supplier!.id,
      date: DateTime.now(),
      amount: amount,
      count: _todayCount,
      note: '$_todayCount ${_supplier!.unitName ?? 'unit'}',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_todayCount ${_supplier!.unitName ?? 'unit'} (₹$amount) khate mein jodi gayi'),
          backgroundColor: AppColors.surface,
        ),
      );
      _loadData();
    }
  }

  void _showPaiseDiyeModal() {
    final amountController = TextEditingController();
    final noteController = TextEditingController();
    String selectedMode = 'cash';
    DateTime selectedDate = DateTime.now();
    String? amountError;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Paise diye', style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.muted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Amount
                    Row(
                      children: [
                        const Text('Rakam (₹) *', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                        const Spacer(),
                        // Shortcut "Poora baki" chip
                        GestureDetector(
                          onTap: () {
                            setModalState(() {
                              amountController.text = _denaBaki.toString();
                              amountError = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.limeTintBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.limeTintBorder, width: 0.5),
                            ),
                            child: Text(
                              'Poora baki (₹$_denaBaki)',
                              style: const TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: '0',
                        prefixText: '₹ ',
                        prefixStyle: const TextStyle(color: AppColors.lime, fontSize: 20, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.lime, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.lime, width: 2),
                        ),
                        errorText: amountError,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Cash / UPI Mode Selector
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setModalState(() => selectedMode = 'cash'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedMode == 'cash' ? AppColors.lime : AppColors.surface3,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Cash',
                                style: TextStyle(
                                  color: selectedMode == 'cash' ? AppColors.onLime : AppColors.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setModalState(() => selectedMode = 'upi'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selectedMode == 'upi' ? AppColors.upiBlue : AppColors.surface3,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'UPI',
                                style: TextStyle(
                                  color: selectedMode == 'upi' ? Colors.white : AppColors.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Date selector
                    GestureDetector(
                      onTap: () async {
                        final p = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2030),
                        );
                        if (p != null) {
                          setModalState(() => selectedDate = p);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.border, width: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, color: AppColors.muted, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('dd MMM yyyy').format(selectedDate),
                              style: const TextStyle(color: AppColors.text, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: noteController,
                      style: const TextStyle(color: AppColors.text, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Note (optional)',
                        hintStyle: const TextStyle(color: AppColors.muted),
                        filled: true,
                        fillColor: AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lime,
                        foregroundColor: AppColors.onLime,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        final amtText = amountController.text.trim();
                        final amt = int.tryParse(amtText) ?? 0;

                        if (amt <= 0) {
                          setModalState(() => amountError = 'Sahi rakam likho');
                          return;
                        }

                        final nav = Navigator.of(ctx);

                        // Rule check: if amount > denaBaki, confirm with user
                        if (amt > _denaBaki && _denaBaki > 0) {
                          if (!ctx.mounted) return;
                          final confirm = await showDialog<bool>(
                            context: ctx,
                            builder: (dialogCtx) => AlertDialog(
                              backgroundColor: AppColors.surface,
                              title: const Text('Khabar', style: TextStyle(color: AppColors.text)),
                              content: Text(
                                'Dena baki (₹$_denaBaki) se zyada payment (₹$amt) de rahe hain. Kya aage badhein?',
                                style: const TextStyle(color: AppColors.muted, fontSize: 13),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogCtx, false),
                                  child: const Text('Nahi', style: TextStyle(color: AppColors.muted)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.lime),
                                  onPressed: () => Navigator.pop(dialogCtx, true),
                                  child: const Text('Haan, jodein', style: TextStyle(color: AppColors.onLime)),
                                ),
                              ],
                            ),
                          );

                          if (confirm != true) return;
                        }

                        await _supplierService.recordSupplierPayment(
                          supplierId: widget.supplierId,
                          amount: amt,
                          mode: selectedMode,
                          date: selectedDate,
                          note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
                        );

                        nav.pop();
                        if (mounted) _loadData();
                      },
                      child: const Text('Payment Save Karein', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(child: CircularProgressIndicator(color: AppColors.lime)),
      );
    }

    final s = _supplier;
    final rate = s?.ratePerUnit ?? 10;
    final unitName = s?.unitName ?? 'chai';
    final categoryName = s?.category ?? 'Chai wale';
    final todayAmount = _todayCount * rate;

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
                  const Text('Supplier khata', style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (_supplier != null) {
                        SupplierPdfGenerator.printOrShareStatement(
                          supplier: _supplier!,
                          pooraHisaab: _pooraHisaab,
                          denaBaki: _denaBaki,
                          shop: _shopSettings,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.share_rounded, color: AppColors.text, size: 13),
                          SizedBox(width: 4),
                          Text('PDF', style: TextStyle(color: AppColors.text, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.expenseBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Humein dena hai', style: TextStyle(color: AppColors.expense, fontSize: 11, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Supplier Summary Card (.card)
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
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2B24A),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.local_cafe_rounded, color: Color(0xFF3A2600), size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s?.name ?? '', style: const TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.bold)),
                              Text('$categoryName · ₹$rate / $unitName', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Abhi dena baki', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹$_denaBaki', style: const TextStyle(color: AppColors.expense, fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Stepper Card ("Aaj ki chai") (.s2)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aaj ki $unitName', style: const TextStyle(color: AppColors.lime, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Decrement (-)
                        GestureDetector(
                          onTap: () {
                            if (_todayCount > 1) {
                              setState(() => _todayCount--);
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.surface3,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Text('−', style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),

                        // Center Count & Subtitle
                        Column(
                          children: [
                            Text('$_todayCount', style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold)),
                            Text('$_todayCount × ₹$rate = ₹$todayAmount', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                          ],
                        ),

                        // Increment (+)
                        GestureDetector(
                          onTap: () {
                            setState(() => _todayCount++);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.surface3,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Text('+', style: TextStyle(color: AppColors.lime, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // "Khate mein jodo" button
                    GestureDetector(
                      onTap: _addTodayEntry,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text('Khate mein jodo (₹$todayAmount)', style: const TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // "Paise diye" Outline Button (.btn.bol)
              GestureDetector(
                onTap: _showPaiseDiyeModal,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 1),
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.surface,
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payments_outlined, color: AppColors.lime, size: 18),
                      SizedBox(width: 8),
                      Text('Paise diye', style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Two Tab Chips ("Poora hisaab" vs "Diye hue paise")
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 'poora_hisaab'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _selectedTab == 'poora_hisaab' ? AppColors.surface3 : Colors.transparent,
                        border: Border.all(color: _selectedTab == 'poora_hisaab' ? AppColors.border : Colors.transparent, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Poora hisaab',
                        style: TextStyle(
                          color: _selectedTab == 'poora_hisaab' ? AppColors.text : AppColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = 'diye_hue_paise'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: _selectedTab == 'diye_hue_paise' ? AppColors.surface3 : Colors.transparent,
                        border: Border.all(color: _selectedTab == 'diye_hue_paise' ? AppColors.border : Colors.transparent, width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Diye hue paise',
                        style: TextStyle(
                          color: _selectedTab == 'diye_hue_paise' ? AppColors.text : AppColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Tab Content List
              if (_selectedTab == 'poora_hisaab') ...[
                if (_pooraHisaab.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    child: const Text('Is khate mein koi entry nahi hai', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: _pooraHisaab.map((item) {
                        final isEntry = item['type'] == 'entry';
                        final date = item['date'] as DateTime;
                        final dateStr = DateFormat('dd MMM').format(date);
                        final amt = item['amount'] as int;
                        final count = item['count'];
                        final mode = item['mode'];

                        final title = isEntry
                            ? (count != null ? '$count $unitName' : 'Entry')
                            : 'Paise diye';
                        final subtitle = isEntry
                            ? 'Aaj · ₹$rate × $count'
                            : '$dateStr · ${(mode ?? '').toString().toUpperCase()}';

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
                                  color: isEntry ? const Color(0xFF2A2112) : AppColors.limeTintBg,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  isEntry ? Icons.local_cafe_rounded : Icons.payments_rounded,
                                  color: isEntry ? const Color(0xFFF2B24A) : AppColors.lime,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                    Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Text(
                                isEntry ? '+₹$amt' : '−₹$amt',
                                style: TextStyle(
                                  color: isEntry ? AppColors.expense : AppColors.lime,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ] else ...[
                if (_diyeHuePaise.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    child: const Text('Abhi tak koi payment nahi di gayi', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: _diyeHuePaise.map((p) {
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
                                decoration: const BoxDecoration(
                                  color: AppColors.limeTintBg,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.payments_rounded, color: AppColors.lime, size: 16),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Paise diye (${p.mode.toUpperCase()})', style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                    Text(DateFormat('dd MMM yyyy').format(p.date), style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Text(
                                '−₹${p.amount}',
                                style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
