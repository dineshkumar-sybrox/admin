import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_state.dart';
import '../pages/rider_overview_page.dart';

class RiderTable extends StatelessWidget {
  final RiderState state;

  const RiderTable({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.filteredRiders.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No riders found',
            style: AppTypography.base.copyWith(
              color: AppColors.cFF8E9BAB,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

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
              headingRowColor:
                  WidgetStateProperty.all(AppColors.cFFF8FAFC),
              headingTextStyle: AppTypography.base.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              dataTextStyle: AppTypography.base.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              horizontalMargin: 24,
              columnSpacing: 50,
              headingRowHeight: 56,
              dataRowMaxHeight: 72,
              dataRowMinHeight: 72,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: AppColors.cFFF3F4F6,
                  width: 1,
                ),
              ),

              /// TABLE HEADERS
              columns: const [
                DataColumn(label: Center(child: Text('RIDER ID'))),
                DataColumn(label: Center(child: Text('RIDER NAME'))),
                DataColumn(label: Center(child: Text('CONTACT INFORMATION'))),
                DataColumn(label: Center(child: Text('TOTAL RIDES'))),
                DataColumn(label: Center(child: Text('WALLET BALANCE (₹)'))),
                DataColumn(label: Center(child: Text('COINS'))),
                DataColumn(label: Center(child: Text('STATUS'))),
              ],

              /// TABLE ROWS
              rows: state.filteredRiders.map((rider) {
                return DataRow(
                  cells: [

                    /// RIDER ID
                    DataCell(
                      Center(
                        child: Text(
                          rider.id,
                          style: AppTypography.base.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    /// RIDER NAME
                    DataCell(
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiderOverviewPage(),
                              ),
                            );
                          },
                          child: Text(
                            rider.name,
                            style: AppTypography.base.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// CONTACT INFO
                    DataCell(
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              rider.phone,
                              style: AppTypography.base.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              rider.email,
                              style: AppTypography.base.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// TOTAL RIDES
                    DataCell(
                      Center(
                        child: Text(
                          rider.totalRides.toString(),
                          style: AppTypography.base.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    /// WALLET BALANCE
                    DataCell(
                      Center(
                        child: Text(
                          '₹${rider.walletBalance.toStringAsFixed(2)}',
                          style: AppTypography.base.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    /// COINS
                    DataCell(
                      Center(
                        child: Text(
                          rider.coins.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          ),
                          style: AppTypography.base.copyWith(
                            color: AppColors.cFFD97706,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    /// STATUS
                    DataCell(
                      Center(
                        child: _StatusBadge(status: rider.status),
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

      case 'Inactive':
        dotColor = AppColors.cFFD97706;
        textColor = AppColors.cFFD97706;
        break;

      case 'Suspend':
      case 'Suspended':
      case 'Banned':
        dotColor = AppColors.error;
        textColor = AppColors.error;
        break;

      default:
        dotColor = AppColors.textSecondary;
        textColor = AppColors.textSecondary;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          status,
          style: AppTypography.base.copyWith(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}