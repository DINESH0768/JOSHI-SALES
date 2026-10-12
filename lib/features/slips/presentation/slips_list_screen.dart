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
  List<SlipsTableData> _slips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSlips();
  }

  Future<void> _loadSlips() async {
    final list = await (widget.db.select(widget.db.slipsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();

    if (mounted) {
      setState(() {
        _slips = list;
        _isLoading = false;
      });
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
              padding: const EdgeInsets.all(14),
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

            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.lime))
                  : _slips.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.muted),
                              const SizedBox(height: 12),
                              const Text('Koi slip nahi hai', style: TextStyle(color: AppColors.muted, fontSize: 14)),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => context.push('/slips/new'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.lime,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Text('Nayi slip banao', style: TextStyle(color: AppColors.onLime, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          itemCount: _slips.length,
                          itemBuilder: (context, index) {
                            final slip = _slips[index];
                            final dateStr = DateFormat('dd MMM yyyy').format(slip.date);

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
                                            color: AppColors.pendingBg,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            slip.status,
                                            style: const TextStyle(
                                              color: AppColors.pendingFg,
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
}
