import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CancellationLogTable extends StatelessWidget {
  const CancellationLogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'DETAILED CANCELLATION LOG',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(LAST 10)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Page 1 of 1',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth, // 👈 important
                  ),
                  child: DataTable(
                    columnSpacing: 40,
                    horizontalMargin: 16,
                    dividerThickness: 1,
                    headingRowHeight: 60,

                    dataRowMinHeight: 60,
                    dataRowMaxHeight: 60,
                    headingRowColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 248, 248, 248),
                    ),
                    headingTextStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                    columns: const [
                      DataColumn(label: Text('INCIDENT DATE/TIME')),
                      DataColumn(label: Text('CANCELLED BY')),
                      DataColumn(label: Text('CANCELLATION REASON')),
                    ],
                    rows: [
                      _buildLogRow(
                        date: 'Feb 15, 2026',
                        time: '10:00 AM',
                        cancelledBy: 'Driver',
                        dotColor: AppColors.error,
                        reason: '"Wrong Address shown."',
                      ),
                      _buildLogRow(
                        date: 'Feb 12, 2026',
                        time: '08:55 AM',
                        cancelledBy: 'Customer',
                        dotColor: AppColors.error,
                        reason:
                            '"I was 2 mins away, Customer\ncancelled before I arrived."',
                      ),
                      _buildLogRow(
                        date: 'Feb 02, 2026',
                        time: '07:42 PM',
                        cancelledBy: 'Customer',
                        dotColor: AppColors.error,
                        reason:
                            '"I was 2 mins away, user\ncancelled before I arrived."',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'LOAD OLDER HISTORY',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildLogRow({
    required String date,
    required String time,
    required String cancelledBy,
    required Color dotColor,
    required String reason,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                cancelledBy,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              reason,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
