import 'package:flutter/material.dart';
import '../../features/income/domain/services/earning_history_service.dart';
import '../motion.dart';

class CountUpText extends StatefulWidget {
  final int value;
  final String prefix;
  final String suffix;
  final TextStyle style;

  const CountUpText({
    super.key,
    required this.value,
    this.prefix = '₹',
    this.suffix = '',
    required this.style,
  });

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _oldValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.countUp,
    );
    _animation = Tween<double>(begin: 0, end: widget.value.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(CountUpText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _animation = Tween<double>(
        begin: _oldValue.toDouble(),
        end: widget.value.toDouble(),
      ).animate(
        CurvedAnimation(parent: _controller, curve: AppMotion.easeOutCubic),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AppMotion.isAnimationsEnabled(context)) {
      final formatted = EarningHistoryService.formatIndianCurrency(widget.value);
      return Text('${widget.prefix}$formatted${widget.suffix}', style: widget.style);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentVal = _animation.value.round();
        final formatted = EarningHistoryService.formatIndianCurrency(currentVal);
        return Text('${widget.prefix}$formatted${widget.suffix}', style: widget.style);
      },
    );
  }
}
