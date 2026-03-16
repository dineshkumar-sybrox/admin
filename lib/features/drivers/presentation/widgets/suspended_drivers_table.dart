import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drivers_management_cubit.dart';
import '../cubit/drivers_management_state.dart';

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
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: AppColors.cFFF3F4F6,
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
                        DataCell(
                          Text(
                            driver.id,
                            style: AppTypography.base.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.name,
                            style: AppTypography.base.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            driver.city,
                            style: AppTypography.base.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
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
                            children: [
                              InkWell(
                                onTap: () {
                                  // Action logic from branch
                                },
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
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
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppColors.textSecondary,
                                        size: 20,
                                      ),
                                    ],
                                  ),
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
