import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle; // e.g., "Avg ₹87.6/ride"
  final String? trend; // e.g., "+12%"
  final bool isPositiveTrend;
  final Widget? extraContent; // For rating stars etc.
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? activeColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.trend,
    this.isPositiveTrend = true,
    this.extraContent,
    this.isSelected = false,
    this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.1),
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isSelected)
                Container(width: 4, color: activeColor ?? AppColors.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: title == 'Cancellation'
                              ? AppColors.error
                              : AppColors
                                    .textPrimary, // Special case for cancellation
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (trend != null)
                        Row(
                          children: [
                            Icon(
                              Icons
                                  .trending_up, // Use trending up for both, just change color/rotation if needed
                              size: 20,
                              color: isPositiveTrend
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trend!,
                              style: TextStyle(
                                color: isPositiveTrend
                                    ? AppColors.success
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      if (extraContent != null) ...[
                        const SizedBox(height: 4),
                        extraContent!,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
