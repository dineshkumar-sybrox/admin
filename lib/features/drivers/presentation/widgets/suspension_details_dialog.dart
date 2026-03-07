import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SuspensionDetailsDialog extends StatelessWidget {
  const SuspensionDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Dialog sizes to maintain a good aspect ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 800 ? 700.0 : screenWidth * 0.9;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent, // Prevents Material 3 color tinting
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildActivityOverview()),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: _buildPolicyViolation()),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildUserReports(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'CURRENT VIOLATION DETAILS',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Reported on 15 Feb, 2026',
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: AppColors.textPrimary,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Overview',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(title: 'TOTAL RIDES', value: '142'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OverviewStatCard(title: 'ACCOUNT AGE', value: '2 Years'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(
                title: 'CANCELLATION RATE',
                value: '8.2%',
                isErrorValue: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _OverviewStatCard(
                title: 'LAST RIDE DATE',
                value: 'Oct 12, 2023',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPolicyViolation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Policy Violation: Unsafe Driving Reports',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Multiple users reported aggressive maneuvering and exceeding speed limits in residential zones. Telemetry data confirms speeds 30% above limit on 3 separate occasions during trip #TRP-8821.',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildUserReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'USER REPORTS (02)',
          style: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        _UserReportItem(
          rating: '1/5 Rating',
          title: 'Felt very unsafe',
          comment:
              'The driver was swerving between lanes and braking very late. I had to ask him to slow down twice.',
        ),
        const SizedBox(height: 12),
        _UserReportItem(
          rating: '2/5 Rating',
          title: 'Aggressive driver',
          comment: 'Overtook other vehicles dangerously. Please investigate.',
        ),
      ],
    );
  }
}

class _OverviewStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isErrorValue;

  const _OverviewStatCard({
    required this.title,
    required this.value,
    this.isErrorValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Very light gray/blue background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF94A3B8), // slate-400
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isErrorValue ? AppColors.error : AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserReportItem extends StatelessWidget {
  final String rating;
  final String title;
  final String comment;

  const _UserReportItem({
    required this.rating,
    required this.title,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)), // slate-200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFEAB308),
                size: 14,
              ), // yellow-500
              const SizedBox(width: 6),
              Text(
                rating,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '•',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                '"$title"',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '"$comment"',
            style: const TextStyle(
              color: Color(0xFF475569), // slate-600
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
