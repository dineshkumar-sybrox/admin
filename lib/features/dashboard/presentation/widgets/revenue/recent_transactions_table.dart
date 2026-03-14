import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/dashboard_cubit.dart';
import '../../cubit/dashboard_state.dart';

class RecentTransactionsTable extends StatelessWidget {
  const RecentTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF0F1F3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1D1F),
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
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF6F767E),
                              ),
                            )
                          : const Icon(
                              Icons.download_rounded,
                              size: 16,
                              color: Color(0xFF6F767E),
                            ),
                      label: Text(
                        state.isExportingReport
                            ? 'EXPORTING...'
                            : 'EXPORT EXCEL',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6F767E),
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
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
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
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
                          const Color.fromARGB(255, 248, 248, 248),
                        ),
                        headingTextStyle: const TextStyle(
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
                              serviceColor = const Color(0xFFFFF6ED);
                              serviceTextColor = const Color(0xFFDC6803);
                              break;
                            case 'AUTO':
                              serviceColor = const Color(0xFFE8F2FF);
                              serviceTextColor = const Color(0xFF2970FF);
                              break;
                            case 'BIKE/SCOOTER':
                            default:
                              serviceColor = const Color(0xFFECFDF3);
                              serviceTextColor = const Color(0xFF027A48);
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
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LOAD OLDER HISTORY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F767E),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: Color(0xFF6F767E),
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
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: serviceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              serviceType,
              style: TextStyle(
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
              Icon(paymentIcon, size: 16, color: const Color(0xFF9EA5AD)),
              const SizedBox(width: 8),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
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
                      ? const Color(0xFF00A86B)
                      : const Color(0xFFFF4757),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: isCompleted
                      ? const Color(0xFF00A86B)
                      : const Color(0xFFFF4757),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
