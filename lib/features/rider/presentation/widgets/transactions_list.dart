import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class TransactionsList extends StatefulWidget {
  TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  String _selectedFilter = 'ALL VEHICLE';

  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transactions',
                      style: AppTypography.base.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Transaction history',
                      style: AppTypography.base.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.cFFEFEFEF),
                      ),
                      child: PopupMenuButton<String>(
                        offset: Offset(0, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.cFFEFEFEF),
                        ),
                        color: AppColors.white,
                        elevation: 6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedFilter,
                              style: AppTypography.base.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.cFF1A1D1F,
                              ),
                            ),
                            SizedBox(width: 32),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: AppColors.cFF6F767E,
                            ),
                          ],
                        ),
                        onSelected: (val) {
                          setState(() {
                            _selectedFilter = val;
                          });
                        },
                        itemBuilder: (context) => [
                          _buildPopupItem('CAB', _selectedFilter == 'CAB'),
                          _buildPopupItem(
                            'BIKE/SCOOTER',
                            _selectedFilter == 'BIKE/SCOOTER',
                          ),
                          _buildPopupItem('AUTO', _selectedFilter == 'AUTO'),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.divider),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'View All Rides',
                        style: AppTypography.base.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
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

                      headingRowHeight: 60,

                      dataRowMinHeight: 60,
                      dataRowMaxHeight: 60,
                      headingRowColor: MaterialStateProperty.all(
                        AppColors.cFFF8F8F8,
                      ),
                      headingTextStyle: AppTypography.base.copyWith(
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
                          badgeColor: AppColors.cFFE8F0FE, // Light blue
                          badgeTextColor: AppColors.cFF1967D2, // Dark blue
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
                          badgeColor: AppColors.cFFFEF3C7, // Light amber
                          badgeTextColor: AppColors.cFFD97706, // Dark amber
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
                          badgeColor: AppColors.cFFD1FAE5, // Light emerald
                          badgeTextColor: Color(
                            0xFF047857,
                          ), // Dark emerald
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? AppColors.cFFF4FDF8 : AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.cFF00A86B,
                size: 18,
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
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                time,
                style: AppTypography.base.copyWith(
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
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: AppTypography.base.copyWith(
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
              SizedBox(width: 8),
              Text(
                paymentMethod,
                style: AppTypography.base.copyWith(
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
            style: AppTypography.base.copyWith(
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





