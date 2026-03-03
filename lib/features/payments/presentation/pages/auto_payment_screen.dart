import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../widgets/payment_stat_cards.dart';
import 'cab_payment_screen.dart';
import 'bike_payment_screen.dart';

class AutoPaymentScreen extends StatefulWidget {
  const AutoPaymentScreen({super.key});

  @override
  State<AutoPaymentScreen> createState() => _AutoPaymentScreenState();
}

class _AutoPaymentScreenState extends State<AutoPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Payment Management - Auto',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaymentStatCards(
              selectedIndex: 3,
              onCardTapped: (index) {
                if (index == 0) {
                  Navigator.pop(context); // Go back to total payments
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CabPaymentScreen(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BikePaymentScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF0F1F3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildFilterBar(),
                  const Divider(height: 1, color: Color(0xFFF0F1F3)),
                  _buildDataTable(),
                  const Divider(height: 1, color: Color(0xFFF0F1F3)),
                  _buildPagination(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildTextField('Search by ID or Rider...', Icons.search),
          ),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('All Payment Methods')),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('All Status')),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildTextField('mm/dd/yyyy', null)),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A86B), // Green
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text(
              'Export CSV',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, IconData? icon) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF9EA5AD),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF9EA5AD), size: 18)
            : null,
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ), // Adjust for height
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF6F767E),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF6F767E),
            size: 20,
          ),
          items: const [],
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 48,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            const Color(0xFFF4F6F9).withValues(alpha: 0.5),
          ),
          dataRowMaxHeight: 80,
          dataRowMinHeight: 80,
          horizontalMargin: 24,
          columnSpacing: 24,
          dividerThickness: 1,
          headingTextStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6F767E),
            letterSpacing: 0.5,
          ),
          columns: const [
            DataColumn(label: Text('TRANSACTION ID')),
            DataColumn(label: Text('RIDER NAME')),
            DataColumn(label: Text('DRIVER NAME')),
            DataColumn(label: Text('DATE & TIME')),
            DataColumn(label: Text('TRIP ID')),
            DataColumn(label: Text('AMOUNT')),
            DataColumn(label: Text('PAYMENT\nMETHOD')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('ACTION')),
          ],
          rows: [
            _buildDataRow(
              id: '#TXN-88291',
              riderName: 'Vikram\nMalhotra',
              driverName: 'Sam\nYogi',
              dateAndTime: '24 Feb 2026,\n08:45 PM',
              tripId: '#TRP-44201',
              amount: '₹842.00',
              paymentMethod: 'UPI',
              paymentIcon: Icons.account_balance_wallet_outlined,
              status: 'COMPLETED',
              statusColor: const Color(0xFF2E5BFF),
              statusBgColor: const Color(0xFFEAF0FF),
            ),
            _buildDataRow(
              id: '#TXN-88289',
              riderName: 'Priya\nSingh',
              driverName: 'Pream\nSingh',
              dateAndTime: '24 Feb 2026,\n08:45 PM',
              tripId: '#TRP-44201',
              amount: '₹842.00',
              paymentMethod: 'Cash',
              paymentIcon: Icons.payments_outlined,
              status: 'COMPLETED',
              statusColor: const Color(0xFF00A86B),
              statusBgColor: const Color(0xFFE8FDF2),
            ),
            _buildDataRow(
              id: '#TXN-88285',
              riderName: 'Arjun\nVerma',
              driverName: 'Arun\nVerma',
              dateAndTime: '24 Feb 2026,\n08:45 PM',
              tripId: '#TRP-44201',
              amount: '₹842.00',
              paymentMethod: 'UPI',
              paymentIcon: Icons.account_balance_wallet_outlined,
              status: 'COMPLETED',
              statusColor: const Color(0xFFEA3546),
              statusBgColor: const Color(0xFFFFECEE),
            ),
            _buildDataRow(
              id: '#TXN-88282',
              riderName: 'Sonia\nKapoor',
              driverName: 'Sai\nKapoor',
              dateAndTime: '24 Feb 2026,\n08:45 PM',
              tripId: '#TRP-44201',
              amount: '₹842.00',
              paymentMethod: 'UPI',
              paymentIcon: Icons.account_balance_wallet_outlined,
              status: 'COMPLETED',
              statusColor: const Color(0xFF00A86B),
              statusBgColor: const Color(0xFFE8FDF2),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required String id,
    required String riderName,
    required String driverName,
    required String dateAndTime,
    required String tripId,
    required String amount,
    required String paymentMethod,
    required IconData paymentIcon,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
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
            riderName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Text(
            driverName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Text(
            dateAndTime,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF6F767E),
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Text(
            tripId,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF00A86B),
            ),
          ),
        ),
        DataCell(
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Icon(paymentIcon, size: 16, color: const Color(0xFF6F767E)),
              const SizedBox(width: 6),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF6F767E),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    fontSize: 9,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.visibility_outlined,
              color: Color(0xFF9EA5AD),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 4 of 2,450 transactions',
            style: TextStyle(
              fontSize: 13,
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
              _buildPaginator('4', isActive: false),
              const SizedBox(width: 8),
              _buildPaginator('>', isActive: false),
            ],
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
}
