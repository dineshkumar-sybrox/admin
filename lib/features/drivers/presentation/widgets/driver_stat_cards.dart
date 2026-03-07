import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class DriverStatCards extends StatelessWidget {
  const DriverStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriverTab>(
      builder: (context, selectedTab) {
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
            const SizedBox(width: 16),
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
            const SizedBox(width: 16),
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
            const SizedBox(width: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // Set to 110px approximately based on standard stat lines, but min box works well
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // If it's primary, adding a subtle green background tint matching the Active state
        border: Border.all(
          color: isPrimary ? AppColors.primary : const Color(0xFFE5E7EB),
          width: isPrimary ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              if (trend != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    trend!,
                    style: TextStyle(
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
                  padding: const EdgeInsets.only(bottom: 6, left: 4),
                  child: Text(
                    trendText!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isWarning
                          ? AppColors.error
                          : const Color(0xFF6B7280).withOpacity(0.7),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
