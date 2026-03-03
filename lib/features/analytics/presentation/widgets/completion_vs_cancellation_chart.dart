import 'package:flutter/material.dart';

class CompletionVsCancellationChart extends StatefulWidget {
  const CompletionVsCancellationChart({super.key});

  @override
  State<CompletionVsCancellationChart> createState() =>
      _CompletionVsCancellationChartState();
}

class _CompletionVsCancellationChartState
    extends State<CompletionVsCancellationChart> {
  static const List<double> _completedPoints = [
    0.1,
    0.3,
    0.45,
    0.7,
    0.5,
    0.4,
    0.2,
  ];
  static const List<double> _cancelledPoints = [
    0.05,
    0.15,
    0.1,
    0.25,
    0.35,
    0.2,
    0.1,
  ];

  static const List<String> _times = [
    '00:00',
    '06:00',
    '12:00',
    '18:00',
    '23:59',
  ];

  int? _hoverIndex;
  Offset? _hoverPos;
  Size _chartSize = Size.zero;
  String _selectedFilter = 'Hourly';

  void _updateHover(Offset localPos) {
    if (_chartSize.width <= 0 || _chartSize.height <= 0) return;
    int dataLength = _completedPoints.length;
    final x = localPos.dx.clamp(0.0, _chartSize.width);
    final idx = (x / _chartSize.width * (dataLength - 1)).round();
    setState(() {
      _hoverIndex = idx.clamp(0, dataLength - 1);
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
                    'Ride Completion vs Cancellation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Trends over the last Hour',
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
                          painter: _TrendChartPainter(
                            completedPoints: _completedPoints,
                            cancelledPoints: _cancelledPoints,
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
                        completedVal: _completedPoints[_hoverIndex!],
                        cancelledVal: _cancelledPoints[_hoverIndex!],
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _times
                .map(
                  (t) => Text(
                    t,
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
              _buildLegend(const Color(0xFF00A86B), 'Completed'),
              const SizedBox(width: 24),
              _buildLegend(
                const Color(0xFFD6DBE1),
                'Cancelled',
                isDashed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label, {bool isDashed = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isDashed)
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
          )
        else
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F767E),
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

class _TrendChartPainter extends CustomPainter {
  final List<double> completedPoints;
  final List<double> cancelledPoints;
  final int? hoverIndex;

  _TrendChartPainter({
    required this.completedPoints,
    required this.cancelledPoints,
    required this.hoverIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawCancelledLine(canvas, size, cancelledPoints, const Color(0xFFD6DBE1));
    _drawCompletedLayer(canvas, size, completedPoints, const Color(0xFF00A86B));

    if (hoverIndex != null) {
      final i = hoverIndex!;
      final x = i / (completedPoints.length - 1) * size.width;

      final linePaint = Paint()
        ..color = const Color(0xFF1A1D1F).withValues(alpha: 0.1)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);

      _drawHoverPoint(
        canvas,
        size,
        x,
        cancelledPoints[i],
        const Color(0xFFD6DBE1),
      );
      _drawHoverPoint(
        canvas,
        size,
        x,
        completedPoints[i],
        const Color(0xFF00A86B),
      );
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
    canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(x, y),
      4,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()..color = color.withValues(alpha: 0.3),
    );
  }

  void _drawCompletedLayer(
    Canvas canvas,
    Size size,
    List<double> points,
    Color color,
  ) {
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
        colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawCancelledLine(
    Canvas canvas,
    Size size,
    List<double> points,
    Color color,
  ) {
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
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + 8);
        canvas.drawPath(extractPath, strokePaint);
        distance += 8 + 6; // dash + gap
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.hoverIndex != hoverIndex;
  }
}

class _HoverTooltip extends StatelessWidget {
  final int index;
  final Offset pos;
  final Size size;
  final double completedVal;
  final double cancelledVal;

  const _HoverTooltip({
    required this.index,
    required this.pos,
    required this.size,
    required this.completedVal,
    required this.cancelledVal,
  });

  int _vFromVal(double v) => (v * 100).round();

  @override
  Widget build(BuildContext context) {
    final tooltipWidth = 120.0;
    final tooltipHeight = 70.0;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTooltipRow(
              const Color(0xFF00A86B),
              'Completed',
              completedVal,
            ),
            const SizedBox(height: 6),
            _buildTooltipRow(
              const Color(0xFFD6DBE1),
              'Cancelled',
              cancelledVal,
            ),
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
          '${_vFromVal(val)}k',
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
