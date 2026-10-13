import 'package:flutter/material.dart';
import '../motion.dart';
import '../theme/app_colors.dart';

class PaymentSuccessCheck extends StatefulWidget {
  final double size;

  const PaymentSuccessCheck({
    super.key,
    this.size = 56,
  });

  @override
  State<PaymentSuccessCheck> createState() => _PaymentSuccessCheckState();
}

class _PaymentSuccessCheckState extends State<PaymentSuccessCheck> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );
    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AppMotion.isAnimationsEnabled(context)) {
      return Icon(Icons.check_circle_rounded, color: AppColors.lime, size: widget.size);
    }

    return ScaleTransition(
      scale: _scaleAnim,
      child: Icon(Icons.check_circle_rounded, color: AppColors.lime, size: widget.size),
    );
  }
}
