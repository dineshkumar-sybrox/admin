import 'package:flutter/material.dart';

class ZoneMapWidget extends StatefulWidget {
  const ZoneMapWidget({super.key});

  @override
  State<ZoneMapWidget> createState() => _ZoneMapWidgetState();
}

class _ZoneMapWidgetState extends State<ZoneMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Base Map Layer
            Positioned.fill(child: CustomPaint(painter: _MapPainter())),

            // Green Gradient Overlay (The "mist" look)
            Positioned(
              left: -100,
              bottom: -50,
              child: Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.7,
                    colors: [
                      const Color(0xFF00A86B).withValues(alpha: 0.2),
                      const Color(0xFF00A86B).withValues(alpha: 0.1),
                      const Color(0xFF00A86B).withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            // City Labels
            const Positioned(
              left: 40,
              bottom: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chennai',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'சென்னை',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final majorRoadPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final secondaryRoadPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final roadLabelStyle = TextStyle(
      color: const Color(0xFF64748B).withValues(alpha: 0.8),
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );

    // Drawing road network
    // Secondary thick roads (white-ish)
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.2)
        ..lineTo(size.width, size.height * 0.5),
      secondaryRoadPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.4, 0)
        ..lineTo(0, size.height * 0.6),
      secondaryRoadPaint,
    );

    // Major gray roads
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.1, 0)
        ..lineTo(size.width * 0.3, size.height * 0.3)
        ..quadraticBezierTo(
          size.width * 0.5,
          size.height * 0.6,
          size.width * 0.8,
          size.height * 0.8,
        )
        ..lineTo(size.width, size.height * 0.95),
      majorRoadPaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.6, 0)
        ..lineTo(size.width * 0.95, size.height * 0.4)
        ..lineTo(size.width * 0.8, size.height),
      majorRoadPaint,
    );

    // Thin connector roads
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.5)
        ..lineTo(size.width, size.height * 0.7),
      roadPaint,
    );

    // Labels with rotation to match road angles
    _drawLabel(
      canvas,
      size,
      'Kam Rd',
      size.width * 0.58,
      size.height * 0.08,
      -0.65,
      roadLabelStyle,
    );
    _drawLabel(
      canvas,
      size,
      'Vada Agaram Rd',
      size.width * 0.56,
      size.height * 0.38,
      -0.68,
      roadLabelStyle,
    );
    _drawLabel(
      canvas,
      size,
      'Nelson Manickam Rd',
      size.width * 0.85,
      size.height * 0.65,
      -0.72,
      roadLabelStyle,
    );
    _drawLabel(
      canvas,
      size,
      'Railway Colony 1st St.',
      size.width * 0.38,
      size.height * 0.12,
      -0.65,
      roadLabelStyle,
    );
    _drawLabel(
      canvas,
      size,
      'ruvalluvarpuram 2nd St',
      size.width * 0.12,
      size.height * 0.8,
      0.22,
      roadLabelStyle,
    );
    _drawLabel(
      canvas,
      size,
      'Sadasiva',
      size.width * 0.92,
      size.height * 0.3,
      0.8,
      roadLabelStyle,
    );
  }

  void _drawLabel(
    Canvas canvas,
    Size size,
    String text,
    double x,
    double y,
    double rotation,
    TextStyle style,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation);
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
