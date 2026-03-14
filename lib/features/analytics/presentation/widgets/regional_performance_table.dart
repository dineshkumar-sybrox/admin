import 'package:flutter/material.dart';

class RegionalPerformanceTable extends StatelessWidget {
  const RegionalPerformanceTable({super.key});

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
                      'Regional Performance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1D1F),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Top performing cities by efficiency',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9EA5AD),
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 16,
                    color: Color(0xFF1A1D1F),
                  ),
                  label: const Text(
                    'Export Report',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
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
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor: WidgetStateProperty.all(Colors.white),
              dataRowMaxHeight: 80,
              dataRowMinHeight: 80,
              horizontalMargin: 24,
              columnSpacing: 64,
              dividerThickness: 1,
              headingTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F767E),
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('CITY / ZONE')),
                DataColumn(label: Text('DAILY REQUESTS')),
                DataColumn(label: Text('AVG. WAIT TIME')),
                DataColumn(label: Text('COMPLETION')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: [
                _buildRow(
                  city: 'Mumbai South',
                  zoneDesc: 'Commercial Zone',
                  requests: '42,500',
                  waitTime: '3.2m',
                  completionValue: '98.2%',
                  completionProgress: 0.98,
                  completionColor: const Color(0xFF00C46B),
                  status: 'STEADY TREND',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
                ),
                _buildRow(
                  city: 'Delhi NCR',
                  zoneDesc: 'Primary Hub',
                  requests: '38,100',
                  waitTime: '5.8m',
                  completionValue: '84.5%',
                  completionProgress: 0.84,
                  completionColor: const Color(0xFFFFD12E),
                  status: 'MODERATE SURGE',
                  statusColor: const Color(
                    0xFFD4A000,
                  ), // Darker yellow for text visibility
                  statusBgColor: const Color(0xFFFFFBE8),
                ),
                _buildRow(
                  city: 'Bangalore East',
                  zoneDesc: 'IT Corridor',
                  requests: '28,900',
                  waitTime: '4.1m',
                  completionValue: '92.0%',
                  completionProgress: 0.92,
                  completionColor: const Color(0xFF00C46B),
                  status: 'NORMAL',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
                ),
                _buildRow(
                  city: 'Chennai Central',
                  zoneDesc: 'Residential Area',
                  requests: '12,400',
                  waitTime: '8.2m',
                  completionValue: '68.2%',
                  completionProgress: 0.68,
                  completionColor: const Color(0xFFEA3546),
                  status: 'HIGH DEMAND',
                  statusColor: const Color(0xFFEA3546),
                  statusBgColor: const Color(0xFFFFECEE),
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
    required String city,
    required String zoneDesc,
    required String requests,
    required String waitTime,
    required String completionValue,
    required double completionProgress,
    required Color completionColor,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                city,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                zoneDesc,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Color(0xFF9EA5AD),
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
            waitTime,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  completionValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Color(0xFF1A1D1F),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 60,
                height: 4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6F9),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: completionProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: completionColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
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
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 8,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {},
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
                color: Color(0xFF00C46B),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
