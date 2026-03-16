import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'dart:math' as math;

class SupplyVsDemandIndicator extends StatelessWidget {
  SupplyVsDemandIndicator({super.key});

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
          Text('Supply vs Demand', style: AppTypography.h3),
          SizedBox(height: 4),
          Text('Correlation index', style: AppTypography.base.copyWith()),
          SizedBox(height: 48),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: _CircularProgressPainter(
                      progress: 0.88,
                      activeColor: AppColors.cFF00C46B,
                      backgroundColor: AppColors.cFFF4F6F9,
                      strokeWidth: 16,
                    ),
                    size: Size(160, 160),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '88%',
                        style: AppTypography.base.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.cFF1A1D1F,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'EFFICIENCY',
                        style: AppTypography.base.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cFF6F767E,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 48),
          _buildStatBar('Active Drivers', '1,240', 0.88, AppColors.cFF00C46B),
          SizedBox(height: 24),
          _buildStatBar('Active Riders', '14,800', 0.70, AppColors.cFF6764FF),
        ],
      ),
    );
  }

  Widget _buildStatBar(
    String title,
    String value,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF6F767E,
              ),
            ),
            Text(
              value,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.cFFF4F6F9,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color backgroundColor;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw progress arc
    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start at top
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
