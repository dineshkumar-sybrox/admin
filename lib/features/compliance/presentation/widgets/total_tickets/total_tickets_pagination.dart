import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class TotalTicketsPagination extends StatelessWidget {
  final int totalFiltered;

  const TotalTicketsPagination({super.key, required this.totalFiltered});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cFFF8FAFC,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SHOWING 1-10 OF 142 RIDES',
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          Row(
            children: [
              _buildPageButton('<', false),
              SizedBox(width: 8),
              _buildPageButton('1', true),
              SizedBox(width: 8),
              _buildPageButton('2', false),
              SizedBox(width: 8),
              _buildPageButton('3', false),
              SizedBox(width: 8),
              _buildPageButton('>', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(String text, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? AppColors.cFF00A86B : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.base.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: isActive ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
