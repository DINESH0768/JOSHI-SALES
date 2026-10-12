import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/earning_history_service.dart';

class KamaiHistoryScreen extends StatefulWidget {
  final AppDatabase db;

  const KamaiHistoryScreen({super.key, required this.db});

  @override
  State<KamaiHistoryScreen> createState() => _KamaiHistoryScreenState();
}

class _KamaiHistoryScreenState extends State<KamaiHistoryScreen> {
  late EarningHistoryService _historyService;

  int _selectedDays = 7; // 7, 15, 30, or 0 if custom month
  DateTime? _customMonth;

  String _metricMode = 'kamai'; // 'kamai', 'kharcha', 'bachat'

  HistorySummaryData? _summaryData;
  int _touchedIndex = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _historyService = EarningHistoryService(widget.db);
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await _historyService.getEarningHistoryForRange(
      days: _selectedDays,
      customMonth: _customMonth,
    );

    if (mounted) {
      setState(() {
        _summaryData = data;
        _isLoading = false;
        if (data.dailyPoints.isNotEmpty) {
          _touchedIndex = data.dailyPoints.length - 1; // Default to last day
        } else {
          _touchedIndex = -1;
        }
      });
    }
  }

  Future<void> _selectMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customMonth ?? DateTime.now(),
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
        _selectedDays = 0;
        _customMonth = DateTime(picked.year, picked.month);
        _isLoading = true;
      });
      _loadHistory();
    }
  }

  void _showDailyPaymentsModal(DateTime date, List<PaymentsTableData> payments) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final dateStr = DateFormat('dd MMM yyyy').format(date);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payments ($dateStr)',
                    style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.muted),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (payments.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('Is din koi payment nahi hui', style: TextStyle(color: AppColors.muted, fontSize: 12))),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: payments.length,
                    separatorBuilder: (_, __) => const Divider(color: AppColors.border, height: 1),
                    itemBuilder: (_, i) {
                      final p = payments[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
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
                        title: Text(
                          'Payment (${p.mode.toUpperCase()})',
                          style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          DateFormat('hh:mm a').format(p.receivedAt),
                          style: const TextStyle(color: AppColors.muted, fontSize: 11),
                        ),
                        trailing: Text(
                          '₹${EarningHistoryService.formatIndianCurrency(p.amount)}',
                          style: const TextStyle(color: AppColors.lime, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Color get _activeMetricColor {
    switch (_metricMode) {
      case 'kharcha':
        return AppColors.expense;
      case 'bachat':
        return AppColors.upiBlue;
      default:
        return AppColors.lime;
    }
  }

  int _getMetricValue(DailyMetricPoint pt) {
    switch (_metricMode) {
      case 'kharcha':
        return pt.expense;
      case 'bachat':
        return pt.bachat;
      default:
        return pt.income;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    String rangeTitle;
    if (_selectedDays > 0) {
      rangeTitle = 'Pichle $_selectedDays din ki kamai';
    } else if (_customMonth != null) {
      rangeTitle = '${DateFormat('MMMM yyyy').format(_customMonth!)} ki kamai';
    } else {
      rangeTitle = 'Kamai history';
    }

    final data = _summaryData;
    final points = data?.dailyPoints ?? [];

    DailyMetricPoint? selectedPoint;
    if (_touchedIndex >= 0 && _touchedIndex < points.length) {
      selectedPoint = points[_touchedIndex];
    } else if (points.isNotEmpty) {
      selectedPoint = points.last;
    }

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
                  const Text('Kamai history', style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const Icon(Icons.more_vert_rounded, color: AppColors.text, size: 20),
                ],
              ),
              const SizedBox(height: 12),

              // Bada Total
              Column(
                children: [
                  Text(rangeTitle, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    '₹${EarningHistoryService.formatIndianCurrency(data?.currentTotalIncome ?? 0)}',
                    style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Range chips 7 din / 15 din / 30 din + Month Picker
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRangeChip(7, '7 din'),
                    const SizedBox(width: 6),
                    _buildRangeChip(15, '15 din'),
                    const SizedBox(width: 6),
                    _buildRangeChip(30, '30 din'),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: _selectMonth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: _selectedDays == 0 ? AppColors.lime : AppColors.surface3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _customMonth != null ? DateFormat('MMM yyyy').format(_customMonth!) : 'Month',
                              style: TextStyle(
                                color: _selectedDays == 0 ? AppColors.onLime : AppColors.text,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.calendar_month_rounded,
                              color: _selectedDays == 0 ? AppColors.onLime : AppColors.text,
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Metric Toggle Selector (Kamai / Kharcha / Bachat)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMetricToggle('kamai', 'Kamai', AppColors.lime),
                  const SizedBox(width: 6),
                  _buildMetricToggle('kharcha', 'Kharcha', AppColors.expense),
                  const SizedBox(width: 6),
                  _buildMetricToggle('bachat', 'Bachat', AppColors.upiBlue),
                ],
              ),

              const SizedBox(height: 16),

              // fl_chart Smooth Curved Line Graph
              if (_isLoading)
                const SizedBox(height: 150, child: Center(child: CircularProgressIndicator(color: AppColors.lime)))
              else if (points.isEmpty)
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: const Text('Is period mein koi data nahi hai', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                )
              else
                SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        enabled: true,
                        handleBuiltInTouches: true,
                        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                          if (event is FlTapUpEvent || event is FlPanUpdateEvent) {
                            if (touchResponse != null && touchResponse.lineBarSpots != null && touchResponse.lineBarSpots!.isNotEmpty) {
                              final spotIndex = touchResponse.lineBarSpots!.first.spotIndex;
                              setState(() {
                                _touchedIndex = spotIndex;
                              });
                            }
                          }
                        },
                        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((spotIndex) {
                            return TouchedSpotIndicatorData(
                              FlLine(color: _activeMetricColor.withValues(alpha: 0.5), strokeWidth: 1.5),
                              FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 5.5,
                                    color: AppColors.bg,
                                    strokeWidth: 3,
                                    strokeColor: _activeMetricColor,
                                  );
                                },
                              ),
                            );
                          }).toList();
                        },
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (spot) => _activeMetricColor,
                          tooltipMargin: 8,
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              final val = spot.y.toInt();
                              return LineTooltipItem(
                                '₹${EarningHistoryService.formatIndianCurrency(val)}',
                                const TextStyle(color: AppColors.onLime, fontSize: 11, fontWeight: FontWeight.bold),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            interval: (points.length / 4).clamp(1, 10).toDouble(),
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index >= 0 && index < points.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    DateFormat('d MMM').format(points[index].date),
                                    style: const TextStyle(color: AppColors.muted, fontSize: 10),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: points.asMap().entries.map((e) {
                            return FlSpot(e.key.toDouble(), _getMetricValue(e.value).toDouble());
                          }).toList(),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: _activeMetricColor,
                          barWidth: 2.2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: _activeMetricColor.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),
                    duration: disableAnimations ? Duration.zero : const Duration(milliseconds: 300),
                  ),
                ),

              const SizedBox(height: 14),

              // Dark Green Comparison Card ("Usse pehle ke N din")
              if (data != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12301A),
                    border: Border.all(color: const Color(0xFF1F5A2E), width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedDays > 0 ? 'Usse pehle ke $_selectedDays din' : 'Pichle mahine ki tulna',
                            style: const TextStyle(color: Color(0xFF9AD9A8), fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${EarningHistoryService.formatIndianCurrency(data.previousTotalIncome)}',
                            style: const TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: data.percentageChange >= 0 ? AppColors.limeTintBg : AppColors.expenseBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          data.percentageChange >= 0
                              ? '↑ ${data.percentageChange.toStringAsFixed(0)}%'
                              : '↓ ${data.percentageChange.abs().toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: data.percentageChange >= 0 ? AppColors.lime : AppColors.expense,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 12),

              // Selected Day Summary Card (.s2)
              if (selectedPoint != null) ...[
                Builder(builder: (context) {
                  final pt = selectedPoint!;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('dd MMM').format(pt.date)} · kul ₹${EarningHistoryService.formatIndianCurrency(pt.income)}',
                          style: const TextStyle(color: AppColors.lime, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        // Cash Row
                        GestureDetector(
                          onTap: () {
                            final dayPayments = data?.paymentsByDate[pt.date] ?? [];
                            _showDailyPaymentsModal(pt.date, dayPayments.where((p) => p.mode == 'cash').toList());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                                      const Text('Cash', style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                      Text('${pt.cashCount} payment', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${EarningHistoryService.formatIndianCurrency(pt.cashIncome)}',
                                  style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // UPI Row
                        GestureDetector(
                          onTap: () {
                            final dayPayments = data?.paymentsByDate[pt.date] ?? [];
                            _showDailyPaymentsModal(pt.date, dayPayments.where((p) => p.mode == 'upi').toList());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: AppColors.upiBg,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.qr_code_2_rounded, color: AppColors.upiBlue, size: 16),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('UPI', style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                      Text('${pt.upiCount} payment', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${EarningHistoryService.formatIndianCurrency(pt.upiIncome)}',
                                  style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRangeChip(int days, String label) {
    final isSelected = _selectedDays == days;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDays = days;
          _customMonth = null;
          _isLoading = true;
        });
        _loadHistory();
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
            color: isSelected ? AppColors.onLime : AppColors.text,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMetricToggle(String mode, String label, Color color) {
    final isSelected = _metricMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _metricMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.surface2,
          border: Border.all(color: isSelected ? color : AppColors.border, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? (mode == 'kamai' ? AppColors.onLime : Colors.white) : AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
