import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class MonthlySpendingTrendChart extends StatefulWidget {
  MonthlySpendingTrendChart({super.key});

  @override
  State<MonthlySpendingTrendChart> createState() =>
      _MonthlySpendingTrendChartState();
}

class _MonthlySpendingTrendChartState extends State<MonthlySpendingTrendChart> {
  String _selectedRange = '6 Months';

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
                      'Monthly Spending Trend',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Analysis of wallet deductions and card spends',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.divider.withValues(alpha: 0.5),
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRange = '6 Months';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedRange == '6 Months'
                                  ? AppColors.white
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              //border: Border.all(color: AppColors.divider),
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(8),
                              //   bottomLeft: Radius.circular(8),
                              // ),
                            ),
                            child: Text(
                              '6 Months',
                              style: AppTypography.base.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _selectedRange == '6 Months'
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRange = '1 Year';
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedRange == '1 Year'
                                  ? AppColors.white
                                  : AppColors.transparent,
                              // border: Border(
                              //   top: BorderSide(color: AppColors.divider),
                              //   bottom: BorderSide(color: AppColors.divider),
                              //   right: BorderSide(color: AppColors.divider),
                              // ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              '1 Year',
                              style: AppTypography.base.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _selectedRange == '1 Year'
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppColors.divider.withValues(alpha: 0.5),
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final style = AppTypography.base.copyWith(
                            color: AppColors.cFF6B7280,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'SEP';
                              break;
                            case 1:
                              text = 'OCT';
                              break;
                            case 2:
                              text = 'NOV';
                              break;
                            case 3:
                              text = 'DEC';
                              break;
                            case 4:
                              text = 'JAN';
                              break;
                            case 5:
                              text = 'FEB';
                              break;
                            default:
                              return Container();
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 20),
                        FlSpot(1, 40),
                        FlSpot(2, 25),
                        FlSpot(3, 75),
                        FlSpot(4, 30),
                        FlSpot(5, 90),
                      ],
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (index == 0 || index == 5) {
                            // First and last spots logic or others if needed
                            if (index == 5) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: AppColors.primary,
                                strokeWidth: 0,
                              );
                            }
                          }
                          return FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.white,
                            strokeWidth: 2,
                            strokeColor: AppColors.primary,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



