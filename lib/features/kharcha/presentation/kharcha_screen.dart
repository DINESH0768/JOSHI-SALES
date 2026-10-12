import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/expense_service.dart';
import '../domain/services/supplier_service.dart';

class KharchaScreen extends StatefulWidget {
  final AppDatabase db;

  const KharchaScreen({super.key, required this.db});

  @override
  State<KharchaScreen> createState() => _KharchaScreenState();
}

class _KharchaScreenState extends State<KharchaScreen> {
  late ExpenseService _expenseService;
  late SupplierService _supplierService;

  DateTime _selectedMonth = DateTime.now();

  int _totalIncome = 0;
  int _totalExpense = 0;
  int _bachat = 0;
  List<ExpensesTableData> _expenses = [];
  Map<String, int> _categoryTotals = {};
  int _supplierDenaBaki = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _expenseService = ExpenseService(widget.db);
    _supplierService = SupplierService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final summary = await _expenseService.getMonthlySummary(_selectedMonth);
    final totalDena = await _supplierService.getTotalSuppliersDenaBaki();

    if (mounted) {
      setState(() {
        _totalIncome = summary['totalIncome'] as int;
        _totalExpense = summary['totalExpense'] as int;
        _bachat = summary['bachat'] as int;
        _expenses = summary['expenses'] as List<ExpensesTableData>;
        _categoryTotals = summary['categoryTotals'] as Map<String, int>;
        _supplierDenaBaki = totalDena;
        _isLoading = false;
      });
    }
  }

  Future<void> _selectMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
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

    if (picked != null) {
      setState(() {
        _selectedMonth = DateTime(picked.year, picked.month);
        _isLoading = true;
      });
      _loadData();
    }
  }

  void _showAddExpenseModal([ExpensesTableData? existingExpense]) {
    final amountController = TextEditingController(
      text: existingExpense != null ? existingExpense.amount.toString() : '',
    );
    final nameController = TextEditingController(
      text: existingExpense != null ? existingExpense.name : '',
    );
    final noteController = TextEditingController(
      text: existingExpense?.note ?? '',
    );

    String selectedMode = existingExpense?.mode ?? 'cash';
    DateTime selectedDate = existingExpense?.date ?? DateTime.now();
    String? amountError;
    String? nameError;

    final defaultChips = ['Majduri', 'Bijli', 'Chai-pani', 'Repair', 'Rent'];

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
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          existingExpense != null ? 'Kharcha badlein' : 'Naya kharcha',
                          style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.muted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Amount Field (Lime border)
                    const Text('Rakam (₹) *', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: const TextStyle(color: AppColors.muted),
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

                    // Expense Name Field
                    const Text('Kharche ka naam *', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: AppColors.text, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Majduri, Bijli, Chai',
                        hintStyle: const TextStyle(color: AppColors.muted),
                        filled: true,
                        fillColor: AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.lime, width: 1),
                        ),
                        errorText: nameError,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: defaultChips.map((chip) {
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              nameController.text = chip;
                              nameError = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                            decoration: BoxDecoration(
                              color: nameController.text == chip ? AppColors.lime : AppColors.surface3,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chip,
                              style: TextStyle(
                                color: nameController.text == chip ? AppColors.onLime : AppColors.text,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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

                    // Date selector & Note field
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: noteController,
                      style: const TextStyle(color: AppColors.text, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Note (optional e.g. Kante ka sensor)',
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

                    // Save Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lime,
                        foregroundColor: AppColors.onLime,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        final amtText = amountController.text.trim();
                        final nameText = nameController.text.trim();

                        setModalState(() {
                          amountError = amtText.isEmpty || (int.tryParse(amtText) ?? 0) <= 0 ? 'Rakam likho' : null;
                          nameError = nameText.isEmpty ? 'Kharche ka naam likho' : null;
                        });

                        if (amountError != null || nameError != null) return;

                        final amount = int.parse(amtText);
                        final nav = Navigator.of(ctx);

                        if (existingExpense != null) {
                          await _expenseService.updateExpense(
                            id: existingExpense.id,
                            name: nameText,
                            amount: amount,
                            mode: selectedMode,
                            date: selectedDate,
                            note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
                          );
                        } else {
                          await _expenseService.addExpense(
                            name: nameText,
                            amount: amount,
                            mode: selectedMode,
                            date: selectedDate,
                            note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
                          );
                        }

                        nav.pop();
                        if (mounted) {
                          _loadData();
                        }
                      },
                      child: Text(
                        existingExpense != null ? 'Save karein' : 'Kharcha jodein',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
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

  Color _parseColorHex(String hex) {
    final clean = hex.replaceAll('#', '');
    if (clean.length == 6) {
      return Color(int.parse('FF$clean', radix: 16));
    }
    return AppColors.muted;
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'people':
        return Icons.people_alt_rounded;
      case 'zap':
        return Icons.flash_on_rounded;
      case 'coffee':
        return Icons.local_cafe_rounded;
      case 'tool':
        return Icons.build_rounded;
      case 'home':
        return Icons.home_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthStr = DateFormat('MMM').format(_selectedMonth);

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
                  const Text('Kharcha', style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _selectMonth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(monthStr, style: const TextStyle(color: AppColors.text, fontSize: 11)),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.text, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Is mahine ki bachat
              Column(
                children: [
                  const Text('Is mahine ki bachat', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    '₹${NumberFormat('#,##0').format(_bachat)}',
                    style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Kamai & Kharcha side by side cards
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
                          const Text('Kamai', style: TextStyle(color: AppColors.lime, fontSize: 11)),
                          const SizedBox(height: 2),
                          Text('₹${NumberFormat('#,##0').format(_totalIncome)}', style: const TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.expenseBg,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.expenseBorder, width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Kharcha', style: TextStyle(color: AppColors.expense, fontSize: 11)),
                          const SizedBox(height: 2),
                          Text('₹${NumberFormat('#,##0').format(_totalExpense)}', style: const TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // "Kharcha kahan gaya" Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kharcha kahan gaya', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 8),
                    // Rangeen split bar
                    Container(
                      height: 10,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.antiAlias,
                      child: _totalExpense == 0
                          ? Container(color: AppColors.surface3)
                          : Row(
                              children: _categoryTotals.entries.map((entry) {
                                final pct = (entry.value / _totalExpense).clamp(0.01, 1.0);
                                final colorHex = ExpenseCategoryHelper.getColorHex(entry.key);
                                return Expanded(
                                  flex: (pct * 1000).toInt(),
                                  child: Container(color: _parseColorHex(colorHex)),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // "+ Naya kharcha" Button (.btn.bl)
              GestureDetector(
                onTap: () => _showAddExpenseModal(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded, color: AppColors.onLime, size: 18),
                      SizedBox(width: 6),
                      Text('Naya kharcha', style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Pichle kharche list (.s2)
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.lime))
              else if (_expenses.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: const Text('Is mahine koi kharcha nahi hua', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: _expenses.map((e) {
                      final colorHex = ExpenseCategoryHelper.getColorHex(e.name);
                      final iconName = ExpenseCategoryHelper.getIconName(e.name);
                      final color = _parseColorHex(colorHex);
                      final icon = _getCategoryIcon(iconName);
                      final subtitleText = '${e.note != null && e.note!.isNotEmpty ? '${e.note} · ' : ''}${e.mode.toUpperCase()} · ${DateFormat('dd MMM').format(e.date)}';

                      return Dismissible(
                        key: Key(e.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: AppColors.expense,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete_rounded, color: Colors.white, size: 20),
                        ),
                        onDismissed: (_) async {
                          final deletedItem = e;
                          final scaffoldMessenger = ScaffoldMessenger.of(context);
                          await _expenseService.softDeleteExpense(e.id);
                          _loadData();

                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('${deletedItem.name} hataya gaya'),
                              backgroundColor: AppColors.surface,
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: AppColors.lime,
                                onPressed: () async {
                                  await _expenseService.undoDeleteExpense(deletedItem.id);
                                  _loadData();
                                },
                              ),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => _showAddExpenseModal(e),
                          child: Container(
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
                                    color: AppColors.surface3,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(icon, color: color, size: 17),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.name, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                      Text(subtitleText, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '−₹${e.amount}',
                                  style: const TextStyle(color: AppColors.expense, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 10),

              // Supplier Khata card link
              GestureDetector(
                onTap: () => context.push('/kharcha/suppliers'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Supplier khata', style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('Humein dena hai: ₹$_supplierDenaBaki', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.muted, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 80), // bottom nav spacing
            ],
          ),
        ),
      ),
    );
  }
}
