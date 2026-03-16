import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';
import 'suspension_details_dialog.dart';

class SuspendedDriversTable extends StatelessWidget {
  SuspendedDriversTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriversManagementState>(
      builder: (context, state) {
        if (state.isLoading) return SizedBox.shrink();

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
                    AppColors.cFFF8FAFC,
                  ),
                  headingTextStyle: AppTypography.base.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  dataTextStyle: AppTypography.base.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  horizontalMargin: 24,
                  columnSpacing: 24,
                  headingRowHeight: 56,
                  dataRowMaxHeight: 72,
                  dataRowMinHeight: 72,
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: AppColors.cFFF3F4F6,
                      width: 1,
                    ),
                  ),
                  columns: const [
                    DataColumn(label: Text('DRIVER ID')),
                    DataColumn(label: Text('DRIVER')),
                    DataColumn(label: Text('VEHICLE TYPE')),
                    DataColumn(
                      label: Text(
                        'SUSPENSION\nREASON',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'SUSPENSION\nDATE',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(label: Text('APPEAL STATUS')),
                    DataColumn(label: Text('ACTION')),
                  ],
                  rows: displayDrivers.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(Text(driver.id)),
                        DataCell(Text(driver.name)),
                        DataCell(_VehicleBadge(type: driver.vehicleType)),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                driver.suspensionReason ?? 'N/A',
                                style: AppTypography.base.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                driver.suspensionSubreason ?? '',
                                style: AppTypography.base.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.suspensionDate ?? '-',
                            style: AppTypography.base.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        DataCell(
                          _AppealStatusBadge(
                            status: driver.appealStatus ?? 'NONE',
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) =>
                                    SuspensionDetailsDialog(),
                              );
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Activate',
                                    style: AppTypography.base.copyWith(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: AppColors.textSecondary,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
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

class _VehicleBadge extends StatelessWidget {
  final String type;

  const _VehicleBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type) {
      case 'PREMIUM CAB':
        bgColor = AppColors.cFFFEF3C7;
        textColor = AppColors.cFFD97706;
        break;
      case 'AUTO':
        bgColor = AppColors.cFFDBEAFE;
        textColor = AppColors.cFF2563EB;
        break;
      case 'BIKE':
        bgColor = AppColors.cFFD1FAE5;
        textColor = AppColors.cFF059669;
        break;
      case 'XL CAB':
        bgColor = AppColors.cFFFEF3C7;
        textColor = AppColors.cFFD97706;
        break;
      case 'CAB':
      default:
        bgColor = AppColors.cFFFEF3C7;
        textColor = AppColors.cFFD97706;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: AppTypography.base.copyWith(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AppealStatusBadge extends StatelessWidget {
  final String status;

  const _AppealStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (status == 'PENDING REVIEW') {
      bgColor = AppColors.cFFFEF3C7;
      textColor = AppColors.cFFD97706;
    } else if (status == 'REJECTED') {
      bgColor = AppColors.cFFFEE2E2;
      textColor = AppColors.cFFDC2626;
    } else {
      bgColor = AppColors.cFFF3F4F6;
      textColor = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: AppTypography.base.copyWith(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}




