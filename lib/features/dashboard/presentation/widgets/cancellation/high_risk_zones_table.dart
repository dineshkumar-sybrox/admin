import 'package:admin/features/dashboard/presentation/pages/cancellation_zone_details_screen.dart';
import 'package:flutter/material.dart';

class HighRiskZonesTable extends StatelessWidget {
  const HighRiskZonesTable({super.key});

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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High-Risk Cancellation Zones',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1D1F),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Areas with highest frequency of canceled rides',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9EA5AD),
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Color(0xFFEFEFEF)),
                  ),
                  child: const Text(
                    'Export Report',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                const Color(0xFFF4F6F9).withValues(alpha: 0.5),
              ),
              dataRowMaxHeight: 80,
              dataRowMinHeight: 80,
              horizontalMargin: 24,
              columnSpacing: 40,
              dividerThickness: 1,
              headingTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F767E),
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('AREA NAME')),
                DataColumn(label: Text('REQUESTS')),
                DataColumn(label: Text('CANCELLATIONS')),
                DataColumn(label: Text('RATE')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: [
                _buildRow(
                  areaName: 'Anna Nagar, Chennai',
                  areaDesc: 'Primary Transit Hub',
                  requests: '12,400',
                  cancellations: '1,116',
                  rate: '9.0%',
                  rateBgColor: const Color(0xFFFFECEE),
                  rateTextColor: const Color(0xFFEA3546),
                  status: 'Critical High',
                  statusColor: const Color(0xFFEA3546),
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CancellationZoneDetailsScreen(
                              zoneName: 'Anna Nagar',
                            ),
                      ),
                    );
                  },
                ),
                _buildRow(
                  areaName: 'Adyar, Chennai',
                  areaDesc: 'Residential Area',
                  requests: '8,200',
                  cancellations: '508',
                  rate: '6.2%',
                  rateBgColor: const Color(0xFFFFF7DB),
                  rateTextColor: const Color(0xFFD4A000),
                  status: 'Elevated',
                  statusColor: const Color(0xFFD4A000),
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CancellationZoneDetailsScreen(
                              zoneName: 'Adyar',
                            ),
                      ),
                    );
                  },
                ),
                _buildRow(
                  areaName: 'Velachery, Chennai',
                  areaDesc: 'IT Park Corridor',
                  requests: '15,600',
                  cancellations: '702',
                  rate: '4.5%',
                  rateBgColor: const Color(0xFFE8FDF2),
                  rateTextColor: const Color(0xFF00C46B),
                  status: 'Normal',
                  statusColor: const Color(0xFF00C46B),
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CancellationZoneDetailsScreen(
                              zoneName: 'Velachery',
                            ),
                      ),
                    );
                  },
                ),
                _buildRow(
                  areaName: 'T-Nagar, Chennai',
                  areaDesc: 'Commercial Zone',
                  requests: '10,100',
                  cancellations: '858',
                  rate: '8.5%',
                  rateBgColor: const Color(0xFFFFECEE),
                  rateTextColor: const Color(0xFFEA3546),
                  status: 'High Risk',
                  statusColor: const Color(0xFFEA3546),
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CancellationZoneDetailsScreen(
                              zoneName: 'T-Nagar',
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Showing 4 of 28 zones',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6F767E),
                  ),
                ),
                Row(
                  children: [
                    _buildPaginator('<', isActive: false),
                    const SizedBox(width: 8),
                    _buildPaginator('1', isActive: true),
                    const SizedBox(width: 8),
                    _buildPaginator('2', isActive: false),
                    const SizedBox(width: 8),
                    _buildPaginator('3', isActive: false),
                    const SizedBox(width: 8),
                    _buildPaginator('>', isActive: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginator(String text, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00A86B) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: isActive ? null : Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : const Color(0xFF1A1D1F),
          ),
        ),
      ),
    );
  }

  DataRow _buildRow({
    required String areaName,
    required String areaDesc,
    required String requests,
    required String cancellations,
    required String rate,
    required Color rateBgColor,
    required Color rateTextColor,
    required String status,
    required Color statusColor,
    required VoidCallback onViewDetails,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                areaName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                areaDesc,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Color(0xFF6F767E),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            requests,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Text(
            cancellations,
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
              color: rateBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              rate,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: rateTextColor,
              ),
            ),
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
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          TextButton(
            onPressed: onViewDetails,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'View Details',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFF00C46B), // Brighter green for actions
              ),
            ),
          ),
        ),
      ],
    );
  }
}
