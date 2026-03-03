import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RideOutcomeDistribution extends StatelessWidget {
  const RideOutcomeDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ride Outcome Distribution',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // List of outcomes (Left side)
                Expanded(
                  child: Column(
                    children: [
                      _buildOutcomeItem(
                        label: 'COMPLETED',
                        count: '136 RIDES', // Screenshot shows "136 RIDES"
                        color: AppColors.success,
                        isFullWidth: true,
                      ),
                      const SizedBox(height: 20),
                      _buildOutcomeItem(
                        label: 'CANCELLED BY USER',
                        count: '4 RIDES',
                        color: const Color(0xFFE5E7EB), // Grey
                        isFullWidth: false, // shorter bar visual
                      ),
                      const SizedBox(height: 20),
                      _buildOutcomeItem(
                        label: 'CANCELLED BY\nDRIVER',
                        count: '2\nRIDES',
                        color: AppColors.warning,
                        isFullWidth: false,
                      ),
                    ],
                  ),
                ),

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
                              color: const Color(0xFFE5E7EB),
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
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '95.8%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'SUCCESS',
                            style: TextStyle(
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
    required String count,
    required Color color,
    required bool isFullWidth,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ],
    );
    // Note: The screenshot shows bars UNDER the text row.
    // For simplicity and preventing overflow, I'm just listing them,
    // but let's add the progress bar below cleanly.
  }
}
