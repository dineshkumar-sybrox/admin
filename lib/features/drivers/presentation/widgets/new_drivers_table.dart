import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NewDriverData {
  final String id;
  final String name;
  final String vehicleType;
  final String location;
  final String status;

  const NewDriverData({
    required this.id,
    required this.name,
    required this.vehicleType,
    required this.location,
    required this.status,
  });
}

const List<NewDriverData> _mockNewDrivers = [
  NewDriverData(
    id: '#DRV-90832',
    name: 'Rahul Sharma',
    vehicleType: 'PREMIUM CAB',
    location: 'Chennai',
    status: 'Active',
  ),
  NewDriverData(
    id: '#DRV-90830',
    name: 'Priya Verma',
    vehicleType: 'AUTO',
    location: 'Madurai',
    status: 'Offline',
  ),
  NewDriverData(
    id: '#DRV-90828',
    name: 'Rohan Das',
    vehicleType: 'BIKE',
    location: 'Salem',
    status: 'Active',
  ),
  NewDriverData(
    id: '#DRV-90826',
    name: 'Sanya Malhotra',
    vehicleType: 'XL CAB',
    location: 'Trichy',
    status: 'Offline',
  ),
  NewDriverData(
    id: '#DRV-90825',
    name: 'Vikram Singh',
    vehicleType: 'CAB',
    location: 'Chennai',
    status: 'Active',
  ),
];

class NewDriversTable extends StatelessWidget {
  const NewDriversTable({super.key});

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
                DataColumn(label: Text('LOCATION')),
                DataColumn(
                  label: Text('LIFETIME\nRIDES', textAlign: TextAlign.center),
                ),
                DataColumn(label: Text('WALLET BALANCE (₹)')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: _mockNewDrivers.map((driver) {
                return DataRow(
                  cells: [
                    DataCell(Text(driver.id)),
                    DataCell(Text(driver.name)),
                    DataCell(_VehicleBadge(type: driver.vehicleType)),
                    DataCell(
                      Text(
                        driver.location,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const DataCell(
                      Text(
                        '0',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const DataCell(
                      Text(
                        '0',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    DataCell(_StatusBadge(status: driver.status)),
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
      case 'Suspended':
        dotColor = AppColors.error;
        textColor = AppColors.error;
        break;
      case 'Offline':
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
