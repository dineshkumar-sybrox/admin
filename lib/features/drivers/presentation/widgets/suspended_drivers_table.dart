import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'suspension_details_dialog.dart';

class SuspendedDriverData {
  final String id;
  final String name;
  final String vehicleType;
  final String suspensionReason;
  final String suspensionSubreason;
  final String suspensionDate;
  final String appealStatus;

  const SuspendedDriverData({
    required this.id,
    required this.name,
    required this.vehicleType,
    required this.suspensionReason,
    required this.suspensionSubreason,
    required this.suspensionDate,
    required this.appealStatus,
  });
}

const List<SuspendedDriverData> _mockSuspendedDrivers = [
  SuspendedDriverData(
    id: '#DRV-90832',
    name: 'Rahul Sharma',
    vehicleType: 'PREMIUM CAB',
    suspensionReason: 'Policy Violation',
    suspensionSubreason: 'unsafe driving reports',
    suspensionDate: '15 Feb, 2026',
    appealStatus: 'PENDING REVIEW',
  ),
  SuspendedDriverData(
    id: '#DRV-90830',
    name: 'Priya Verma',
    vehicleType: 'AUTO',
    suspensionReason: 'Fraud',
    suspensionSubreason: 'Suspicious ride patterns',
    suspensionDate: '12 Feb, 2026',
    appealStatus: 'REJECTED',
  ),
  SuspendedDriverData(
    id: '#DRV-90828',
    name: 'Rohan Das',
    vehicleType: 'BIKE',
    suspensionReason: 'Policy Violation',
    suspensionSubreason: 'unsafe driving reports',
    suspensionDate: '08 Feb, 2026',
    appealStatus: 'PENDING REVIEW',
  ),
  SuspendedDriverData(
    id: '#DRV-90826',
    name: 'Sanya Malhotra',
    vehicleType: 'XL CAB',
    suspensionReason: 'Policy Violation',
    suspensionSubreason: 'unsafe driving reports',
    suspensionDate: '05 Feb, 2026',
    appealStatus: 'PENDING REVIEW',
  ),
  SuspendedDriverData(
    id: '#DRV-90825',
    name: 'Vikram Singh',
    vehicleType: 'CAB',
    suspensionReason: 'Policy Violation',
    suspensionSubreason: 'unsafe driving reports',
    suspensionDate: '01 Feb, 2026',
    appealStatus: 'REJECTED',
  ),
];

class SuspendedDriversTable extends StatelessWidget {
  const SuspendedDriversTable({super.key});

  @override
  Widget build(BuildContext context) {
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
                DataColumn(
                  label: Text(
                    'SUSPENSION\nREASON',
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(
                  label: Text('SUSPENSION\nDATE', textAlign: TextAlign.center),
                ),
                DataColumn(label: Text('APPEAL STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: _mockSuspendedDrivers.map((driver) {
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
                            driver.suspensionReason,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            driver.suspensionSubreason,
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
                      Text(
                        driver.suspensionDate,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    DataCell(_AppealStatusBadge(status: driver.appealStatus)),
                    DataCell(
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) =>
                                const SuspensionDetailsDialog(),
                          );
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
                              const Text(
                                'Activate',
                                style: TextStyle(
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

class _AppealStatusBadge extends StatelessWidget {
  final String status;

  const _AppealStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (status == 'PENDING REVIEW') {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFD97706);
    } else if (status == 'REJECTED') {
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFFDC2626);
    } else {
      bgColor = const Color(0xFFF3F4F6);
      textColor = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
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
