import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';
import '../cubit/drivers_management_state.dart';

class ActiveDriversTable extends StatelessWidget {
  const ActiveDriversTable({super.key});

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
                    const Color(0xFFF8FAFC),
                  ),
                  headingTextStyle: const TextStyle(
                    color: Color(0xFF8E9BAB),
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
                  showCheckboxColumn: false,
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: Color(0xFFF3F4F6),
                      width: 1,
                    ),
                  ),
                  columns: const [
                    DataColumn(label: Text('DRIVER ID')),
                    DataColumn(label: Text('DRIVER')),
                    DataColumn(label: Text('VEHICLE TYPE')),
                    DataColumn(label: Text('CURRENT LOCATION')),
                    DataColumn(
                      label: Text(
                        'COMPLETE RIDES',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(label: Text('ONLINE DURATION')),
                    DataColumn(label: Text('ACCEPTANCE RATE')),
                  ],
                  rows: displayDrivers.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '#${driver.id}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(_VehicleBadge(type: driver.vehicleType)),
                        DataCell(
                          Text(
                            driver.city,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              driver.ridesToday?.toString().padLeft(2, '0') ??
                                  '00',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            _formatDuration(driver.onlineHours ?? 0),
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DataCell(
                          _AcceptanceRateText(rate: driver.acceptanceRate ?? 0),
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

  String _formatDuration(double hours) {
    int wholeHours = hours.floor();
    int minutes = ((hours - wholeHours) * 60).round();
    return '${wholeHours}h ${minutes}m';
  }
}

class _VehicleBadge extends StatelessWidget {
  final String type;
  const _VehicleBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type.toUpperCase()) {
      case 'PREMIUM CAB':
        bgColor = const Color(0xFFFFF7ED);
        textColor = const Color(0xFFEA580C);
        break;
      case 'AUTO':
        bgColor = const Color(0xFFEFF6FF);
        textColor = const Color(0xFF3B82F6);
        break;
      case 'BIKE':
        bgColor = const Color(0xFFF0FDF4);
        textColor = const Color(0xFF22C55E);
        break;
      case 'XL CAB':
        bgColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        break;
      case 'CAB':
      default:
        bgColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AcceptanceRateText extends StatelessWidget {
  final int rate;
  const _AcceptanceRateText({required this.rate});

  @override
  Widget build(BuildContext context) {
    Color textColor;
    if (rate >= 90) {
      textColor = const Color(0xFF22C55E); // Success green
    } else if (rate >= 80) {
      textColor = const Color(0xFF10B981); // Teal
    } else if (rate >= 70) {
      textColor = const Color(0xFFF59E0B); // Amber
    } else {
      textColor = const Color(0xFFEF4444); // Error red
    }

    return Text(
      '$rate%',
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}
