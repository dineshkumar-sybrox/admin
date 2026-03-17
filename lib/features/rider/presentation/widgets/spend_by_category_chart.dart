import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class SpendByCategoryChart extends StatelessWidget {
  SpendByCategoryChart({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Spend by Category',
                style: AppTypography.h3
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                          color: AppColors.cFF334155,
                          value: 35,
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: AppColors.primary,
                          value: 35,
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          color: AppColors.cFFF59E0B,
                          value: 30,
                          title: '',
                          radius: 20,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Categories',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '3 Key Types',
                        style: AppTypography.base.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            _buildLegendItem(
              color: AppColors.cFF334155,
              title: 'Cab',
              amount: '₹4,357',
              percentage: '(35%)',
            ),
            SizedBox(height: 16),
            _buildLegendItem(
              color: AppColors.primary,
              title: 'Auto',
              amount: '₹4,358',
              percentage: '(35%)',
            ),
            SizedBox(height: 16),
            _buildLegendItem(
              color: AppColors.cFFF59E0B,
              title: 'Bike/Scooter',
              amount: '₹3,735',
              percentage: '(30%)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String title,
    required String amount,
    required String percentage,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: AppTypography.base.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: AppTypography.base.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(width: 4),
        Text(
          percentage,
          style: AppTypography.base.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}




