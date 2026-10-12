import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';

class SlipsListScreen extends StatefulWidget {
  final AppDatabase db;

  const SlipsListScreen({super.key, required this.db});

  @override
  State<SlipsListScreen> createState() => _SlipsListScreenState();
}

class _SlipsListScreenState extends State<SlipsListScreen> {
  List<SlipsTableData> _allSlips = [];
  List<SlipsTableData> _filteredSlips = [];
  bool _isLoading = true;

  final _searchController = TextEditingController();
  DateTime? _selectedDateFilter;
  String _statusFilter = 'sab'; // 'sab', 'pending', 'received', 'udhar'

  @override
  void initState() {
    super.initState();
    _loadSlips();
    _searchController.addListener(_applyFilters);
  }

  Future<void> _loadSlips() async {
    final list = await (widget.db.select(widget.db.slipsTable)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();

    if (mounted) {
      setState(() {
        _allSlips = list;
        _isLoading = false;
      });
      _applyFilters();
    }
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredSlips = _allSlips.where((s) {
        // Status filter
        if (_statusFilter != 'sab' && s.status != _statusFilter) {
          return false;
        }

        // Date filter
        if (_selectedDateFilter != null) {
          final sDate = s.date;
          if (sDate.year != _selectedDateFilter!.year ||
              sDate.month != _selectedDateFilter!.month ||
              sDate.day != _selectedDateFilter!.day) {
            return false;
          }
        }

        // Search text query (matches customer name, vehicle no, receipt no)
        if (query.isNotEmpty) {
          final cust = s.customerName?.toLowerCase() ?? '';
          final veh = s.vehicleNo?.toLowerCase() ?? '';
          final rec = '${s.receiptNo}';
          if (!cust.contains(query) && !veh.contains(query) && !rec.contains(query)) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  Future<void> _pickDateFilter() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateFilter ?? DateTime.now(),
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

    if (picked != null) {
      setState(() {
        _selectedDateFilter = picked;
      });
      _applyFilters();
    }
  }

  Color _getStatusBg(String status) {
    switch (status) {
      case 'received':
        return AppColors.limeTintBg;
      case 'udhar':
        return AppColors.udharBlueBg;
      case 'pending':
      default:
        return AppColors.pendingBg;
    }
  }

  Color _getStatusFg(String status) {
    switch (status) {
      case 'received':
        return AppColors.lime;
      case 'udhar':
        return AppColors.udharBlueFg;
      case 'pending':
      default:
        return AppColors.pendingFg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header (.hd)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Slips',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/slips/new'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.lime,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add_rounded, color: AppColors.onLime, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Nayi slip',
                            style: TextStyle(
                              color: AppColors.onLime,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar & Date Picker Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: AppColors.muted, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: AppColors.text, fontSize: 13),
                              decoration: const InputDecoration(
                                hintText: 'Naam, gaadi no, या रसीद नं.',
                                hintStyle: TextStyle(color: AppColors.muted, fontSize: 12),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () => _searchController.clear(),
                              child: const Icon(Icons.close_rounded, color: AppColors.muted, size: 16),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _pickDateFilter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _selectedDateFilter != null ? AppColors.lime : AppColors.surface,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: _selectedDateFilter != null ? AppColors.onLime : AppColors.text,
                        size: 18,
                      ),
                    ),
                  ),
                  if (_selectedDateFilter != null)
                    GestureDetector(
                      onTap: () {
                        setState(() => _selectedDateFilter = null);
                        _applyFilters();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.cancel_rounded, color: AppColors.muted, size: 18),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Status Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _buildChip('Sab', 'sab'),
                  const SizedBox(width: 6),
                  _buildChip('Pending', 'pending'),
                  const SizedBox(width: 6),
                  _buildChip('Received', 'received'),
                  const SizedBox(width: 6),
                  _buildChip('Udhar', 'udhar'),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Slips List View
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.lime))
                  : _filteredSlips.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.muted),
                              const SizedBox(height: 12),
                              const Text('Koi slip nahi mili', style: TextStyle(color: AppColors.muted, fontSize: 14)),
                              const SizedBox(height: 14),
                              GestureDetector(
                                onTap: () => context.push('/slips/new'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.lime,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Text('Nayi slip', style: TextStyle(color: AppColors.onLime, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          itemCount: _filteredSlips.length,
                          itemBuilder: (context, index) {
                            final slip = _filteredSlips[index];
                            final dateStr = DateFormat('dd MMM').format(slip.date);

                            return GestureDetector(
                              onTap: () => context.push('/slips/card/${slip.id}'),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.border, width: 0.5),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.surface2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '#${slip.receiptNo}',
                                        style: const TextStyle(
                                          color: AppColors.lime,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            slip.vehicleNo ?? slip.customerName ?? 'Slip #${slip.receiptNo}',
                                            style: const TextStyle(
                                              color: AppColors.text,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${slip.customerName ?? ""} · $dateStr',
                                            style: const TextStyle(
                                              color: AppColors.muted,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '₹${slip.charge}',
                                          style: const TextStyle(
                                            color: AppColors.lime,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getStatusBg(slip.status),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            slip.status,
                                            style: TextStyle(
                                              color: _getStatusFg(slip.status),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _statusFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() => _statusFilter = value);
        _applyFilters();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lime : AppColors.surface3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.onLime : AppColors.text,
          ),
        ),
      ),
    );
  }
}
