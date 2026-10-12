import 'package:flutter/material.dart';
import 'package:kanta_slip/core/theme/app_colors.dart';

class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.receipt_long_rounded, label: 'Slips'),
      _NavItem(icon: Icons.pending_actions_rounded, label: 'Pending'),
      _NavItem(icon: Icons.account_balance_wallet_rounded, label: 'Udhar'),
      _NavItem(icon: Icons.payments_rounded, label: 'Kharcha'),
    ];

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              height: 36,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 14 : 0,
              ),
              width: isSelected ? null : 40,
              alignment: Alignment.center,
              decoration: isSelected
                  ? BoxDecoration(
                      color: AppColors.lime,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 18,
                    color: isSelected ? AppColors.onLime : AppColors.text,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: const TextStyle(
                        color: AppColors.onLime,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
