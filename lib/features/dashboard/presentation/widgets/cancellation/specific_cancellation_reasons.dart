import 'package:flutter/material.dart';

class SpecificCancellationReasons extends StatelessWidget {
  const SpecificCancellationReasons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cancellation Reasons in Anna Nagar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Specific to current zone critical period',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9EA5AD),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.bar_chart_rounded,
                color: const Color(0xFF9EA5AD).withValues(alpha: 0.5),
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildReasonBar(
            'High wait time',
            0.48,
            '48%',
            const Color(0xFFEA3546),
          ),
          const SizedBox(height: 24),
          _buildReasonBar(
            'Driver took too long to arrive',
            0.32,
            '32%',
            const Color(0xFFF27B86),
          ),
          const SizedBox(height: 24),
          _buildReasonBar(
            'Found another alternative',
            0.12,
            '12%',
            const Color(0xFF9EA5AD),
          ),
          const SizedBox(height: 24),
          _buildReasonBar(
            'App/GPS Glitch',
            0.08,
            '8%',
            const Color(0xFFD6DBE1),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReasonBar(
    String title,
    double progress,
    String percentage,
    Color activeColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1D1F),
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1D1F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: (progress * 100).toInt(),
                child: Container(
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: ((1 - progress) * 100).toInt(),
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
