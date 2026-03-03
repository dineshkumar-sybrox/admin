import 'package:flutter/material.dart';

class RevenueTrendChart extends StatefulWidget {
  const RevenueTrendChart({super.key});

  @override
  State<RevenueTrendChart> createState() => _RevenueTrendChartState();
}

class _RevenueTrendChartState extends State<RevenueTrendChart> {
  static const List<double> _todayPoints = [
    0.1,
    0.15,
    0.25,
    0.4,
    0.6,
    0.5,
    0.4,
    0.35,
    0.4,
    0.7,
    1.0,
  ];
  static const List<double> _yesterdayPoints = [
    0.3,
    0.32,
    0.28,
    0.2,
    0.15,
    0.08,
    0.1,
    0.25,
    0.5,
    0.35,
    0.15,
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
    '23:59',
  ];

  int? _hoverIndex;
  Offset? _hoverPos;
  Size _chartSize = Size.zero;
  String _selectedFilter = 'Hourly';

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
      height: 320,
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
                    'Revenue Trend',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Comparing Today vs Yesterday performance',
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
          const SizedBox(height: 40),
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['00:00', '06:00', '12:00', '18:00', '23:59']
                .map(
                  (t) => Text(
                    t,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F767E),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1D1F),
              ),
            ),
            const SizedBox(width: 32),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
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
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF00A86B),
                size: 20,
              ),
          ],
        ),
      ),
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
      const Color(0xFFB5C1C8),
      2.0,
      dashed: true,
    );
    _drawLine(canvas, size, todayPoints, const Color(0xFF00A86B), 3.0);

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

    if (dashed) {
      final dashPath = Path();
      const dashLength = 6.0;
      const dashSpace = 4.0;
      double distance = 0.0;
      for (final metric in path.computeMetrics()) {
        while (distance < metric.length) {
          dashPath.addPath(
            metric.extractPath(distance, distance + dashLength),
            Offset.zero,
          );
          distance += dashLength + dashSpace;
        }
        distance = 0.0;
      }
      canvas.drawPath(dashPath, paint);
    } else {
      canvas.drawPath(path, paint);
    }
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

  int _revFromValue(double v) => (v * 150000).round();

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
                color: Color(0xFF1A1D1F),
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
                  'Today: ₹${_revFromValue(todayValue)}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1A1D1F),
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
                    color: Color(0xFFB5C1C8),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Yesterday: ₹${_revFromValue(yesterdayValue)}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6F767E),
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
