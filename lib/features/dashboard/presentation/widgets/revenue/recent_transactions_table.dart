import 'package:flutter/material.dart';

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
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 16,
                    color: Color(0xFF6F767E),
                  ),
                  label: const Text(
                    'DOWNLOAD PDF',
                    style: TextStyle(
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
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.white),
              dataRowMaxHeight: 70,
              dataRowMinHeight: 70,
              horizontalMargin: 24,
              columnSpacing: 40,
              dividerThickness: 1,
              headingTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F767E),
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('RIDE ID')),
                DataColumn(label: Text('AMOUNT\n(₹)')),
                DataColumn(label: Text('SERVICE\nTYPE')),
                DataColumn(label: Text('PAYMENT\nMETHOD')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: [
                _buildRow(
                  id: '#RX-82710',
                  amount: '₹85.00',
                  serviceType: 'AUTO',
                  serviceColor: const Color(0xFFE8F2FF),
                  serviceTextColor: const Color(0xFF2970FF),
                  paymentMethod: 'Cash',
                  paymentIcon: Icons.money,
                  status: 'Completed',
                  isCompleted: true,
                ),
                _buildRow(
                  id: '#RX-82709',
                  amount: '₹245.50',
                  serviceType: 'AUTO',
                  serviceColor: const Color(0xFFE8F2FF),
                  serviceTextColor: const Color(0xFF2970FF),
                  paymentMethod: 'UPI',
                  paymentIcon: Icons.qr_code_2,
                  status: 'Completed',
                  isCompleted: true,
                ),
                _buildRow(
                  id: '#RX-82708',
                  amount: '₹1,420.00',
                  serviceType: 'CAB',
                  serviceColor: const Color(0xFFFFF6ED),
                  serviceTextColor: const Color(0xFFDC6803),
                  paymentMethod: 'UPI',
                  paymentIcon: Icons.qr_code_2,
                  status: 'Failed',
                  isCompleted: false,
                ),
                _buildRow(
                  id: '#RX-82707',
                  amount: '₹92.00',
                  serviceType: 'BIKE/SCOOTER',
                  serviceColor: const Color(0xFFECFDF3),
                  serviceTextColor: const Color(0xFF027A48),
                  paymentMethod: 'UPI',
                  paymentIcon: Icons.qr_code_2,
                  status: 'Completed',
                  isCompleted: true,
                ),
              ],
            ),
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
