import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/total_tickets_cubit.dart';
import '../../cubit/total_tickets_state.dart';

class TotalTicketsStatCards extends StatelessWidget {
  final TicketStatusFilter statusFilter;

  const TotalTicketsStatCards({super.key, required this.statusFilter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TopStatCard(
            title: 'OPEN TICKETS',
            value: '142',
            trend: '-5.2%',
            isPositive: false,
            isActive: statusFilter == TicketStatusFilter.open,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.open,
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'CLOSED TICKETS',
            value: '100',
            trend: '+2.1%',
            isPositive: true,
            isActive: statusFilter == TicketStatusFilter.closed,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.closed,
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'REFUND AMOUNT',
            value: '₹4.2K',
            trend: '-2.2%',
            
            isPositive: false,
            isActive: statusFilter == TicketStatusFilter.refund,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.refund,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final bool isActive;
  final VoidCallback onTap;

  const _TopStatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isActive
                  ? AppColors.primary
                  : AppColors.transparent,
              width: 4,
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
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: AppTypography.h1.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(width: 12),

                  /// TREND ICON + TEXT
                  Row(
                    children: [
                      Icon(
                        isPositive
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 16,
                        color: isPositive
                            ? AppColors.cFF22C55E
                            : AppColors.red,
                      ),
                      SizedBox(width: 4),
                      Text(
                        trend,
                        style: AppTypography.bodySmall.copyWith(
                          color: isPositive
                              ? AppColors.cFF22C55E
                              : AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}