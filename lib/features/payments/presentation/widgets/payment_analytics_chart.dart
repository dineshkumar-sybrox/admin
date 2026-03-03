import 'package:flutter/material.dart';

class PaymentAnalyticsChart extends StatefulWidget {
  const PaymentAnalyticsChart({super.key});

  @override
  State<PaymentAnalyticsChart> createState() => _PaymentAnalyticsChartState();
}

class _PaymentAnalyticsChartState extends State<PaymentAnalyticsChart> {
  static const List<double> _cabPoints = [
    0.45,
    0.5,
    0.6,
    0.55,
    0.85,
    0.75,
    0.9,
  ];
  static const List<double> _autoPoints = [
    0.35,
    0.4,
    0.55,
    0.5,
    0.75,
    0.65,
    0.8,
  ];
  static const List<double> _bikePoints = [
    0.2,
    0.25,
    0.35,
    0.3,
    0.5,
    0.45,
    0.6,
  ];

  static const List<String> _days = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

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
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Analytics',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Comparison of Net Volume and Platform Fees',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9EA5AD),
                    ),
                  ),
                ],
              ),
              _buildDropdown(),
            ],
          ),
          const SizedBox(height: 48),
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _days
                .map(
                  (d) => Text(
                    d,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F767E),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLegend(const Color(0xFF00A86B), 'BIKE/SCOOTER'),
              const SizedBox(width: 16),
              _buildLegend(const Color(0xFFE8E500), 'AUTO'),
              const SizedBox(width: 16),
              _buildLegend(const Color(0xFFD97A21), 'Cab'),
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
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1D1F),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0F1F3)
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
    _drawLayer(canvas, size, cabPoints, const Color(0xFFD97A21));
    _drawLayer(canvas, size, autoPoints, const Color(0xFF1B2C4E)); // Blue line
    _drawLayer(canvas, size, bikePoints, const Color(0xFF00A86B));

    if (hoverIndex != null) {
      final i = hoverIndex!;
      final x = i / (cabPoints.length - 1) * size.width;

      final linePaint = Paint()
        ..color = const Color(0xFF1A1D1F).withValues(alpha: 0.1)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);

      _drawHoverPoint(canvas, size, x, cabPoints[i], const Color(0xFFD97A21));
      _drawHoverPoint(canvas, size, x, autoPoints[i], const Color(0xFF1B2C4E));
      _drawHoverPoint(canvas, size, x, bikePoints[i], const Color(0xFF00A86B));
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0xFFE8ECF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D1F),
              ),
            ),
            const SizedBox(height: 6),
            _buildTooltipRow(const Color(0xFFD97A21), 'CAB', cabVal),
            const SizedBox(height: 2),
            _buildTooltipRow(
              const Color(0xFFE8E500),
              'AUTO',
              autoVal,
            ), // Yellow dot in tooltip
            const SizedBox(height: 2),
            _buildTooltipRow(const Color(0xFF00A86B), 'BIKE/SCOOTER', bikeVal),
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
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF6F767E)),
          ),
        ),
        Text(
          '₹${_vFromVal(val)}k',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1D1F),
          ),
        ),
      ],
    );
  }
}
