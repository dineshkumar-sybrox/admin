import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_cubit.dart';
import '../cubit/rider_state.dart';

class RiderStatCards extends StatelessWidget {
  const RiderStatCards({super.key});

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
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'ACTIVE RIDERS',
                value: '12,402',
                trendText: 'Peak: 14k',
                isPrimary: state.selectedTab == RiderTab.active,
                onTap: () => context.read<RiderCubit>().setTab(RiderTab.active),
              ),
            ),
            const SizedBox(width: 16),
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
            const SizedBox(width: 16),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPrimary
                ? AppColors.primary
                : const Color(0xFFF1F5F9), // slate-100
            width: isPrimary ? 2 : 1,
          ),
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
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
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 8),
                if (trend != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      trend!,
                      style: TextStyle(
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
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      trendText!,
                      style: TextStyle(
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
    );
  }
}
