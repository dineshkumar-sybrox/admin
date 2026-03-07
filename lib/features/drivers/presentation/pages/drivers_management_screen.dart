import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drivers_management_cubit.dart';
import '../widgets/active_drivers_table.dart';
import '../widgets/new_drivers_table.dart';
import '../widgets/suspended_drivers_table.dart';
import '../widgets/driver_stat_cards.dart';
import '../widgets/drivers_table.dart';
import '../widgets/drivers_table_header.dart';
import '../widgets/pagination_controls.dart';

class DriversManagementScreen extends StatelessWidget {
  const DriversManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriversManagementCubit(),
      child: BlocBuilder<DriversManagementCubit, DriverTab>(
        builder: (context, selectedTab) {
          Widget currentTable;
          switch (selectedTab) {
            case DriverTab.active:
              currentTable = const ActiveDriversTable();
              break;
            case DriverTab.newDrivers:
              currentTable = const NewDriversTable();
              break;
            case DriverTab.suspended:
              currentTable = const SuspendedDriversTable();
              break;
            case DriverTab.total:
              currentTable = const DriversTable();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DriverStatCards(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const DriversTableHeader(),
                      currentTable,
                      const Divider(height: 1, color: Color(0xFFE5E7EB)),
                      Container(
                        color: Colors.white,
                        child: const PaginationControls(),
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
