import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback? onFinished;

  const SplashScreen({super.key, this.onFinished});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Square logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/branding/app_icon_dark.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 14),
              // App Title
              const Text(
                'Kanta Slip',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle in Lime
              const Text(
                'कांटा स्लिप',
                style: TextStyle(
                  color: AppColors.lime,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              // Shop Name
              const Text(
                'जोशी कम्प्यूटराइज धर्मकांटा',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
