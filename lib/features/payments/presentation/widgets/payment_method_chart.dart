import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'dart:math' as math;

class PaymentMethodChart extends StatefulWidget {
  PaymentMethodChart({super.key});

  @override
  State<PaymentMethodChart> createState() => _PaymentMethodChartState();
}

class _PaymentMethodChartState extends State<PaymentMethodChart> {
  String _selectedVehicle = 'Choose Vehicle';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment Method', style: AppTypography.h3),
                  SizedBox(height: 4),
                  Text(
                    'Transaction volume distribution',
                    style: AppTypography.base.copyWith(),
                  ),
                ],
              ),
              _buildDropdown(),
            ],
          ),
          SizedBox(height: 48),
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: _PaymentPiePainter(
                      segments: [
                        ChartSegment(
                          value: 55,
                          color: AppColors.cFF00C46B,
                        ), // UPI (Green)
                        ChartSegment(
                          value: 30,
                          color: AppColors.cFF6764FF,
                        ), // CARD (Purple)
                        ChartSegment(
                          value: 15,
                          color: AppColors.cFFFFD12E,
                        ), // CASH (Yellow)
                      ],
                      strokeWidth: 20,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '14.2k',
                      style: AppTypography.base.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF1A1D1F,
                      ),
                    ),
                    Text(
                      'TOTAL TXNS',
                      style: AppTypography.base.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF6F767E,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegend(AppColors.cFF00C46B, '55%', 'UPI'),
              _buildLegend(AppColors.cFF6764FF, '30%', 'CARD'),
              _buildLegend(AppColors.cFFFFD12E, '15%', 'CASH'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String percentage, String label) {
    return Column(
      children: [
        Text(
          percentage,
          style: AppTypography.base.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.base.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.cFF6F767E,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
              _selectedVehicle,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.cFF6F767E,
            ),
          ],
        ),
        onSelected: (val) {
          setState(() {
            _selectedVehicle = val;
          });
        },
        itemBuilder: (context) => [
          _buildPopupItem('Bike/Scooter', _selectedVehicle == 'Bike/Scooter'),
          _buildPopupItem('Cab', _selectedVehicle == 'Cab'),
          _buildPopupItem('Auto', _selectedVehicle == 'Auto'),
        ],
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
}

class ChartSegment {
  final double value;
  final Color color;

  ChartSegment({required this.value, required this.color});
}

class _PaymentPiePainter extends CustomPainter {
  final List<ChartSegment> segments;
  final double strokeWidth;

  _PaymentPiePainter({required this.segments, required this.strokeWidth});

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
  bool shouldRepaint(covariant _PaymentPiePainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
