import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'dart:math' as math;

class CancellationZonesChart extends StatelessWidget {
  CancellationZonesChart({super.key});

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
          Text(
            'Cancellation Zones',
            style: AppTypography.base.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF1A1D1F,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
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
                      segments: [
                        ChartSegment(
                          value: 45,
                          color: AppColors.cFF1B2C4E,
                        ), // Anna Nagar (Dark Blue)
                        ChartSegment(
                          value: 25,
                          color: AppColors.cFF00A86B,
                        ), // Adyar (Green)
                        ChartSegment(
                          value: 20,
                          color: AppColors.cFFFFA629,
                        ), // Velachery (Orange)
                        ChartSegment(
                          value: 10,
                          color: AppColors.cFFEA3546,
                        ), // Others (Red)
                      ],
                      strokeWidth: 20,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Chennai',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF9EA5AD,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cancellation Zones',
                      style: AppTypography.base.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF1A1D1F,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          _buildLegendRow(AppColors.cFF1B2C4E, 'Anna Nagar', '1,116 (45%)'),
          SizedBox(height: 16),
          _buildLegendRow(AppColors.cFF00A86B, 'Adyar', '508 (25%)'),
          SizedBox(height: 16),
          _buildLegendRow(AppColors.cFFFFA629, 'Velachery', '702 (20%)'),
          SizedBox(height: 16),
          _buildLegendRow(AppColors.cFFEA3546, 'Others', '602 (10%)'),
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
            SizedBox(width: 8),
            Text(
              title,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: AppTypography.base.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.cFF1A1D1F,
          ),
        ),
      ],
    );
  }
}

class ChartSegment {
  final double value;
  final Color color;

  ChartSegment({required this.value, required this.color});
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




