import 'dart:math' as math;
import 'package:flutter/material.dart';

class DemandMapWidget extends StatefulWidget {
  const DemandMapWidget({super.key});

  @override
  State<DemandMapWidget> createState() => _DemandMapWidgetState();
}

class _DemandMapWidgetState extends State<DemandMapWidget>
    with TickerProviderStateMixin {
  late AnimationController _heatController;
  late Animation<double> _heatAnim;
  late AnimationController _rippleController;
  late Animation<double> _rippleAnim;
  late AnimationController _carController;
  late Animation<double> _carAnim;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnim;
  late AnimationController _scanController;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();

    _heatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _heatAnim = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _heatController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _rippleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _carAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_carController);

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _blinkAnim = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );

    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _scanAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scanController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _heatController.dispose();
    _rippleController.dispose();
    _carController.dispose();
    _blinkController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  static const List<Offset> _pins = [
    Offset(80, 55),
    Offset(225, 78),
    Offset(140, 178),
    Offset(288, 148),
    Offset(62, 192),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 485,
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
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Row(
              children: [
                const Text(
                  'Real-time Demand Map - Chennai',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2332),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00A86B),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: AnimatedBuilder(
                    animation: _blinkAnim,
                    builder: (_, _) => Row(
                      children: [
                        Opacity(
                          opacity: _blinkAnim.value,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'LIVE HEATMAP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: Colors.white,
                    child: CustomPaint(
                      painter: _MapPainter(),
                      size: Size.infinite,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _scanAnim,
                    builder: (_, _) =>
                        CustomPaint(painter: _ScanPainter(_scanAnim.value)),
                  ),
                  AnimatedBuilder(
                    animation: _heatAnim,
                    builder: (_, _) => Center(
                      child: Transform.scale(
                        scale: _heatAnim.value,
                        child: Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFF00A86B).withValues(alpha: 0.42),
                                const Color(0xFF00A86B).withValues(alpha: 0.16),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF00A86B).withValues(alpha: 0.5),
                            const Color(0xFF00A86B).withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Chennai',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A2332),
                          ),
                        ),
                        Text(
                          'சென்னை',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1A2332),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ..._pins.map(
                    (pos) => AnimatedBuilder(
                      animation: _rippleAnim,
                      builder: (_, _) => Positioned(
                        left: pos.dx - 20,
                        top: pos.dy - 20,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CustomPaint(
                            painter: _RipplePainter(_rippleAnim.value),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ..._pins.map(
                    (pos) => Positioned(
                      left: pos.dx - 5,
                      top: pos.dy - 5,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A86B),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF00A86B,
                              ).withValues(alpha: 0.5),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _carAnim,
                    builder: (_, _) =>
                        CustomPaint(painter: _CarPainter(_carAnim.value)),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2332).withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: _blinkAnim,
                            builder: (_, _) => Opacity(
                              opacity: _blinkAnim.value,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00A86B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '8.2k active rides',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 1,
                            height: 10,
                            color: Colors.white24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '24k drivers online',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  final double progress;
  const _RipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < 3; i++) {
      final p = ((progress - i / 3.0) % 1.0 + 1.0) % 1.0;
      canvas.drawCircle(
        center,
        p * 18.0,
        Paint()
          ..color = const Color(0xFF00A86B).withValues(alpha: (1.0 - p) * 0.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_RipplePainter old) => old.progress != progress;
}

class _ScanPainter extends CustomPainter {
  final double progress;
  const _ScanPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.5;
    final radius = size.width * 0.36;
    final angle = progress * 2 * math.pi - math.pi / 2;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    canvas.drawArc(
      rect,
      angle - 1.0,
      1.0,
      true,
      Paint()
        ..shader = SweepGradient(
          startAngle: angle - 1.0,
          endAngle: angle,
          colors: [
            Colors.transparent,
            const Color(0xFF00A86B).withValues(alpha: 0.15),
          ],
        ).createShader(rect)
        ..style = PaintingStyle.fill,
    );

    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + radius * math.cos(angle), cy + radius * math.sin(angle)),
      Paint()
        ..color = const Color(0xFF00A86B).withValues(alpha: 0.45)
        ..strokeWidth = 1.0,
    );

    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..color = const Color(0xFF00A86B).withValues(alpha: 0.07)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(_ScanPainter old) => old.progress != progress;
}

class _CarPainter extends CustomPainter {
  final double t;
  const _CarPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    void car(Offset o) {
      canvas.drawCircle(
        o,
        3.5,
        Paint()
          ..color = const Color(0xFF00A86B)
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        o,
        3.5,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    }

    car(Offset(size.width * t, size.height * 0.27));
    car(Offset(size.width * (1.0 - (t + 0.4) % 1.0), size.height * 0.51));
    car(Offset(size.width * 0.32, size.height * ((t + 0.6) % 1.0)));
    car(Offset(size.width * 0.66, size.height * (1.0 - (t + 0.2) % 1.0)));
  }

  @override
  bool shouldRepaint(_CarPainter old) => old.t != t;
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final major = Paint()
      ..color = const Color(0xFFBFCDBE)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final minor = Paint()
      ..color = const Color(0xFFD0DACC)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    Path q(List<Offset> pts) {
      final p = Path()..moveTo(pts[0].dx, pts[0].dy);
      for (int i = 1; i < pts.length - 1; i++) {
        final mid = Offset(
          (pts[i].dx + pts[i + 1].dx) / 2,
          (pts[i].dy + pts[i + 1].dy) / 2,
        );
        p.quadraticBezierTo(pts[i].dx, pts[i].dy, mid.dx, mid.dy);
      }
      p.lineTo(pts.last.dx, pts.last.dy);
      return p;
    }

    for (final p in [
      q([
        Offset(0, size.height * 0.27),
        Offset(size.width * 0.35, size.height * 0.30),
        Offset(size.width * 0.65, size.height * 0.24),
        Offset(size.width, size.height * 0.27),
      ]),
      q([
        Offset(0, size.height * 0.51),
        Offset(size.width * 0.4, size.height * 0.47),
        Offset(size.width * 0.7, size.height * 0.54),
        Offset(size.width, size.height * 0.51),
      ]),
      q([
        Offset(size.width * 0.32, 0),
        Offset(size.width * 0.34, size.height * 0.45),
        Offset(size.width * 0.38, size.height),
      ]),
      q([
        Offset(size.width * 0.66, 0),
        Offset(size.width * 0.64, size.height * 0.42),
        Offset(size.width * 0.68, size.height),
      ]),
    ]) {
      canvas.drawPath(p, major);
    }

    for (final p in [
      q([
        Offset(0, size.height * 0.70),
        Offset(size.width * 0.5, size.height * 0.68),
        Offset(size.width, size.height * 0.72),
      ]),
      q([
        Offset(size.width * 0.55, 0),
        Offset(size.width * 0.53, size.height * 0.5),
        Offset(size.width * 0.57, size.height),
      ]),
      q([
        Offset(size.width * 0.32, size.height * 0.51),
        Offset(size.width * 0.49, size.height * 0.54),
        Offset(size.width * 0.66, size.height * 0.51),
      ]),
    ]) {
      canvas.drawPath(p, minor);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
