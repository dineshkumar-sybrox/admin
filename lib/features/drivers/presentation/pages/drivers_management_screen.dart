import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drivers_management_cubit.dart';
import '../widgets/active_drivers_table.dart';
import '../widgets/new_drivers_table.dart';
import '../widgets/suspended_drivers_table.dart';
import '../widgets/leaderboard_table.dart';
import '../widgets/driver_stat_cards.dart';
import '../widgets/drivers_table.dart';
import '../widgets/drivers_table_header.dart';
import '../widgets/pagination_controls.dart';

class DriversManagementScreen extends StatelessWidget {
  final DriverTab? initialTab;
  DriversManagementScreen({super.key, this.initialTab});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriversManagementCubit(initialTab: initialTab ?? DriverTab.total),
      child: BlocBuilder<DriversManagementCubit, DriversManagementState>(
        builder: (context, state) {
          Widget currentTable;
          switch (state.selectedTab) {
            case DriverTab.active:
              currentTable = ActiveDriversTable();
              break;
            case DriverTab.newDrivers:
              currentTable = NewDriversTable();
              break;
            case DriverTab.suspended:
              currentTable = SuspendedDriversTable();
              break;
            case DriverTab.leaderboard:
              currentTable = const LeaderboardTable();
              break;
            case DriverTab.total:
              currentTable = DriversTable();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DriverStatCards(),
              SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cFFE5E7EB),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DriversTableHeader(),
                      currentTable,
                      Divider(height: 1, color: AppColors.cFFE5E7EB),
                      Container(
                        color: AppColors.cFFF8FAFC,
                        child: PaginationControls(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



