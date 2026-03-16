import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class ServiceTypeBreakdown extends StatelessWidget {
  ServiceTypeBreakdown({super.key});

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
            'SERVICE TYPE BREAKDOWN',
            style: AppTypography.base.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.cFF1A1D1F,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildServiceCard(
                  'CAB',
                  '₹620k',
                  AppColors.cFFFFF6ED,
                  AppColors.cFFDC6803,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildServiceCard(
                  'AUTO',
                  '₹340k',
                  AppColors.cFFE8F2FF,
                  AppColors.cFF2970FF,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildServiceCard(
                  'BIKE/SCOOTER',
                  '₹240k',
                  AppColors.cFFECFDF3,
                  AppColors.cFF027A48,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cFFFFF9ED,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFFFE8CC),
            ),
            child: RichText(
              text: TextSpan(
                text: 'Pro Tip: ',
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cFFB54708,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                        'Prime rides are up 15% today compared to last Friday peak.',
                    style: AppTypography.base.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFFB54708,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String amount,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cFFF8F9FA,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF6F767E,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            amount,
            style: AppTypography.base.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}




