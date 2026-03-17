import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class CancellationReasonsCard extends StatelessWidget {
  CancellationReasonsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ATTRIBUTION: CANCELLATION REASONS',
              style: AppTypography.h3.copyWith(
                
              ),
            ),
            SizedBox(height: 24),
            _buildReasonRow(
              'DRIVER TOOK TOO LONG (ETA MISMATCH)',
              '3 OCCURRENCES',
              0.5,
            ),
            SizedBox(height: 16),
            _buildReasonRow('WRONG ADDRESS SHOWN', '2 OCCURRENCES', 0.33),
            SizedBox(height: 16),
            _buildReasonRow('UNABLE TO CONNECT DRIVER', '1 OCCURRENCE', 0.17),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonRow(String reason, String occurrence, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reason,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              occurrence,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.cFFF1F5F9, // Light grayish background
          color: AppColors.error,
          minHeight: 12,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}




