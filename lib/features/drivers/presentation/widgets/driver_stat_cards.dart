import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class DriverStatCards extends StatelessWidget {
  DriverStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriversManagementState>(
      builder: (context, state) {
        final selectedTab = state.selectedTab;
        return Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.read<DriversManagementCubit>().selectTab(
                    DriverTab.total,
                  ),
                  child: _StatCard(
                    title: 'TOTAL DRIVERS',
                    value: '48,921',
                    trend: '+2.4%',
                    trendIsPositive: true,
                    isPrimary: selectedTab == DriverTab.total,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.read<DriversManagementCubit>().selectTab(
                    DriverTab.active,
                  ),
                  child: _StatCard(
                    title: 'ACTIVE DRIVERS',
                    value: '12,402',
                    trend: '+2.4%',
                    trendText: 'Peak: 14k', // From the newest active screenshot
                    trendIsPositive: true,
                    isPrimary: selectedTab == DriverTab.active,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.read<DriversManagementCubit>().selectTab(
                    DriverTab.newDrivers,
                  ),
                  child: _StatCard(
                    title: 'NEW DRIVERS',
                    value: '428',
                    trend: '+12%',
                    trendIsPositive: true,
                    isPrimary: selectedTab == DriverTab.newDrivers,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.read<DriversManagementCubit>().selectTab(
                    DriverTab.suspended,
                  ),
                  child: _StatCard(
                    title: 'SUSPENDED DRIVERS',
                    value: '152',
                    trendText: 'Flagged for review',
                    isWarning: true,
                    isPrimary: selectedTab == DriverTab.suspended,
                  ),
                ),
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
  final bool isPrimary;
  final bool isWarning;

  const _StatCard({
    required this.title,
    required this.value,
    this.trend,
    this.trendText,
    this.trendIsPositive = true,
    this.isPrimary = false,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.base.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFF6B7280,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            value,
                            style: AppTypography.base.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 8),
                          if (trend != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                trend!,
                                style: AppTypography.base.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: trendIsPositive
                                      ? AppColors.primary
                                      : AppColors.error,
                                ),
                              ),
                            ),
                          if (trendText != null)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 6,
                                left: 4,
                              ),
                              child: Text(
                                trendText!,
                                style: AppTypography.base.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isWarning
                                      ? AppColors.error
                                      : Color(
                                          0xFF6B7280,
                                        ).withOpacity(0.7),
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
    );
  }
}







