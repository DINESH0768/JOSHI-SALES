import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanta_slip/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // Header lime area (.lhd)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 34,
              left: 14,
              right: 14,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.lime,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  // Logo Square 34x34
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/branding/app_icon_lime.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Kanta Slip',
                    style: TextStyle(
                      color: AppColors.onLime,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  // Plus Action Button (34x34 circle with #0B0B0C background and #C6F432 plus icon)
                  GestureDetector(
                    onTap: () => context.push('/slips/new'),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: AppColors.bg,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppColors.lime,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Home Content', style: TextStyle(color: AppColors.muted)),
            ),
          ),
        ],
      ),
    );
  }
}
