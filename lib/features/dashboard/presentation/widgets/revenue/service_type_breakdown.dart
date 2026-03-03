import 'package:flutter/material.dart';

class ServiceTypeBreakdown extends StatelessWidget {
  const ServiceTypeBreakdown({super.key});

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
            'SERVICE TYPE BREAKDOWN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildServiceCard(
                  'CAB',
                  '₹620k',
                  const Color(0xFFFFF6ED),
                  const Color(0xFFDC6803),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildServiceCard(
                  'AUTO',
                  '₹340k',
                  const Color(0xFFE8F2FF),
                  const Color(0xFF2970FF),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildServiceCard(
                  'BIKE/SCOOTER',
                  '₹240k',
                  const Color(0xFFECFDF3),
                  const Color(0xFF027A48),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9ED),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFFE8cC)),
            ),
            child: RichText(
              text: const TextSpan(
                text: 'Pro Tip: ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB54708),
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text:
                        'Prime rides are up 15% today compared to last Friday peak.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB54708),
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

  Widget _buildServiceCard(
    String title,
    String amount,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6F767E),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
