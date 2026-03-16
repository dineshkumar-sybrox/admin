import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class LastRideSummary extends StatelessWidget {
  LastRideSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Ride Summary',
              style: AppTypography.base.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'OCTOBER 28, 2023 AT 6:42 PM',
              style: AppTypography.base.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 24),

            // From -> To
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.cFFFFD600,
                        shape: BoxShape.circle,
                      ), // Yellow dot
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: AppColors.divider,
                      margin: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.rectangle,
                      ), // Black square
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocation(
                        'PICKUP',
                        'Prestige Tech Park, Outer Ring Rd',
                      ),
                      SizedBox(height: 24),
                      _buildLocation('DROPOFF', 'Indiranagar 100 Feet Road'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'VIEW FULL DETAILS',
                  style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(String label, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // PICKUP / DROPOFF
          style: AppTypography.base.copyWith(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4),
        Text(
          address,
          style: AppTypography.base.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}



