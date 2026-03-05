import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActivityTrendChart extends StatefulWidget {
  const ActivityTrendChart({super.key});

  @override
  State<ActivityTrendChart> createState() => _ActivityTrendChartState();
}

class _ActivityTrendChartState extends State<ActivityTrendChart> {
  String _selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      '30-Day Activity Trend',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Daily ride frequency analysis',
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
            const SizedBox(height: 32),
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
                          const style = TextStyle(
                            color: Color(0xFFBDBDBD),
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
                  gridData: const FlGridData(show: false),
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
              : const Color(0xFFF5F7FA), // Fixed deprecated withOpacity
          // The image shows some bars are green, some light grey. Let's hardcode a few for visual match.
          // Applying a visual pattern:
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.transparent, // Or very light grey if needed
          ),
        ),
      ],
    );
  }
}
