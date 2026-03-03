import 'package:flutter/material.dart';

class HighRiskClustersMap extends StatelessWidget {
  const HighRiskClustersMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8), // Map background color
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Stack(
        children: [
          // Mock Map Background (Abstract Lines representing roads)
          Positioned.fill(child: CustomPaint(painter: _MockMapPainter())),

          // Heatmap Blurs
          Positioned(
            left: 200,
            top: 250,
            child: _buildHeatBlur(const Color(0xFFEA3546), 180),
          ),
          Positioned(
            right: 250,
            bottom: 150,
            child: _buildHeatBlur(const Color(0xFFEA3546), 280, opacity: 0.15),
          ),
          Positioned(
            right: 50,
            top: 50,
            child: _buildHeatBlur(const Color(0xFF00C46B), 200, opacity: 0.15),
          ),

          // Marker Point
          Positioned(
            left: 380,
            bottom: 240,
            child: _buildMapMarker('Vada agaram RD'),
          ),

          // Legend at bottom
          Positioned(
            left: 24,
            bottom: 24,
            child: Row(
              children: [
                _buildLegendItem(const Color(0xFFEA3546), 'Pickup Clusters'),
                const SizedBox(width: 24),
                _buildLegendItem(const Color(0xFF00C46B), 'Active Drivers'),
              ],
            ),
          ),

          // Zoom Controls at bottom right
          Positioned(
            right: 24,
            bottom: 24,
            child: Row(
              children: [
                _buildControlButton(Icons.add),
                const SizedBox(width: 8),
                _buildControlButton(Icons.remove),
                const SizedBox(width: 8),
                _buildControlButton(Icons.layers_outlined),
              ],
            ),
          ),

          // Info Card Top Left
          Positioned(left: 24, top: 24, child: _buildInfoCard()),
        ],
      ),
    );
  }

  Widget _buildHeatBlur(Color color, double size, {double opacity = 0.2}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
          stops: [0.0, 1.0],
        ),
      ),
    );
  }

  Widget _buildMapMarker(String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on, color: Color(0xFFEA3546), size: 36),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1D1F),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Center(
        child: Icon(icon, size: 16, color: const Color(0xFF1A1D1F)),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFEA3546),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'High-Risk Clusters',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1D1F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'ANNA NAGAR 2ND AVE',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6F767E),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pickup Failures',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              Text(
                '428',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1D1F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F9),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEA3546),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD6DBE1).withValues(alpha: 0.5)
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw some thick lines mimicking roads
    final path = Path();
    path.moveTo(-50, 400);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.5,
      size.height + 50,
    );

    path.moveTo(-20, 100);
    path.quadraticBezierTo(
      size.width * 0.4,
      150,
      size.width * 1.2,
      size.height * 0.6,
    );

    path.moveTo(size.width * 0.6, -50);
    path.lineTo(size.width * 0.2, size.height + 50);

    canvas.drawPath(path, paint);

    // Draw some thinner roads
    paint.strokeWidth = 6.0;
    paint.color = const Color(0xFFD6DBE1).withValues(alpha: 0.4);
    final path2 = Path();
    path2.moveTo(size.width * 0.8, -50);
    path2.lineTo(size.width * 0.4, size.height + 50);

    path2.moveTo(size.width * 0.3, size.height * 0.3);
    path2.lineTo(size.width * 0.9, size.height * 0.1);

    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
