import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/dashboard_cubit.dart';
import '../../../../drivers/presentation/cubit/drivers_management_state.dart';

class TopEarningDrivers extends StatelessWidget {
  TopEarningDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOP EARNING DRIVERS',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cFF1A1D1F,
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cFFE8FDF2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'TODAY',
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF00A86B,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          _buildDriverRow(
            '1',
            'Rahul M.',
            '48 Rides Today',
            '₹8,450',
            AppColors.cFFFFA629,
          ),
          _buildDriverRow(
            '2',
            'Vikram S.',
            '42 Rides Today',
            '₹7,120',
            AppColors.cFF67B5FF,
          ),
          _buildDriverRow(
            '3',
            'Amit J.',
            '39 Rides Today',
            '₹6,840',
            AppColors.cFFFF8A29,
          ),
          _buildDriverRow(
            '4',
            'Arun',
            '35 Rides Today',
            '₹6,340',
            AppColors.cFFFF7A29,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: OutlinedButton(
              onPressed: () {
                context.read<DashboardCubit>().selectDriversTab(
                  DriverTab.leaderboard,
                );
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: AppColors.cFFEFEFEF),
              ),
              child: Text(
                'VIEW FULL LEADERBOARD',
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cFF6F767E,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverRow(
    String rank,
    String name,
    String rides,
    String amount,
    Color rankColor,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cFFF4F6F9,
                  border: Border.all(color: AppColors.cFFEFEFEF, width: 2),
                ),
                child: Center(
                  child: Icon(Icons.person, color: AppColors.grey[400]),
                ),
              ),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: rankColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      rank,
                      style: AppTypography.base.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cFF1A1D1F,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  rides,
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cFF6F767E,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTypography.base.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF00A86B,
            ),
          ),
        ],
      ),
    );
  }
}




