import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActiveDriverData {
  final String id;
  final String name;
  final String vehicleType;
  final String location;
  final String completeRides;
  final String onlineDuration;
  final String acceptanceRate;
  final String acceptanceTrend;

  const ActiveDriverData({
    required this.id,
    required this.name,
    required this.vehicleType,
    required this.location,
    required this.completeRides,
    required this.onlineDuration,
    required this.acceptanceRate,
    this.acceptanceTrend = 'up',
  });
}

const List<ActiveDriverData> _mockActiveDrivers = [
  ActiveDriverData(
    id: '#DRV-90832',
    name: 'Rahul Sharma',
    vehicleType: 'PREMIUM CAB',
    location: 'Chennai',
    completeRides: '12',
    onlineDuration: '4h 22m',
    acceptanceRate: '98%',
    acceptanceTrend: 'up',
  ),
  ActiveDriverData(
    id: '#DRV-90830',
    name: 'Priya Verma',
    vehicleType: 'AUTO',
    location: 'Madurai',
    completeRides: '06',
    onlineDuration: '2h 22m',
    acceptanceRate: '96%',
    acceptanceTrend: 'up',
  ),
  ActiveDriverData(
    id: '#DRV-90828',
    name: 'Rohan Das',
    vehicleType: 'BIKE',
    location: 'Salem',
    completeRides: '09',
    onlineDuration: '3h 22m',
    acceptanceRate: '86%',
    acceptanceTrend: 'up',
  ),
  ActiveDriverData(
    id: '#DRV-90826',
    name: 'Sanya Malhotra',
    vehicleType: 'XL CAB',
    location: 'Trichy',
    completeRides: '14',
    onlineDuration: '4h 22m',
    acceptanceRate: '70%',
    acceptanceTrend: 'down',
  ),
  ActiveDriverData(
    id: '#DRV-90825',
    name: 'Vikram Singh',
    vehicleType: 'CAB',
    location: 'Chennai',
    completeRides: '16',
    onlineDuration: '5h 22m',
    acceptanceRate: '92%',
    acceptanceTrend: 'up',
  ),
];

class ActiveDriversTable extends StatelessWidget {
  const ActiveDriversTable({super.key});

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
                  label: Text('CURRENT\nLOCATION', textAlign: TextAlign.center),
                ),
                DataColumn(
                  label: Text('COMPLETE\nRIDES', textAlign: TextAlign.center),
                ),
                DataColumn(label: Text('ONLINE DURATION')),
                DataColumn(
                  label: Text('ACCEPTANCE\nRATE', textAlign: TextAlign.center),
                ),
              ],
              rows: _mockActiveDrivers.map((driver) {
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
                    DataCell(
                      Text(
                        driver.completeRides,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataCell(
                      Text(
                        driver.onlineDuration,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        driver.acceptanceRate,
                        style: TextStyle(
                          color: driver.acceptanceTrend == 'up'
                              ? AppColors.primary
                              : AppColors.warning,
                          fontWeight: FontWeight.bold,
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
