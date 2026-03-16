import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class RideOutcomeDistribution extends StatelessWidget {
  RideOutcomeDistribution({super.key});

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
              'Ride Outcome Distribution',
              style: AppTypography.base.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // List of outcomes (Left side)
                Expanded(
                  child: Column(
                    children: [
                      _buildOutcomeItem(
                        label: "COMPLETED",
                        count: 136,
                        total: 142, // total rides
                        color: AppColors.success
                      ),
                      _buildOutcomeItem(
                        label: "CANCELLED BY USER",
                        count: 4,
                        total: 142,
                        color: AppColors.red,
                      ),
                      _buildOutcomeItem(
                        label: "CANCELLED BY DRIVER",
                        count: 2,
                        total: 142,
                        color: AppColors.orange,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 40),

                // Donut Chart (Right side)
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 4, // Gaps between sections
                          centerSpaceRadius: 65, // Thinner ring
                          startDegreeOffset: 270,
                          sections: [
                            PieChartSectionData(
                              color: AppColors.success,
                              value: 95.8,
                              title: '',
                              radius: 12,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              color: AppColors.cFFE5E7EB,
                              value: 3,
                              title: '',
                              radius: 12,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              color: AppColors.warning,
                              value: 1.2,
                              title: '',
                              radius: 12,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '95.8%',
                            style: AppTypography.base.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'SUCCESS',
                            style: AppTypography.base.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutcomeItem({
    required String label,
    required int count,
    required int total,
    required Color color,
  }) {
    final double percentage = total == 0 ? 0 : count / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.base.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Text(
              "$count RIDES",
              style: AppTypography.base.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 8),

        // 🔥 Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              // Background
              Container(
                height: 15,
                width: double.infinity,
                color: AppColors.divider.withValues(alpha: 0.4),
              ),

              // Filled Part
              FractionallySizedBox(
                widthFactor: percentage, // 👈 dynamic width
                child: Container(height: 15, color: color),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
      ],
    );
  }
}




