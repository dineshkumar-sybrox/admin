import 'package:flutter/material.dart';

class RecentCancelledRides extends StatelessWidget {
  const RecentCancelledRides({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recent Cancelled Rides',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Real-time update stream',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9EA5AD),
            ),
          ),
          const SizedBox(height: 24),
          _buildRideCard(
            id: '#RD-4421',
            timeAgo: '2 min ago',
            reason: 'Long Wait Time',
            cancelledBy: 'Cancelled By Driver',
          ),
          const SizedBox(height: 16),
          _buildRideCard(
            id: '#RD-4418',
            timeAgo: '5 min ago',
            reason: 'Driver No Show',
            cancelledBy: 'Cancelled By Rider',
          ),
          const SizedBox(height: 16),
          _buildRideCard(
            id: '#RD-4418',
            timeAgo: '5 min ago',
            reason: 'Driver No Show',
            cancelledBy: 'Cancelled By Rider',
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'VIEW COMPLETE HISTORY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF00C46B),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideCard({
    required String id,
    required String timeAgo,
    required String reason,
    required String cancelledBy,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Very light gray/white background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF0F1F3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9EA5AD),
                ),
              ),
              Text(
                timeAgo,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEA3546), // Red time text
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reason,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cancelledBy,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6F767E),
            ),
          ),
        ],
      ),
    );
  }
}
