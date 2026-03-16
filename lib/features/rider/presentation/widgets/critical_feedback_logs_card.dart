import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class CriticalFeedbackLogsCard extends StatelessWidget {
  CriticalFeedbackLogsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Critical Feedback Logs',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ratings 3-stars and below',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFEE2E2, // Light red bg
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '9 TOTAL',
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          _buildFeedbackLogItem(
            stars: 2,
            date: 'OCT 14, 2023',
            comment:
                '"The driver was a bit rude when asking for the OTP. Also, the air conditioning wasn\'t very effective during the afternoon heat."',
            driverName: 'ARUN',
            hasBottomDivider: true,
          ),
          _buildFeedbackLogItem(
            stars: 2,
            date: 'OCT 14, 2023',
            comment:
                '"The driver was a bit rude when asking for the OTP. Also, the air conditioning wasn\'t very effective during the afternoon heat."',
            driverName: 'ARUN',
            hasBottomDivider: true,
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.divider),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'LOAD MORE LOGS',
                style: AppTypography.base.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackLogItem({
    required int stars,
    required String date,
    required String comment,
    required String driverName,
    required bool hasBottomDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < stars ? Icons.star : Icons.star_border,
                        size: 16,
                        color: index < stars
                            ? AppColors.amber
                            : AppColors.cFFCBD5E1, // Grey star border
                      );
                    }),
                  ),
                  Text(
                    date,
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                comment,
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.cFFE2E8F0,
                        child: Icon(Icons.person, size: 16, color: AppColors.grey),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'DRIVER: $driverName',
                        style: AppTypography.base.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.open_in_new,
                      size: 14,
                      color: AppColors.white,
                    ),
                    label: Text(
                      'VIEW RIDE',
                      style: AppTypography.base.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      minimumSize: Size(0, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (hasBottomDivider) Divider(height: 1),
      ],
    );
  }
}




