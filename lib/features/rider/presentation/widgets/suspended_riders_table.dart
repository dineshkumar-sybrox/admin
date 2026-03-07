import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_state.dart';
import '../pages/rider_overview_page.dart';

class SuspendedRidersTable extends StatelessWidget {
  final RiderState state;

  const SuspendedRidersTable({super.key, required this.state});

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
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
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
                DataColumn(label: Text('REASON FOR SUSPEND')),
                DataColumn(label: Text('STATUS', textAlign: TextAlign.center)),
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
                      _SuspensionReasonBadge(
                        reason: rider.reasonForSuspend ?? 'UNKNOWN REASON',
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              // Perform activation logic mock
                            },
                            child: const Text(
                              'Activate',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              // Link to suspension dialog if created
                            },
                            child: const Icon(
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
  }
}

class _SuspensionReasonBadge extends StatelessWidget {
  final String reason;

  const _SuspensionReasonBadge({required this.reason});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (reason.toUpperCase()) {
      case 'FRAUD':
        bgColor = const Color(0xFFFFE4E6); // Rose-100
        textColor = const Color(0xFFE11D48); // Rose-600
        break;
      case 'PAYMENT ISSUE':
        bgColor = const Color(0xFFF1F5F9); // Slate-100
        textColor = const Color(0xFF475569); // Slate-600
        break;
      case 'SAFETY VIOLATION':
        bgColor = const Color(0xFFFFEDD5); // Orange-100
        textColor = const Color(0xFFEA580C); // Orange-600
        break;
      default:
        bgColor = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF64748B);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        reason.toUpperCase(),
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
