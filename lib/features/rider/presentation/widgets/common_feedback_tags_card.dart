import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CommonFeedbackTagsCard extends StatelessWidget {
  const CommonFeedbackTagsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Common Feedback Tags',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'LAST 6 MONTHS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                _buildTag(
                  'Polite Driver',
                  20,
                  FontWeight.w800,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Clean Car',
                  16,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
                _buildTag(
                  'Smooth Ride',
                  18,
                  FontWeight.bold,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Professional',
                  12,
                  FontWeight.w600,
                  const Color(0xFF94A3B8),
                ), // Light grey text
                _buildTag(
                  'Great Route',
                  22,
                  FontWeight.w900,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Safe Driving',
                  14,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
                _buildTag(
                  'Punctual',
                  10,
                  FontWeight.w800,
                  AppColors.textPrimary,
                ),
                _buildTag('Music', 16, FontWeight.bold, AppColors.textPrimary),
                _buildTag(
                  'Helpful',
                  18,
                  FontWeight.bold,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Quick Pickup',
                  12,
                  FontWeight.bold,
                  const Color(0xFF94A3B8),
                ),
                _buildTag(
                  'Fair Price',
                  14,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(
    String text,
    double fontSize,
    FontWeight weight,
    Color color,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        height: 1.0,
      ),
    );
  }
}
