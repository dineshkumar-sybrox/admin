import 'package:admin/features/drivers/presentation/widgets/driver_suspension_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drivers_management_cubit.dart';
import '../cubit/drivers_management_state.dart';
import '../pages/rider_overview_page.dart';

class SuspendedDriversTable extends StatelessWidget {
  SuspendedDriversTable({super.key});

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
                  headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
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
                    DataColumn(label: Text('SUSPENSION REASON')),
                    DataColumn(label: Text('DATE')),
                    DataColumn(label: Text('APPEAL STATUS')),
                    DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: displayDrivers.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            driver.id,
                            style: AppTypography.base.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RiderOverviewPage(),
                                ),
                              );
                            },
                            child: Text(
                              driver.name,
                              style: AppTypography.base.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(_VehicleBadge(type: driver.vehicleType)),
                        DataCell(
                          _SuspensionReasonBadge(
                            reason: driver.suspensionReason ?? 'VIOLATION',
                            subReason: driver.suspensionSubreason,
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.suspensionDate ?? '-',
                            style: AppTypography.base.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        DataCell(
                          _AppealStatusBadge(
                            status: driver.appealStatus ?? 'NONE',
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  debugPrint("SuspensionDetailsDialog");
                                  showDialog(
                                    context: context,
                                    builder: (_) => SuspensionDetailsDialog(
                                      showActions: true,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Activate',
                                  style: AppTypography.base.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              GestureDetector(
                                onTap: () {
                                  debugPrint("View clicked");
                                  showDialog(
                                    context: context,
                                    builder: (_) => SuspensionDetailsDialog(
                                      showActions: false,
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: AppColors.textSecondary,
                                  size: 18,
                                ),
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
            style: AppTypography.base.copyWith(
              color: const Color(0xFFFF4842),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (subReason != null)
          Text(
            subReason!,
            style: AppTypography.base.copyWith(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTypography.base.copyWith(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
