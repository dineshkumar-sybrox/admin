import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class PaymentAnalyticsChart extends StatefulWidget {
  PaymentAnalyticsChart({super.key});

  @override
  State<PaymentAnalyticsChart> createState() => _PaymentAnalyticsChartState();
}

class _PaymentAnalyticsChartState extends State<PaymentAnalyticsChart> {
  static List<double> _cabPoints = [0.45, 0.5, 0.6, 0.55, 0.85, 0.75, 0.9];
  static List<double> _autoPoints = [0.35, 0.4, 0.55, 0.5, 0.75, 0.65, 0.8];
  static List<double> _bikePoints = [0.2, 0.25, 0.35, 0.3, 0.5, 0.45, 0.6];

  static List<String> _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  int? _hoverIndex;
  Offset? _hoverPos;
  Size _chartSize = Size.zero;
  String _selectedFilter = 'Today';

  void _updateHover(Offset localPos) {
    if (_chartSize.width <= 0 || _chartSize.height <= 0) return;
    final x = localPos.dx.clamp(0.0, _chartSize.width);
    final idx = (x / _chartSize.width * (_days.length - 1)).round();
    setState(() {
      _hoverIndex = idx.clamp(0, _days.length - 1);
      _hoverPos = Offset(x, localPos.dy.clamp(0.0, _chartSize.height));
    });
  }

