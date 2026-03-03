import 'package:flutter/material.dart';

class RideTrendChart extends StatefulWidget {
  const RideTrendChart({super.key});

  @override
  State<RideTrendChart> createState() => _RideTrendChartState();
}

class _RideTrendChartState extends State<RideTrendChart> {
  static const List<double> _todayPoints = [
    0.5,
    0.4,
    0.35,
    0.3,
    0.45,
    0.6,
    0.7,
    0.65,
    0.75,
    0.85,
    0.9,
  ];
  static const List<double> _yesterdayPoints = [
    0.45,
    0.4,
    0.3,
    0.28,
    0.35,
    0.5,
    0.55,
    0.6,
    0.65,
    0.7,
    0.75,
  ];
  static const List<String> _timeLabels = [
    '00:00',
    '02:00',
    '04:00',
    '06:00',
    '08:00',
    '10:00',
    '12:00',
    '14:00',
    '16:00',
    '18:00',
    '20:00',
  ];

  int? _hoverIndex;
  Offset? _hoverPos;
  Size _chartSize = Size.zero;

  void _updateHover(Offset localPos) {
    if (_chartSize.width <= 0 || _chartSize.height <= 0) return;
    final x = localPos.dx.clamp(0.0, _chartSize.width);
    final idx = (x / _chartSize.width * (_todayPoints.length - 1)).round();
    setState(() {
      _hoverIndex = idx.clamp(0, _todayPoints.length - 1);
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
      height: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ride Trend Analytics',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Comparing Today vs Yesterday performance',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8E9BAB),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _Legend(color: const Color(0xFF00A86B), label: 'Today'),
                  const SizedBox(width: 14),
                  _Legend(color: const Color(0xFFCDD3DA), label: 'Yesterday'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                _chartSize = Size(constraints.maxWidth, constraints.maxHeight);
                return Stack(
                  children: [
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
                            todayPoints: _todayPoints,
                            yesterdayPoints: _yesterdayPoints,
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
                        time: _timeLabels[_hoverIndex!],
                        todayValue: _todayPoints[_hoverIndex!],
                        yesterdayValue: _yesterdayPoints[_hoverIndex!],
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['00:00', '06:00', '12:00', '18:00', '23:59']
                .map(
                  (t) => Text(
                    t,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8E9BAB),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF6B7A8D)),
        ),
      ],
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final List<double> todayPoints;
  final List<double> yesterdayPoints;
  final int? hoverIndex;

  _TrendChartPainter({
    required this.todayPoints,
    required this.yesterdayPoints,
    required this.hoverIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawLine(
      canvas,
      size,
      yesterdayPoints,
      const Color(0xFFCDD3DA),
      1.5,
      dashed: true,
    );
    _drawAreaFill(canvas, size, todayPoints, const Color(0xFF00A86B));
    _drawLine(canvas, size, todayPoints, const Color(0xFF00A86B), 2.5);

    if (hoverIndex != null) {
      final i = hoverIndex!;
      final x = i / (todayPoints.length - 1) * size.width;
      final y = (1 - todayPoints[i]) * size.height;
      final linePaint = Paint()
        ..color = const Color(0xFF00A86B).withValues(alpha: 0.25)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()..color = const Color(0xFF00A86B),
      );
      canvas.drawCircle(
        Offset(x, y),
        7,
        Paint()..color = const Color(0xFF00A86B).withValues(alpha: 0.15),
      );
    }
  }

  void _drawLine(
    Canvas canvas,
    Size size,
    List<double> points,
    Color color,
    double strokeWidth, {
    bool dashed = false,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

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
    canvas.drawPath(path, paint);
  }

  void _drawAreaFill(
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
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.01)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.hoverIndex != hoverIndex ||
        oldDelegate.todayPoints != todayPoints ||
        oldDelegate.yesterdayPoints != yesterdayPoints;
  }
}

class _HoverTooltip extends StatelessWidget {
  final int index;
  final Offset pos;
  final Size size;
  final String time;
  final double todayValue;
  final double yesterdayValue;

  const _HoverTooltip({
    required this.index,
    required this.pos,
    required this.size,
    required this.time,
    required this.todayValue,
    required this.yesterdayValue,
  });

  int _ridesFromValue(double v) => (v * 20000).round();

  @override
  Widget build(BuildContext context) {
    final tooltipWidth = 150.0;
    final tooltipHeight = 70.0;
    final left = (pos.dx - tooltipWidth / 2).clamp(
      8.0,
      size.width - tooltipWidth - 8.0,
    );
    final top = (pos.dy - tooltipHeight - 12).clamp(
      8.0,
      size.height - tooltipHeight - 8.0,
    );

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: tooltipWidth,
        height: tooltipHeight,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFE8ECF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A2332),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00A86B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Today: ${_ridesFromValue(todayValue)}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1A2332),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCDD3DA),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Yesterday: ${_ridesFromValue(yesterdayValue)}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7A8D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
