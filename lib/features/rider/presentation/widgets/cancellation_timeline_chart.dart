import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CancellationTimelineChart extends StatefulWidget {
  const CancellationTimelineChart({super.key});

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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cancellation by Customer vs Driver Timeline',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Correlation of failed bookings against daily ride density (Last 6 Months)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEFEFEF)),
                  ),
                  child: PopupMenuButton<String>(
                    offset: const Offset(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFEFEFEF)),
                    ),
                    color: Colors.white,
                    elevation: 6,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedFilter,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1D1F),
                          ),
                        ),
                        const SizedBox(width: 32),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: Color(0xFF6F767E),
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
            const SizedBox(height: 48),
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
                          const style = TextStyle(
                            color: Color(0xFF6B7280),
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
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? const Color(0xFFF4Fdf8) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF00A86B),
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