  void _clearHover() {
    setState(() {
      _hoverIndex = null;
      _hoverPos = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      padding: EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment Analytics', style: AppTypography.h3),
                  SizedBox(height: 4),
                  Text(
                    'Comparison of Net Volume and Platform Fees',
                    style: AppTypography.base.copyWith(),
                  ),
                ],
              ),
              _buildDropdown(),
            ],
          ),
          SizedBox(height: 48),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                _chartSize = Size(constraints.maxWidth, constraints.maxHeight);
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(painter: _GridPainter(), size: Size.infinite),
                    MouseRegion(
                      onHover: (e) => _updateHover(e.localPosition),
                      onExit: (_) => _clearHover(),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (d) => _updateHover(d.localPosition),
                        onPanUpdate: (d) => _updateHover(d.localPosition),
                        onPanEnd: (_) => _clearHover(),
                        onTapDown: (d) => _updateHover(d.localPosition),
                        onTapCancel: _clearHover,
                        child: CustomPaint(
                          painter: _AreaChartPainter(
                            cabPoints: _cabPoints,
                            autoPoints: _autoPoints,
                            bikePoints: _bikePoints,
                            hoverIndex: _hoverIndex,
                          ),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    if (_hoverIndex != null && _hoverPos != null)
                      _HoverTooltip(
                        index: _hoverIndex!,
                        pos: _hoverPos!,
                        size: _chartSize,
                        day: _days[_hoverIndex!],
                        cabVal: _cabPoints[_hoverIndex!],
                        autoVal: _autoPoints[_hoverIndex!],
                        bikeVal: _bikePoints[_hoverIndex!],
                      ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _days
                .map(
                  (d) => Text(
                    d,
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF6F767E,
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildLegend(AppColors.cFF00A86B, 'BIKE/SCOOTER'),
              SizedBox(width: 16),
              _buildLegend(AppColors.cFFE8E500, 'AUTO'),
              SizedBox(width: 16),
              _buildLegend(AppColors.cFFD97A21, 'Cab'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.base.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.cFF1A1D1F,
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
          _buildPopupItem('Last Week', _selectedFilter == 'Last Week'),
          _buildPopupItem(
            'Last 30 Months',
            _selectedFilter == 'Last 30 Months',
          ),
          _buildPopupItem('Last 6 Months', _selectedFilter == 'Last 6 Months'),
          _buildPopupItem('Last 1 Year', _selectedFilter == 'Last 1 Year'),
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

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cFFF0F1F3
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = size.height * (i / 3);
      _drawDashedLine(canvas, Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const int dashWidth = 5;
    const int dashSpace = 5;
    double startX = p1.dx;
    while (startX < p2.dx) {
      canvas.drawLine(
        Offset(startX, p1.dy),
        Offset(startX + dashWidth, p1.dy),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AreaChartPainter extends CustomPainter {
  final List<double> cabPoints;
  final List<double> autoPoints;
  final List<double> bikePoints;
  final int? hoverIndex;

  _AreaChartPainter({
    required this.cabPoints,
    required this.autoPoints,
    required this.bikePoints,
    required this.hoverIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawLayer(canvas, size, cabPoints, AppColors.cFFD97A21);
    _drawLayer(canvas, size, autoPoints, AppColors.cFF1B2C4E); // Blue line
    _drawLayer(canvas, size, bikePoints, AppColors.cFF00A86B);

    if (hoverIndex != null) {
      final i = hoverIndex!;
      final x = i / (cabPoints.length - 1) * size.width;

      final linePaint = Paint()
        ..color = AppColors.cFF1A1D1F.withValues(alpha: 0.1)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);

      _drawHoverPoint(canvas, size, x, cabPoints[i], AppColors.cFFD97A21);
      _drawHoverPoint(canvas, size, x, autoPoints[i], AppColors.cFF1B2C4E);
      _drawHoverPoint(canvas, size, x, bikePoints[i], AppColors.cFF00A86B);
    }
  }

  void _drawHoverPoint(
    Canvas canvas,
    Size size,
    double x,
    double pointVal,
    Color color,
  ) {
    final y = (1 - pointVal) * size.height;
    canvas.drawCircle(Offset(x, y), 4, Paint()..color = color);
    canvas.drawCircle(
      Offset(x, y),
      7,
      Paint()..color = color.withValues(alpha: 0.3),
    );
  }

  void _drawLayer(Canvas canvas, Size size, List<double> points, Color color) {
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = i / (points.length - 1) * size.width;
      final y = (1 - points[i]) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = (i - 1) / (points.length - 1) * size.width;
        final prevY = (1 - points[i - 1]) * size.height;
        final cpX = (prevX + x) / 2;
        path.cubicTo(cpX, prevY, cpX, y, x, y);
      }
    }

    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) {
    return oldDelegate.hoverIndex != hoverIndex;
  }
}

class _HoverTooltip extends StatelessWidget {
  final int index;
  final Offset pos;
  final Size size;
  final String day;
  final double cabVal;
  final double autoVal;
  final double bikeVal;

  const _HoverTooltip({
    required this.index,
    required this.pos,
    required this.size,
    required this.day,
    required this.cabVal,
    required this.autoVal,
    required this.bikeVal,
  });

  int _vFromVal(double v) => (v * 1000).round();

  @override
  Widget build(BuildContext context) {
    final tooltipWidth = 140.0;
    final tooltipHeight = 100.0;
    final left = (pos.dx - tooltipWidth / 2).clamp(
      8.0,
      size.width - tooltipWidth - 8.0,
    );
    final top = (pos.dy - tooltipHeight - 20).clamp(
      8.0,
      size.height - tooltipHeight - 8.0,
    );

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: tooltipWidth,
        height: tooltipHeight,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: AppColors.cFFE8ECF0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: AppTypography.base.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(height: 6),
            _buildTooltipRow(AppColors.cFFD97A21, 'CAB', cabVal),
            SizedBox(height: 2),
            _buildTooltipRow(
              AppColors.cFFE8E500,
              'AUTO',
              autoVal,
            ), // Yellow dot in tooltip
            SizedBox(height: 2),
            _buildTooltipRow(AppColors.cFF00A86B, 'BIKE/SCOOTER', bikeVal),
          ],
        ),
      ),
    );
  }

  Widget _buildTooltipRow(Color color, String label, double val) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: AppTypography.base.copyWith(
              fontSize: 10,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        Text(
          '₹${_vFromVal(val)}k',
          style: AppTypography.base.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.cFF1A1D1F,
          ),
        ),
      ],
    );
  }
}
