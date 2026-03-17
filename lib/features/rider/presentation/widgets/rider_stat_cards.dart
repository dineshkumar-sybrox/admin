import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_cubit.dart';
import '../cubit/rider_state.dart';

class RiderStatCards extends StatelessWidget {
  RiderStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiderCubit, RiderState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'TOTAL RIDERS',
                value: '48,921',
                trend: '+2.4%',
                trendIsPositive: true,
                isPrimary: state.selectedTab == RiderTab.total,
                onTap: () => context.read<RiderCubit>().setTab(RiderTab.total),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'ACTIVE RIDERS',
                value: '12,402',
                trendText: 'Peak: 14k',
                isPrimary: state.selectedTab == RiderTab.active,
                onTap: () => context.read<RiderCubit>().setTab(RiderTab.active),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'NEW RIDERS',
                value: '428',
                trend: '+12%',
                trendIsPositive: true,
                isPrimary: state.selectedTab == RiderTab.newRiders,
                onTap: () =>
                    context.read<RiderCubit>().setTab(RiderTab.newRiders),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'SUSPENDED RIDERS',
                value: '152',
                trendText: 'Flagged for review',
                trendTextIsError: true,
                isPrimary: state.selectedTab == RiderTab.suspended,
                onTap: () =>
                    context.read<RiderCubit>().setTab(RiderTab.suspended),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;
  final String? trendText;
  final bool trendIsPositive;
  final bool trendTextIsError;
  final bool isPrimary;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    this.trend,
    this.trendText,
    this.trendIsPositive = true,
    this.trendTextIsError = false,
    this.isPrimary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isPrimary
                  ? AppColors.primary
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
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(12),
        //   border: Border.all(
        //     color: AppColors.cFFF1F5F9, // slate-100
        //     width: 1,
        //   ),
        //   boxShadow: [
        //     if (isPrimary)
        //       BoxShadow(
        //         color: AppColors.primary.withValues(alpha: 0.1),
        //         blurRadius: 10,
        //         offset: Offset(0, 4),
        //       )
        //     else
        //       BoxShadow(
        //         color: AppColors.black.withValues(alpha: 0.02),
        //         blurRadius: 8,
        //         offset: Offset(0, 2),
        //       ),
        //   ],
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //if (isPrimary) Container(width: 3, color: AppColors.primary),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.base.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              value,
                              style: AppTypography.base.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            if (trend != null)
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  trend!,
                                  style: AppTypography.base.copyWith(
                                    color: trendIsPositive
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if (trendText != null)
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  trendText!,
                                  style: AppTypography.base.copyWith(
                                    color: trendTextIsError
                                        ? AppColors.error
                                        : AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
