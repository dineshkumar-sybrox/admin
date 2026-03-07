import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_state.dart';
import '../pages/rider_overview_page.dart';

class RiderTable extends StatelessWidget {
  final RiderState state;

  const RiderTable({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.filteredRiders.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No riders found',
            style: TextStyle(color: Color(0xFF8E9BAB), fontSize: 14),
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
              headingRowColor: WidgetStateProperty.all(
                const Color(0xFFF8FAFC), // Off-white typical table header
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
                DataColumn(label: Text('RIDER ID')),
                DataColumn(label: Text('RIDER NAME')),
                DataColumn(
                  label: Text(
                    'CONTACT INFORMATION',
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text('TOTAL RIDES', textAlign: TextAlign.center),
                ),
                DataColumn(
                  label: Text(
                    'WALLET BALANCE (₹)',
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(label: Text('COINS', textAlign: TextAlign.center)),
                DataColumn(label: Text('STATUS')),
              ],
              rows: state.filteredRiders.map((rider) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        rider.id,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
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
                              builder: (context) => const RiderOverviewPage(),
                            ),
                          );
                        },
                        child: Text(
                          rider.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rider.phone,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            rider.email,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          rider.totalRides.toString(),
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          '₹${rider.walletBalance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          rider.coins.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          ),
                          style: const TextStyle(
                            color: Color(0xFFD97706), // Orange equivalent
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    DataCell(_StatusBadge(status: rider.status)),
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
        dotColor = const Color(0xFFD97706); // Orange
        textColor = const Color(0xFFD97706);
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
