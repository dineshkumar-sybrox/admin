import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class SuspendedDriversTable extends StatelessWidget {
  const SuspendedDriversTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriversManagementState>(
      builder: (context, state) {
        if (state.isLoading) return const SizedBox.shrink();

        final displayDrivers = state.filteredDrivers;

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width > 1200
                      ? MediaQuery.of(context).size.width - 320
                      : 1000,
                ),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.tableHeaderBGColor,
                  ),
                  headingTextStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  dataTextStyle: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  horizontalMargin: 24,
                  columnSpacing: 24,
                  headingRowHeight: 56,
                  dataRowMaxHeight: 72,
                  dataRowMinHeight: 72,
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: Color(0xFFF3F4F6),
                      width: 1,
                    ),
                  ),
                  columns: const [
                    DataColumn(label: Text('DRIVER ID')),
                    DataColumn(label: Text('DRIVER')),
                    DataColumn(label: Text('LOCATION')),
                    DataColumn(label: Text('SUSPENSION REASON')),
                    DataColumn(label: Text('DATE')),
                    DataColumn(label: Text('APPEAL STATUS')),
                    DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: displayDrivers.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(Text(driver.id)),
                        DataCell(Text(driver.name)),
                        DataCell(Text(driver.city)),
                        DataCell(
                          _SuspensionReasonBadge(
                            reason: driver.suspensionReason ?? 'VIOLATION',
                            subReason: driver.suspensionSubreason,
                          ),
                        ),
                        DataCell(Text(driver.suspensionDate ?? '-')),
                        DataCell(
                          _AppealStatus(status: driver.appealStatus ?? 'NONE'),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 20,
                                ),
                                onPressed: () {},
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Review'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SuspensionReasonBadge extends StatelessWidget {
  final String reason;
  final String? subReason;
  const _SuspensionReasonBadge({required this.reason, this.subReason});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE5E5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            reason.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFFFF4842),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (subReason != null)
          Text(
            subReason!,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
          ),
      ],
    );
  }
}

class _AppealStatus extends StatelessWidget {
  final String status;
  const _AppealStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFEA580C),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
