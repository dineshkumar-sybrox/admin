import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Transaction history',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.divider),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'View All Rides',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.7 > 800
                      ? 800
                      : MediaQuery.of(context).size.width * 0.7,
                ),
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: 24,
                  headingTextStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                  columns: const [
                    DataColumn(label: Text('TRANSACTION DATE')),
                    DataColumn(label: Text('ROUTE DETAIL')),
                    DataColumn(label: Text('CATEGORY')),
                    DataColumn(label: Text('PAYMENT')),
                    DataColumn(label: Text('AMOUNT')),
                  ],
                  rows: [
                    _buildTransactionRow(
                      date: 'Feb 15, 2026',
                      time: '06:42 PM',
                      route: 'Vadapalani Bus-Stand →VR Mall...',
                      category: 'CAB',
                      paymentMethod: 'G-Pay',
                      amount: '₹452.00',
                      textColor: AppColors.textPrimary,
                      badgeColor: const Color(0xFFE8F0FE), // Light blue
                      badgeTextColor: const Color(0xFF1967D2), // Dark blue
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    _buildTransactionRow(
                      date: 'Feb 10, 2026',
                      time: '09:15 AM',
                      route: 'Vadapalani Bus-Stand →VR Mall...',
                      category: 'BIKE/SCOOTER',
                      paymentMethod: 'Wallet Credits',
                      amount: '₹1,180.00',
                      textColor: AppColors.textPrimary,
                      badgeColor: const Color(0xFFFEF3C7), // Light amber
                      badgeTextColor: const Color(0xFFD97706), // Dark amber
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    _buildTransactionRow(
                      date: 'Feb 02, 2026',
                      time: '11:30 PM',
                      route: 'Vadapalani Bus-Stand →VR Mall...',
                      category: 'AUTO',
                      paymentMethod: 'G-Pay',
                      amount: '₹624.50',
                      textColor: AppColors.textPrimary,
                      badgeColor: const Color(0xFFD1FAE5), // Light emerald
                      badgeTextColor: const Color(0xFF047857), // Dark emerald
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildTransactionRow({
    required String date,
    required String time,
    required String route,
    required String category,
    required String paymentMethod,
    required String amount,
    required Color textColor,
    required Color badgeColor,
    required Color badgeTextColor,
    required IconData icon,
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
          Text(
            route,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: badgeTextColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
