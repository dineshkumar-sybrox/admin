import 'package:flutter/material.dart';
import 'dart:math' as math;

class CancellationZonesChart extends StatelessWidget {
  const CancellationZonesChart({super.key});

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
          const Text(
            'Cancellation Zones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: _DoughnutChartPainter(
                      segments: const [
                        ChartSegment(
                          value: 45,
                          color: Color(0xFF1B2C4E),
                        ), // Anna Nagar (Dark Blue)
                        ChartSegment(
                          value: 25,
                          color: Color(0xFF00A86B),
                        ), // Adyar (Green)
                        ChartSegment(
                          value: 20,
                          color: Color(0xFFFFA629),
                        ), // Velachery (Orange)
                        ChartSegment(
                          value: 10,
                          color: Color(0xFFEA3546),
                        ), // Others (Red)
                      ],
                      strokeWidth: 20,
                    ),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Chennai',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF9EA5AD),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cancellation Zones',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1D1F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildLegendRow(const Color(0xFF1B2C4E), 'Anna Nagar', '1,116 (45%)'),
          const SizedBox(height: 16),
          _buildLegendRow(const Color(0xFF00A86B), 'Adyar', '508 (25%)'),
          const SizedBox(height: 16),
          _buildLegendRow(const Color(0xFFFFA629), 'Velachery', '702 (20%)'),
          const SizedBox(height: 16),
          _buildLegendRow(const Color(0xFFEA3546), 'Others', '602 (10%)'),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D1F),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1D1F),
          ),
        ),
      ],
    );
  }
}

class ChartSegment {
  final double value;
  final Color color;

  const ChartSegment({required this.value, required this.color});
}

class _DoughnutChartPainter extends CustomPainter {
  final List<ChartSegment> segments;
  final double strokeWidth;

  _DoughnutChartPainter({required this.segments, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - strokeWidth,
      height: size.height - strokeWidth,
    );

    double total = segments.fold(0, (sum, item) => sum + item.value);
    if (total == 0) total = 1;

    double startAngle = -math.pi / 2; // Start from top

    for (final segment in segments) {
      final sweepAngle = (segment.value / total) * 2 * math.pi;

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DoughnutChartPainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
