import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '$title Screen',
          style: const TextStyle(color: AppColors.muted, fontSize: 16),
        ),
      ),
    );
  }
}
