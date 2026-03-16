import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class RecentCancelledRides extends StatelessWidget {
  RecentCancelledRides({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Recent Cancelled Rides',
            style: AppTypography.base.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF1A1D1F,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Real-time update stream',
            style: AppTypography.base.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.cFF9EA5AD,
            ),
          ),
          SizedBox(height: 24),
          _buildRideCard(
            id: '#RD-4421',
            timeAgo: '2 min ago',
            reason: 'Long Wait Time',
            cancelledBy: 'Cancelled By Driver',
          ),
          SizedBox(height: 16),
          _buildRideCard(
            id: '#RD-4418',
            timeAgo: '5 min ago',
            reason: 'Driver No Show',
            cancelledBy: 'Cancelled By Rider',
          ),
          SizedBox(height: 16),
          _buildRideCard(
            id: '#RD-4418',
            timeAgo: '5 min ago',
            reason: 'Driver No Show',
            cancelledBy: 'Cancelled By Rider',
          ),
          SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'VIEW COMPLETE HISTORY',
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.cFF00C46B,
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB, // Very light gray/white background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id,
                style: AppTypography.base.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cFF9EA5AD,
                ),
              ),
              Text(
                timeAgo,
                style: AppTypography.base.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cFFEA3546, // Red time text
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            reason,
            style: AppTypography.base.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF1A1D1F,
            ),
          ),
          SizedBox(height: 4),
          Text(
            cancelledBy,
            style: AppTypography.base.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.cFF6F767E,
            ),
          ),
        ],
      ),
    );
  }
}




