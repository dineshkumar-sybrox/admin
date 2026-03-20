import 'package:admin/core/theme/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/dashboard_cubit.dart';
import '../../cubit/dashboard_state.dart';

class RevenueStatCards extends StatelessWidget {
  RevenueStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevenueStatCubit, RevenueStatState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'TOTAL REVENUE',
                value: '90k',
                trend: '+5.2%',
                trendIsPositive: true,
                isPrimary:
                    state.showOnlyTable &&
                    state.selectedTab == RevenueTab.total,
                onTap: () =>
                    context.read<RevenueStatCubit>().setTab(RevenueTab.total),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'CAR REVENUE',
                value: '30k',
                trend: '+2.1%',
                trendIsPositive: true,
                isPrimary:
                    state.showOnlyTable && state.selectedTab == RevenueTab.cab,
                onTap: () =>
                    context.read<RevenueStatCubit>().setTab(RevenueTab.cab),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'AUTO REVENUE',
                value: '10k',
                trend: '+12%',
                trendIsPositive: true,
                isPrimary:
                    state.showOnlyTable && state.selectedTab == RevenueTab.auto,
                onTap: () =>
                    context.read<RevenueStatCubit>().setTab(RevenueTab.auto),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'BIKE / SCOOTER REVENUE',
                value: '50k',
                trend: '-0.5%',
                trendIsPositive: false,
                isPrimary:
                    state.showOnlyTable && state.selectedTab == RevenueTab.bike,
                onTap: () =>
                    context.read<RevenueStatCubit>().setTab(RevenueTab.bike),
              ),
            ),
          ],
        );
      },
    );
  }
}

enum RevenueTab { total, cab, auto, bike }

class RevenueStatState {
  final RevenueTab selectedTab;
  final bool showOnlyTable;
  final String searchQuery;
  final String vehicleFilter;
  final bool showLeaderboard;

  const RevenueStatState({
    required this.selectedTab,
    required this.showOnlyTable,
    required this.searchQuery,
    required this.vehicleFilter,
    required this.showLeaderboard,
  });

  RevenueStatState copyWith({
    RevenueTab? selectedTab,
    bool? showOnlyTable,
    String? searchQuery,
    String? vehicleFilter,
    bool? showLeaderboard,
  }) {
    return RevenueStatState(
      selectedTab: selectedTab ?? this.selectedTab,
      showOnlyTable: showOnlyTable ?? this.showOnlyTable,
      searchQuery: searchQuery ?? this.searchQuery,
      vehicleFilter: vehicleFilter ?? this.vehicleFilter,
      showLeaderboard: showLeaderboard ?? this.showLeaderboard,
    );
  }
}

class RevenueStatCubit extends Cubit<RevenueStatState> {
  RevenueStatCubit()
    : super(
        const RevenueStatState(
          selectedTab: RevenueTab.total,
          showOnlyTable: false,
          searchQuery: '',
          vehicleFilter: 'All',
          showLeaderboard: false,
        ),
      );

  void setTab(RevenueTab tab) {
    emit(
      state.copyWith(
        selectedTab: tab,
        showOnlyTable: true,
        showLeaderboard: false,
      ),
    );
  }

  void showAll() {
    emit(state.copyWith(showOnlyTable: false, showLeaderboard: false));
  }

  void setSearch(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setVehicleFilter(String filter) {
    emit(state.copyWith(vehicleFilter: filter));
  }

  void showLeaderboard() {
    emit(state.copyWith(showLeaderboard: true, showOnlyTable: false));
  }
}




class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;
  final bool trendIsPositive;
  final bool isPrimary;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    this.trend,
    this.trendIsPositive = true,
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
