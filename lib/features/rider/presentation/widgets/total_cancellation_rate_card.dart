import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class TotalCancellationRateCard extends StatelessWidget {
  TotalCancellationRateCard({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'TOTAL CANCELLATION RATE',
              style: AppTypography.base.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '4.2',
                  style: AppTypography.base.copyWith(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  '%',
                  style: AppTypography.base.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              '6 failed completions out of 142 bookings',
              textAlign: TextAlign.center,
              style: AppTypography.base.copyWith(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}



