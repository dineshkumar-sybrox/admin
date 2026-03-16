import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class DriversTable extends StatelessWidget {
  const DriversTable({super.key});

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
              // Added vertical scrolling
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
                    DataColumn(label: Text('VEHICLE TYPE')),
                    DataColumn(label: Text('LOCATION')),
                    DataColumn(
                      label: Text(
                        'LIFETIME\nRIDES',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(label: Text('WALLET BALANCE (₹)')),
                    DataColumn(label: Text('STATUS')),
                  ],
                  rows: displayDrivers.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(Text(driver.id)),
                        DataCell(Text(driver.name)),
                        DataCell(_VehicleBadge(type: driver.vehicleType)),
                        DataCell(
                          Text(
                            driver.city,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.lifetimeRides.toString().replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            ),
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.walletBalance < 0
                                ? '- ₹${driver.walletBalance.abs().toStringAsFixed(2)}'
                                : '₹${driver.walletBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: driver.walletBalance < 0
                                  ? AppColors.error
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(_StatusBadge(status: driver.status)),
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

class _VehicleBadge extends StatelessWidget {
  final String type;

  const _VehicleBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type) {
      case 'PREMIUM CAB':
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFD97706);
        break;
      case 'AUTO':
        bgColor = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF2563EB);
        break;
      case 'BIKE':
        bgColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF059669);
        break;
      case 'XL CAB':
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFD97706);
        break;
      case 'CAB':
      default:
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFD97706);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    Color textColor;

    switch (status) {
      case 'Active':
        dotColor = AppColors.success;
        textColor = AppColors.success;
        break;
      case 'Suspended':
        dotColor = AppColors.error;
        textColor = AppColors.error;
        break;
      case 'Offline':
      default:
        dotColor = AppColors.textSecondary;
        textColor = AppColors.textSecondary;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          status,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
