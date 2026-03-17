import 'package:admin/features/rider/presentation/widgets/adjust_wallet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class WalletCoinsTab extends StatelessWidget {
  WalletCoinsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 24, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Cards Row
          Row(
            children: [
              Expanded(
                child: _BalanceCard(
                  title: 'CURRENT WALLET BALANCE',
                  value: '₹1,240.50',
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: AppColors.cFF2F80ED,
                  iconBg: AppColors.cFFEAF2FD,
                  onAdjust: () {
                    showDialog(
                      context: context,
                      builder: (context) => AdjustWalletDialog(
                        riderName: 'Rahul Sharma',
                        currentBalance: '450',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _BalanceCard(
                  title: 'CURRENT COINS BALANCE',
                  value: '4,850',
                  icon: Icons.monetization_on_outlined,
                  iconColor: AppColors.cFFD97706,
                  iconBg: AppColors.cFFFFF7E6,
                  onAdjust: () {},
                ),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Transaction Log Header
          SizedBox(height: 24),

          // Transaction Table
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        'Transaction History',
                        style: AppTypography.h3
                      ),
                      Spacer(),

                      /// SEARCH FIELD
                      SizedBox(
                        width: 380,
                        height: 44,
                        child: TextField(
                          //controller: searchController,
                          //onChanged: (v) => context.read<DriversManagementCubit>().search(v),
                          decoration: InputDecoration(
                            hintText: 'Search transactions...',
                            hintStyle: AppTypography.base.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                            filled: true,
                            fillColor: AppColors.cFFF1F5F9,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),

                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 16),

                      /// EXPORT BUTTON
                      SizedBox(
                        height: 44, // 👈 SAME HEIGHT
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.filter_alt_outlined, size: 18),
                          label: Text('Filters'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: BorderSide(color: AppColors.divider),
                            backgroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 16),

                      /// EXPORT BUTTON
                      SizedBox(
                        height: 44, // 👈 SAME HEIGHT
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.picture_as_pdf, size: 18),
                          label: Text('Export PDF'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: BorderSide(color: AppColors.divider),
                            backgroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTableHeader(),
                Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '05 Nov 2023\n10:24 AM',
                  type: 'Ride Refund',
                  typeColor: AppColors.cFF2F80ED, // Blue
                  amount: '+ ₹120.00',
                  isPositive: true,
                  remarks: 'Refund for cancelled ride #RD-10492 by ...',
                ),
                Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '04 Nov 2023\n03:15 PM',
                  type: 'Coin Reward',
                  typeColor: AppColors.cFFF59E0B, // Amber
                  amount: '+ 500 Coins',
                  isPositive: true,
                  remarks: 'Loyalty reward for completing 50 rides.',
                  isCoins: true,
                ),
                Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '02 Nov 2023\n11:45 AM',
                  type: 'Manual Adjustment',
                  typeColor: AppColors.textPrimary, // Black/Dark
                  amount: '- ₹50.00',
                  isPositive: false,
                  remarks: 'Deduction due to double credit in previou...',
                ),
                Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '29 Oct 2023\n06:45 PM',
                  type: 'Wallet Top-up',
                  typeColor: AppColors.success, // Green
                  amount: '+ ₹1,000.00',
                  isPositive: true,
                  remarks: 'UPI Transaction #TXN_920194857',
                ),
                Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '28 Oct 2023\n06:45 PM',
                  type: 'Ride Payment',
                  typeColor: AppColors.error, // Red
                  amount: '- ₹452.00',
                  isPositive: false,
                  remarks: 'Payment for ride #RD-10294',
                ),
                Divider(height: 1, color: AppColors.divider),
                Container(
                  color: AppColors.divider.withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SHOWING 1-10 OF 42 TRANSACTIONS',
                        style: AppTypography.base.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          _buildPageButton('<', false),
                          SizedBox(width: 8),
                          _buildPageButton('1', true),
                          SizedBox(width: 8),
                          _buildPageButton('2', false),
                          SizedBox(width: 8),
                          _buildPageButton('>', false),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppColors.divider.withValues(alpha: 0.4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            _buildHeaderCell('DATE & TIME', flex: 2),
            _buildHeaderCell('TRANSACTION TYPE', flex: 3),
            _buildHeaderCell('AMOUNT', flex: 2),
            _buildHeaderCell('REMARKS', flex: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: AppTypography.base.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPageButton(String text, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.sidebar : AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        text,
        style: AppTypography.base.copyWith(
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onAdjust;

  const _BalanceCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onAdjust,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: AppTypography.base.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onAdjust,
            icon: Icon(Icons.edit, size: 16, color: AppColors.white),
            label: Text(
              'ADJUST',
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green, // Functionally green
              foregroundColor: AppColors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final String dateTime;
  final String type;
  final Color typeColor;
  final String amount;
  final bool isPositive;
  final String remarks;
  final bool isCoins;

  const _TransactionRow({
    required this.dateTime,
    required this.type,
    required this.typeColor,
    required this.amount,
    required this.isPositive,
    required this.remarks,
    this.isCoins = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              dateTime,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  type,
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              amount,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isCoins
                    ? AppColors.success
                    : (isPositive ? AppColors.success : AppColors.error),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              remarks,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
