import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 1 - 5 of 22,482 drivers',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              _PageButton(icon: Icons.chevron_left, onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(label: '1', onPressed: () {}, isActive: true),
              const SizedBox(width: 8),
              _PageButton(label: '2', onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(label: '3', onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(icon: Icons.chevron_right, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isActive;

  const _PageButton({
    this.label,
    this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primary : const Color(0xFFE5E7EB),
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 16, color: const Color(0xFF6B7280))
            : Text(
                label!,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
