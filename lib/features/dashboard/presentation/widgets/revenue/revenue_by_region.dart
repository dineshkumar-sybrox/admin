import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class RevenueByRegion extends StatelessWidget {
  RevenueByRegion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'REVENUE BY TAMIL NADU',
            style: AppTypography.base.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.cFF1A1D1F,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 24),
          _buildRegionProgressBar('Chennai', '₹450k', '38%', 0.38),
          SizedBox(height: 20),
          _buildRegionProgressBar('Kanchipuram', '₹320k', '27%', 0.27),
          SizedBox(height: 20),
          _buildRegionProgressBar('Thiruvallur', '₹280k', '23%', 0.23),
        ],
      ),
    );
  }

  Widget _buildRegionProgressBar(
    String city,
    String amount,
    String percent,
    double progress,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              city,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            RichText(
              text: TextSpan(
                text: amount,
                style: AppTypography.base.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cFF6F767E,
                ),
                children: [
                  TextSpan(
                    text: ' ($percent)',
                    style: AppTypography.base.copyWith(color: AppColors.cFF9EA5AD),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.cFFF4F6F9,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.cFF00A86B,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}




