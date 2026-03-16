import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class PaginationControls extends StatelessWidget {
  PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1 - 5 of 22,482 drivers',
            style: AppTypography.base.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              _PageButton(icon: Icons.chevron_left, onPressed: () {}),
              SizedBox(width: 8),
              _PageButton(label: '1', onPressed: () {}, isActive: true),
              SizedBox(width: 8),
              _PageButton(label: '2', onPressed: () {}),
              SizedBox(width: 8),
              _PageButton(label: '3', onPressed: () {}),
              SizedBox(width: 8),
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
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.cFFE5E7EB,
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 16, color: AppColors.cFF6B7280)
            : Text(
                label!,
                style: AppTypography.base.copyWith(
                  color: isActive ? AppColors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}




