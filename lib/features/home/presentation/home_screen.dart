import 'package:flutter/material.dart';
import 'package:kanta_slip/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header lime area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.lime,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'J',
                      style: TextStyle(
                        color: AppColors.lime,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Kanta Slip',
                    style: TextStyle(
                      color: AppColors.onLime,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.onLime, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: Text('Home Content', style: TextStyle(color: AppColors.muted)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
