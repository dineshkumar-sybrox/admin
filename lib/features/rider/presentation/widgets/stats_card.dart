import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
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

  StatsCard({
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isSelected
                  ? (activeColor ?? AppColors.primary)
                  : AppColors.transparent, // 👈 Hide when not selected
              width: 4, // Thickness of left border
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Text(
              title.toUpperCase(),
              style: AppTypography.base.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF8E9BAB,
                letterSpacing: 0.4,
              ),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: AppTypography.base.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: title == 'Cancellation'
                    ? AppColors.error
                    : AppColors.textPrimary, // Special case for cancellation
                height: 1,
              ),
            ),
            SizedBox(height: 10),
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
                  SizedBox(width: 4),
                  Text(
                    trend!,
                    style: AppTypography.base.copyWith(
                      color: isPositiveTrend
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10),
            if (subtitle != null)
              Text(
                subtitle!,
                style: AppTypography.base.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            if (extraContent != null) ...[
              SizedBox(height: 4),
              extraContent!,
            ],
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}




// Card(
    //   elevation: isSelected ? 4 : 0,
    //   shadowColor: AppColors.primary.withValues(alpha: 0.5),
    //   margin: EdgeInsets.zero,
    //   color: AppColors.white,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16),
    //     //side: BorderSide(color: AppColors.divider, width: 1),
    //   ),
    //   clipBehavior: Clip.antiAlias,
    //   child: InkWell(
    //     onTap: onTap,
    //     child: IntrinsicHeight(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           if (isSelected)
    //             Container(
    //               width: 6,
    //               decoration: BoxDecoration(
    //                 color: activeColor ?? AppColors.primary,
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(16),
    //                   bottomLeft: Radius.circular(16),
    //                 ),
    //               ),
    //               //width: 4,
    //               //color: activeColor ?? AppColors.primary,
    //             ),
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.all(24.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     title.toUpperCase(),
    //                     style: AppTypography.base.copyWith(
    //                       fontSize: 11,
    //                       fontWeight: FontWeight.bold,
    //                       letterSpacing: 0.8,
    //                       color: AppColors.textSecondary,
    //                     ),
    //                   ),
    //                   SizedBox(height: 16),
    //                   Text(
    //                     value,
    //                     style: AppTypography.base.copyWith(
    //                       fontSize: 28,
    //                       fontWeight: FontWeight.bold,
    // color: title == 'Cancellation'
    //     ? AppColors.error
    //     : AppColors
    //           .textPrimary, // Special case for cancellation
    //                     ),
    //                   ),
    //                   SizedBox(height: 8),
    //   if (trend != null)
    //     Row(
    //       children: [
    //         Icon(
    //           Icons
    //               .trending_up, // Use trending up for both, just change color/rotation if needed
    //           size: 20,
    //           color: isPositiveTrend
    //               ? AppColors.success
    //               : AppColors.textSecondary,
    //         ),
    //         SizedBox(width: 4),
    //         Text(
    //           trend!,
    //           style: AppTypography.base.copyWith(
    //             color: isPositiveTrend
    //                 ? AppColors.success
    //                 : AppColors.textSecondary,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 14,
    //           ),
    //         ),
    //       ],
    //     ),
    //   if (subtitle != null)
    //     Text(
    //       subtitle!,
    //       style: AppTypography.base.copyWith(
    //         fontSize: 14,
    //         fontWeight: FontWeight.w500,
    //         color: AppColors.textSecondary,
    //       ),
    //     ),
    //   if (extraContent != null) ...[
    //     SizedBox(height: 4),
    //     extraContent!,
    //   ],
    // ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

