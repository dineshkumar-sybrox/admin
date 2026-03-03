import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class WalletCoinsTab extends StatelessWidget {
  const WalletCoinsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24, bottom: 48),
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
                  iconColor: const Color(0xFF2F80ED),
                  iconBg: const Color(0xFFEAF2FD),
                  onAdjust: () {},
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _BalanceCard(
                  title: 'CURRENT COINS BALANCE',
                  value: '4,850',
                  icon: Icons.monetization_on_outlined,
                  iconColor: const Color(0xFFD97706),
                  iconBg: const Color(0xFFFFF7E6),
                  onAdjust: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Transaction Log Header
          Row(
            children: [
              const Text(
                'Transaction Log',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search transactions...',
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.divider),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Export'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.divider),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Transaction Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                const Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '05 Nov 2023\n10:24 AM',
                  type: 'Ride Refund',
                  typeColor: const Color(0xFF2F80ED), // Blue
                  amount: '+ ₹120.00',
                  isPositive: true,
                  remarks: 'Refund for cancelled ride #RD-10492 by ...',
                ),
                const Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '04 Nov 2023\n03:15 PM',
                  type: 'Coin Reward',
                  typeColor: const Color(0xFFF59E0B), // Amber
                  amount: '+ 500 Coins',
                  isPositive: true,
                  remarks: 'Loyalty reward for completing 50 rides.',
                  isCoins: true,
                ),
                const Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '02 Nov 2023\n11:45 AM',
                  type: 'Manual Adjustment',
                  typeColor: AppColors.textPrimary, // Black/Dark
                  amount: '- ₹50.00',
                  isPositive: false,
                  remarks: 'Deduction due to double credit in previou...',
                ),
                const Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '29 Oct 2023\n06:45 PM',
                  type: 'Wallet Top-up',
                  typeColor: AppColors.success, // Green
                  amount: '+ ₹1,000.00',
                  isPositive: true,
                  remarks: 'UPI Transaction #TXN_920194857',
                ),
                const Divider(height: 1, color: AppColors.divider),
                _TransactionRow(
                  dateTime: '28 Oct 2023\n06:45 PM',
                  type: 'Ride Payment',
                  typeColor: AppColors.error, // Red
                  amount: '- ₹452.00',
                  isPositive: false,
                  remarks: 'Payment for ride #RD-10294',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SHOWING 1-10 OF 42 TRANSACTIONS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                children: [
                  _buildPageButton('<', false),
                  const SizedBox(width: 8),
                  _buildPageButton('1', true),
                  const SizedBox(width: 8),
                  _buildPageButton('2', false),
                  const SizedBox(width: 8),
                  _buildPageButton('>', false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _buildHeaderCell('DATE & TIME', flex: 2),
          _buildHeaderCell('TRANSACTION TYPE', flex: 3),
          _buildHeaderCell('AMOUNT', flex: 2),
          _buildHeaderCell('REMARKS', flex: 4),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 11,
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
        color: isActive ? AppColors.sidebar : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : AppColors.textPrimary,
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
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
            icon: const Icon(Icons.edit, size: 16, color: Colors.white),
            label: const Text(
              'ADJUST',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success, // Functionally green
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              dateTime,
              style: const TextStyle(
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
                const SizedBox(width: 12),
                Text(
                  type,
                  style: const TextStyle(
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
              style: TextStyle(
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
              style: const TextStyle(
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
