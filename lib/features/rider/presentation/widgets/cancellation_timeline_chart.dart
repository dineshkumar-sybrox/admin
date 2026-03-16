import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class CancellationTimelineChart extends StatefulWidget {
  CancellationTimelineChart({super.key});

  @override
  State<CancellationTimelineChart> createState() =>
      _CancellationTimelineChartState();
}

class _CancellationTimelineChartState extends State<CancellationTimelineChart> {
  String _selectedFilter = 'Last 6 Months';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cancellation by Customer vs Driver Timeline',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Correlation of failed bookings against daily ride density (Last 6 Months)',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.cFFEFEFEF),
                    ),
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
                        'Last 30 Months',
                        _selectedFilter == 'Last 30 Months',
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
            SizedBox(height: 48),
            SizedBox(
              height: 250,
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
                            color: AppColors.cFF6B7280,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'SEPTEMBER';
                              break;
                            case 1:
                              text = 'OCTOBER';
                              break;
                            case 2:
                              text = 'NOVEMBER';
                              break;
                            case 3:
                              text = 'DECEMBER';
                              break;
                            case 4:
                              text = 'JANUARY';
                              break;
                            case 5:
                              text = 'FEBRUARY';
                              break;
                            default:
                              return Container();
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 8.0),
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
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppColors.divider.withValues(alpha: 0.5),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    makeGroupData(0, 25, 20),
                    makeGroupData(1, 25, 40),
                    makeGroupData(2, 55, 45),
                    makeGroupData(3, 75, 45),
                    makeGroupData(4, 55, 30),
                    makeGroupData(5, 55, 35),
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

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: AppColors.primary,
          width: 24,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: y2,
          color: AppColors.error,
          width: 24,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}




