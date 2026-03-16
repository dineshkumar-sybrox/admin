import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class Sidebar extends StatelessWidget {
  final bool isCompact;
  Sidebar({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final width = isCompact ? 64.0 : 200.0;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: width,
          color: AppColors.cFF1A2332,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.cFF00A86B,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.local_taxi,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    if (!isCompact) ...[
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GoAPP',
                            style: AppTypography.base.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'ADMIN PANEL',
                            style: AppTypography.base.copyWith(
                              color: AppColors.cFF6B7A8D,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 8),
              _NavItem(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                navItem: NavItem.dashboard,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.dashboard,
              ),
              _NavItem(
                icon: Icons.pedal_bike_outlined,
                label: 'Rider',
                navItem: NavItem.rider,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.rider,
              ),
              _NavItem(
                icon: Icons.person_2_outlined,
                label: 'Drivers',
                navItem: NavItem.drivers,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.drivers,
              ),
              _NavItem(
                icon: Icons.payments_outlined,
                label: 'Payments',
                navItem: NavItem.payments,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.payments,
              ),
              _NavItem(
                icon: Icons.analytics_outlined,
                label: 'Analytics',
                navItem: NavItem.analytics,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.analytics,
              ),
              _NavItem(
                icon: Icons.verified_user_outlined,
                label: 'Compliance',
                navItem: NavItem.compliance,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.compliance,
              ),
              if (!isCompact)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    'SUPPORT',
                    style: AppTypography.base.copyWith(
                      color: AppColors.white.withValues(alpha: 0.3),
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              _NavItem(
                icon: Icons.headset_mic_outlined,
                label: 'Support Center',
                navItem: NavItem.support,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.support,
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'System Settings',
                navItem: NavItem.settings,
                isCompact: isCompact,
                isSelected: state.selectedNav == NavItem.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final NavItem navItem;
  final bool isCompact;
  final bool isSelected;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.navItem,
    required this.isCompact,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<DashboardCubit>().selectNav(navItem),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 0 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cFF00A86B.withValues(alpha: 0.15)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border(
                  left: BorderSide(color: AppColors.cFF00A86B, width: 3),
                )
              : null,
        ),
        child: isCompact
            ? Center(
                child: Icon(
                  icon,
                  color: isSelected
                      ? AppColors.cFF00A86B
                      : AppColors.cFF6B7A8D,
                  size: 18,
                ),
              )
            : Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? AppColors.cFF00A86B
                        : AppColors.cFF6B7A8D,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    label,
                    style: AppTypography.base.copyWith(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.cFF6B7A8D,
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}



