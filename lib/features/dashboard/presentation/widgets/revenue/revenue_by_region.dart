import 'package:flutter/material.dart';

class RevenueByRegion extends StatelessWidget {
  const RevenueByRegion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'REVENUE BY TAMIL NADU',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildRegionProgressBar('Chennai', '₹450k', '38%', 0.38),
          const SizedBox(height: 20),
          _buildRegionProgressBar('Kanchipuram', '₹320k', '27%', 0.27),
          const SizedBox(height: 20),
          _buildRegionProgressBar('Thiruvallur', '₹280k', '23%', 0.23),
        ],
      ),
    );
  }

  Widget _buildRegionProgressBar(
    String city,
    String amount,
    String percent,
    double progress,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              city,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1D1F),
              ),
            ),
            RichText(
              text: TextSpan(
                text: amount,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6F767E),
                ),
                children: [
                  TextSpan(
                    text: ' ($percent)',
                    style: const TextStyle(color: Color(0xFF9EA5AD)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6F9),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A86B),
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
