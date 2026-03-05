import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TrustSafetyPanel extends StatelessWidget {
  const TrustSafetyPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shield_outlined, color: AppColors.warning, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Trust & Safety',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSafetyItem(
              icon: Icons.check_circle_outline,
              color: AppColors.success,
              title: 'Verified Account',
              subtitle: 'KYC completed on Aug 12, 2023',
            ),
            const SizedBox(height: 16),
            _buildSafetyItem(
              icon: Icons.warning_amber_rounded,
              color: AppColors.textSecondary, // Or specific color
              title: 'No Safety Reports',
              subtitle: 'Last 12 months clear of violations',
            ),
            const SizedBox(height: 16),
            _buildSafetyItem(
              icon: Icons.credit_card,
              color: AppColors.textPrimary,
              title: 'Default Payment',
              subtitle: 'CASH ON PAY',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
