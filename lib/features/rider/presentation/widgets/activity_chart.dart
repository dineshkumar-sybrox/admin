import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class ActivityTrendChart extends StatefulWidget {
  ActivityTrendChart({super.key});

  @override
  State<ActivityTrendChart> createState() => _ActivityTrendChartState();
}

class _ActivityTrendChartState extends State<ActivityTrendChart> {
  String _selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(24.0),
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
                      '30-Day Activity Trend',
                      style: AppTypography.h3.copyWith(
                        //fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Daily ride frequency analysis',
                      style: AppTypography.base.copyWith(
                        // fontSize: 12,
                        // color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.cFFEFEFEF),
                  ),
                  child: PopupMenuButton<String>(
                    offset: Offset(0, 40),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   side: BorderSide(color: AppColors.cFFEFEFEF),
                    // ),
                    color: AppColors.white,
                    elevation: 6,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedFilter,
                          style: AppTypography.base.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cFF1A1D1F,
                          ),
                        ),
                        SizedBox(width: 32),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: AppColors.cFF6F767E,
                        ),
                      ],
                    ),
                    onSelected: (val) {
                      setState(() {
                        _selectedFilter = val;
                      });
                    },
                    itemBuilder: (context) => [
                      _buildPopupItem('Hourly', _selectedFilter == 'Hourly'),
                      _buildPopupItem('Today', _selectedFilter == 'Today'),
                      _buildPopupItem(
                        'Last Week',
                        _selectedFilter == 'Last Week',
                      ),
                      _buildPopupItem(
                        'Last 30 Days',
                        _selectedFilter == 'Last 30 Days',
                      ),
                      _buildPopupItem(
                        'Last 6 Months',
                        _selectedFilter == 'Last 6 Months',
                      ),
                      _buildPopupItem(
                        'Last 1 Year',
                        _selectedFilter == 'Last 1 Year',
                      ),
                    ],
                  ),
                ),

                
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final style = AppTypography.base.copyWith(
                            color: AppColors.cFFBDBDBD,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'OCT 01';
                              break;
                            case 3:
                              text = 'OCT 15';
                              break;
                            case 6:
                              text = 'OCT 30';
                              break;
                            default:
                              return Container();
                          }
                          return SideTitleWidget(
                            meta: meta,
                            space: 4,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    makeGroupData(0, 20),
                    makeGroupData(1, 40), // Highlighted
                    makeGroupData(2, 30),
                    makeGroupData(3, 80), // Highlighted
                    makeGroupData(4, 25),
                    makeGroupData(5, 50),
                    makeGroupData(6, 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? AppColors.cFFF4FDF8 : AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.cFF00A86B,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    // Logic to highlight specific bars like in the image (simple alternating for demo)
    // In real app, this would be based on data
    final isHighlighted = y > 30; // Arbitrary logic for visual match

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isHighlighted
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.cFFF5F7FA, // Fixed deprecated withOpacity
          // The image shows some bars are green, some light grey. Let's hardcode a few for visual match.
          // Applying a visual pattern:
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: AppColors.transparent, // Or very light grey if needed
          ),
        ),
      ],
    );
  }
}




