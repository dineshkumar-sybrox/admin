import 'package:flutter/material.dart';

class PeakHourHeatmap extends StatelessWidget {
  const PeakHourHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF0F1F3)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peak Hour Demand Heatmap',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Hourly ride requests distribution',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9EA5AD),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Low',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F767E),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildLegendScaleDot(const Color(0xFFE8FDF2)),
                  const SizedBox(width: 4),
                  _buildLegendScaleDot(const Color(0xFF8CE0B9)),
                  const SizedBox(width: 4),
                  _buildLegendScaleDot(const Color(0xFF00C46B)),
                  const SizedBox(width: 4),
                  _buildLegendScaleDot(const Color(0xFF00894B)),
                  const SizedBox(width: 8),
                  const Text(
                    'High',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F767E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              // X-Axis (Hours)
              Row(
                children: [
                  const SizedBox(width: 40), // Left margin for Y-Axis labels
                  ...List.generate(24, (i) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          '${i}h',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6F767E),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 8),
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
          const SizedBox(height: 24),
          Row(
            children: [
              _buildMultiplierLegend(const Color(0xFFE8FDF2), 'Normal'),
              const SizedBox(width: 16),
              _buildMultiplierLegend(const Color(0xFF8CE0B9), 'Normal'),
              const SizedBox(width: 16),
              _buildMultiplierLegend(const Color(0xFF00C46B), '1.2X'),
              const SizedBox(width: 16),
              _buildMultiplierLegend(const Color(0xFF00A86B), '1.8X'),
              const SizedBox(width: 16),
              _buildMultiplierLegend(const Color(0xFF00894B), '2.0X'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapRow(String day, List<int> intensities) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D1F),
              ),
            ),
          ),
          ...intensities.map((intensity) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
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
        return const Color(0xFFF4F6F9); // Empty/Very Low
      case 1:
        return const Color(0xFFE8FDF2); // Low
      case 2:
        return const Color(0xFF8CE0B9); // Medium
      case 3:
        return const Color(0xFF00C46B); // High (1.2X)
      case 4:
        return const Color(0xFF00A86B); // Very High (1.8X)
      case 5:
        return const Color(0xFF00894B); // Peak (2.0X)
      default:
        return const Color(0xFFF4F6F9);
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
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F767E),
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
