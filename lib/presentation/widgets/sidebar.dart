import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/dashboard/presentation/cubit/dashboard_state.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          width: 250,
          color: AppColors.sidebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Area
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GoAPP',
                          style: AppTypography.base.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'ADMIN PANEL',
                          style: AppTypography.base.copyWith(
                            color: AppColors.white.withValues(alpha: 0.5),
                            fontSize: 10,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Menu Items
              _buildMenuItem(
                icon: Icons.grid_view,
                label: 'Dashboard',
                isActive: state.selectedNav == NavItem.dashboard,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.dashboard);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.two_wheeler,
                label: 'Rides',
                isActive: state.selectedNav == NavItem.rider,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.rider);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.person_outline,
                label: 'Drivers',
                isActive: state.selectedNav == NavItem.drivers,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.drivers);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Payments',
                isActive: state.selectedNav == NavItem.payments,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.payments);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.bar_chart,
                label: 'Analytics',
                isActive: state.selectedNav == NavItem.analytics,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.analytics);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.edit_document,
                label: 'Compliance',
                isActive:
                    state.selectedNav == NavItem.compliance ||
                    state.selectedNav == NavItem.totalDocuments ||
                    state.selectedNav == NavItem.totalTickets ||
                    state.selectedNav == NavItem.complianceScoreDetails,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(NavItem.compliance);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                label: 'Zone-wise Pricing',
                isActive: state.selectedNav == NavItem.zoneWisePricing,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(
                    NavItem.zoneWisePricing,
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),

              SizedBox(height: 16),

              // Incentive Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'INCENTIVE',
                  style: AppTypography.base.copyWith(
                    color: AppColors.white.withValues(alpha: 0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildMenuItem(
                icon: Icons.local_offer_outlined,
                label: 'Create Incentive',
                isActive: state.selectedNav == NavItem.createIncentive,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(
                    NavItem.createIncentive,
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                label: 'Incentive History',
                isActive: state.selectedNav == NavItem.incentiveHistory,
                onTap: () {
                  context.read<DashboardCubit>().selectNav(
                    NavItem.incentiveHistory,
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),

              Spacer(),

              // // Support Section
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 24,
              //     vertical: 12,
              //   ),
              //   child: Text(
              //     'SUPPORT',
              //     style: AppTypography.base.copyWith(
              //       color: AppColors.white.withValues(alpha: 0.3),
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // _buildMenuItem(
              //   icon: Icons.headset_mic_outlined,
              //   label: 'Support Center',
              //   onTap: () {},
              // ),
              // _buildMenuItem(
              //   icon: Icons.settings_outlined,
              //   label: 'System Settings',
              //   onTap: () {},
              // ),
              // SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    bool isNew = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ), // Increased margin
      decoration: isActive
          ? BoxDecoration(
              color: AppColors.sidebarActive,
              borderRadius: BorderRadius.circular(8),
              // No left border in screenshot, whole block is highlighted
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive
              ? AppColors.primary
              : AppColors.white.withValues(alpha: 0.5), // Active is Green
          size: 20,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.base.copyWith(
                  color: isActive
                      ? AppColors.white
                      : AppColors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isNew) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: onTap,
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
