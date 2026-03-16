import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/dashboard_cubit.dart';
import '../../cubit/dashboard_state.dart';

class RecentTransactionsTable extends StatelessWidget {
  RecentTransactionsTable({super.key});

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
                  'Recent Transactions',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cFF1A1D1F,
                  ),
                ),
                BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    return TextButton.icon(
                      onPressed: state.isExportingReport
                          ? null
                          : () => context
                                .read<DashboardCubit>()
                                .exportTodayReport(),
                      icon: state.isExportingReport
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.cFF6F767E,
                              ),
                            )
                          : Icon(
                              Icons.download_rounded,
                              size: 16,
                              color: AppColors.cFF6F767E,
                            ),
                      label: Text(
                        state.isExportingReport
                            ? 'EXPORTING...'
                            : 'EXPORT EXCEL',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cFF6F767E,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: DataTable(
                        columnSpacing: 40,
                        horizontalMargin: 16,
                        headingRowHeight: 60,
                        dataRowMinHeight: 60,
                        dataRowMaxHeight: 60,
                        headingRowColor: MaterialStateProperty.all(
                          AppColors.cFFF8F8F8,
                        ),
                        headingTextStyle: AppTypography.base.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                        columns: const [
                          DataColumn(label: Text('RIDE ID')),
                          DataColumn(label: Text('AMOUNT\n(₹)')),
                          DataColumn(label: Text('SERVICE\nTYPE')),
                          DataColumn(label: Text('PAYMENT\nMETHOD')),
                          DataColumn(label: Text('STATUS')),
                        ],
                        rows: state.recentTransactions.map((t) {
                          Color serviceColor;
                          Color serviceTextColor;

                          switch (t.serviceType) {
                            case 'CAB':
                              serviceColor = AppColors.cFFFFF6ED;
                              serviceTextColor = AppColors.cFFDC6803;
                              break;
                            case 'AUTO':
                              serviceColor = AppColors.cFFE8F2FF;
                              serviceTextColor = AppColors.cFF2970FF;
                              break;
                            case 'BIKE/SCOOTER':
                            default:
                              serviceColor = AppColors.cFFECFDF3;
                              serviceTextColor = AppColors.cFF027A48;
                          }

                          IconData paymentIcon = t.paymentMethod == 'UPI'
                              ? Icons.qr_code_2
                              : Icons.money;

                          return _buildRow(
                            id: t.id,
                            amount: '₹${t.amount}',
                            serviceType: t.serviceType,
                            serviceColor: serviceColor,
                            serviceTextColor: serviceTextColor,
                            paymentMethod: t.paymentMethod,
                            paymentIcon: paymentIcon,
                            status: t.status,
                            isCompleted: t.isCompleted,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOAD OLDER HISTORY',
                    style: AppTypography.base.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF6F767E,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: AppColors.cFF6F767E,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow({
    required String id,
    required String amount,
    required String serviceType,
    required Color serviceColor,
    required Color serviceTextColor,
    required String paymentMethod,
    required IconData paymentIcon,
    required String status,
    required bool isCompleted,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            id,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            amount,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: serviceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              serviceType,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: serviceTextColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(paymentIcon, size: 16, color: AppColors.cFF9EA5AD),
              SizedBox(width: 8),
              Text(
                paymentMethod,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppColors.cFF00A86B
                      : AppColors.cFFFF4757,
                ),
              ),
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: isCompleted
                      ? AppColors.cFF00A86B
                      : AppColors.cFFFF4757,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





