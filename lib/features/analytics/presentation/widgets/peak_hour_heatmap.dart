import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class PeakHourHeatmap extends StatelessWidget {
  PeakHourHeatmap({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peak Hour Demand Heatmap',
                    style: AppTypography.h3
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Hourly ride requests distribution',
                    style: AppTypography.base.copyWith(
                     
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Low',
                    style: AppTypography.base.copyWith(
                      
                      color: AppColors.cFF6F767E,
                    ),
                  ),
                  SizedBox(width: 8),
                  _buildLegendScaleDot(AppColors.cFFE8FDF2),
                  SizedBox(width: 4),
                  _buildLegendScaleDot(AppColors.cFF8CE0B9),
                  SizedBox(width: 4),
                  _buildLegendScaleDot(AppColors.cFF00C46B),
                  SizedBox(width: 4),
                  _buildLegendScaleDot(AppColors.cFF00894B),
                  SizedBox(width: 8),
                  Text(
                    'High',
                    style: AppTypography.base.copyWith(
                      
                      color: AppColors.cFF6F767E,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Column(
            children: [
              // X-Axis (Hours)
              Row(
                children: [
                  SizedBox(width: 40), // Left margin for Y-Axis labels
                  ...List.generate(24, (i) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          '${i}h',
                          style: AppTypography.base.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.cFF6F767E,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 8),
              // Heatmap Rows (Y-Axis Days)
              _buildHeatmapRow('Mon', _mockDataRow1()),
              _buildHeatmapRow('Tue', _mockDataRow2()),
              _buildHeatmapRow('Wed', _mockDataRow3()),
              _buildHeatmapRow('Thu', _mockDataRow4()),
              _buildHeatmapRow('Fri', _mockDataRow5()),
              _buildHeatmapRow('Sat', _mockDataRow6()),
              _buildHeatmapRow('Sun', _mockDataRow7()),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              _buildMultiplierLegend(AppColors.cFFE8FDF2, 'Normal'),
              SizedBox(width: 16),
              _buildMultiplierLegend(AppColors.cFF8CE0B9, 'Normal'),
              SizedBox(width: 16),
              _buildMultiplierLegend(AppColors.cFF00C46B, '1.2X'),
              SizedBox(width: 16),
              _buildMultiplierLegend(AppColors.cFF00A86B, '1.8X'),
              SizedBox(width: 16),
              _buildMultiplierLegend(AppColors.cFF00894B, '2.0X'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapRow(String day, List<int> intensities) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              day,
              style: AppTypography.base.copyWith(
                // fontSize: 11,
                // fontWeight: FontWeight.w700,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ),
          ...intensities.map((intensity) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getColorForIntensity(intensity),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return AppColors.cFFF4F6F9; // Empty/Very Low
      case 1:
        return AppColors.cFFE8FDF2; // Low
      case 2:
        return AppColors.cFF8CE0B9; // Medium
      case 3:
        return AppColors.cFF00C46B; // High (1.2X)
      case 4:
        return AppColors.cFF00A86B; // Very High (1.8X)
      case 5:
        return AppColors.cFF00894B; // Peak (2.0X)
      default:
        return AppColors.cFFF4F6F9;
    }
  }

  Widget _buildLegendScaleDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildMultiplierLegend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.base.copyWith(
            // fontSize: 10,
            // fontWeight: FontWeight.w600,
            color: AppColors.cFF6F767E,
          ),
        ),
      ],
    );
  }

  // Generate randomized but realistic looking mock data for 24 hours (0-5 scale)
  List<int> _mockDataRow1() => [
    3,
    4,
    2,
    0,
    5,
    0,
    0,
    3,
    1,
    1,
    4,
    3,
    4,
    0,
    2,
    2,
    3,
    4,
    2,
    2,
    2,
    0,
    5,
    1,
  ];
  List<int> _mockDataRow2() => [
    3,
    3,
    2,
    0,
    1,
    4,
    3,
    1,
    1,
    4,
    4,
    2,
    1,
    0,
    1,
    5,
    4,
    2,
    2,
    2,
    3,
    3,
    4,
    3,
  ];
  List<int> _mockDataRow3() => [
    2,
    4,
    4,
    0,
    2,
    4,
    2,
    2,
    2,
    4,
    3,
    3,
    5,
    3,
    2,
    1,
    3,
    3,
    1,
    0,
    0,
    2,
    5,
    4,
  ];
  List<int> _mockDataRow4() => [
    2,
    1,
    2,
    3,
    2,
    3,
    2,
    2,
    1,
    3,
    2,
    2,
    1,
    0,
    1,
    1,
    1,
    1,
    3,
    4,
    4,
    4,
    2,
    1,
  ];
  List<int> _mockDataRow5() => [
    1,
    4,
    4,
    4,
    4,
    3,
    3,
    3,
    4,
    2,
    4,
    0,
    3,
    3,
    1,
    4,
    4,
    3,
    1,
    3,
    3,
    4,
    1,
    1,
  ];
  List<int> _mockDataRow6() => [
    1,
    1,
    1,
    4,
    4,
    4,
    2,
    1,
    2,
    4,
    3,
    4,
    3,
    4,
    2,
    5,
    1,
    4,
    1,
    1,
    2,
    3,
    2,
    3,
  ];
  List<int> _mockDataRow7() => [
    4,
    2,
    1,
    3,
    4,
    3,
    2,
    3,
    4,
    2,
    2,
    2,
    4,
    0,
    2,
    2,
    2,
    1,
    4,
    3,
    4,
    3,
    2,
    3,
  ];
}




