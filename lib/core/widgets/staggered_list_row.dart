import 'package:flutter/material.dart';
import '../motion.dart';

class StaggeredListRow extends StatefulWidget {
  final Widget child;
  final int index;

  const StaggeredListRow({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<StaggeredListRow> createState() => _StaggeredListRowState();
}

class _StaggeredListRowState extends State<StaggeredListRow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.base,
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.easeOutCubic),
    );

    _slideAnim = Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: AppMotion.easeOutCubic),
    );

    final delay = Duration(milliseconds: (widget.index * 40).clamp(0, 300));
    Future.delayed(delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AppMotion.isAnimationsEnabled(context)) {
      return widget.child;
    }

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: widget.child,
      ),
    );
  }
}
