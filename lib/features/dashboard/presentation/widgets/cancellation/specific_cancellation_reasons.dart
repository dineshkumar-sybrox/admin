import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class SpecificCancellationReasons extends StatelessWidget {
  SpecificCancellationReasons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cancellation Reasons in Anna Nagar',
                    style: AppTypography.base.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF1A1D1F,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Specific to current zone critical period',
                    style: AppTypography.base.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFF9EA5AD,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.bar_chart_rounded,
                color: AppColors.cFF9EA5AD.withValues(alpha: 0.5),
                size: 28,
              ),
            ],
          ),
          SizedBox(height: 32),
          _buildReasonBar(
            'High wait time',
            0.48,
            '48%',
            AppColors.cFFEA3546,
          ),
          SizedBox(height: 24),
          _buildReasonBar(
            'Driver took too long to arrive',
            0.32,
            '32%',
            AppColors.cFFF27B86,
          ),
          SizedBox(height: 24),
          _buildReasonBar(
            'Found another alternative',
            0.12,
            '12%',
            AppColors.cFF9EA5AD,
          ),
          SizedBox(height: 24),
          _buildReasonBar(
            'App/GPS Glitch',
            0.08,
            '8%',
            AppColors.cFFD6DBE1,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReasonBar(
    String title,
    double progress,
    String percentage,
    Color activeColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            Text(
              percentage,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.cFFF4F6F9,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: (progress * 100).toInt(),
                child: Container(
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: ((1 - progress) * 100).toInt(),
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



