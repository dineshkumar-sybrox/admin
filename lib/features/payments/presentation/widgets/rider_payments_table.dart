import 'package:flutter/material.dart';

class RiderPaymentsTable extends StatefulWidget {
  const RiderPaymentsTable({super.key});

  @override
  State<RiderPaymentsTable> createState() => _RiderPaymentsTableState();
}

class _RiderPaymentsTableState extends State<RiderPaymentsTable> {
  String _selectedMethod = 'All Payment Methods';
  String _selectedStatus = 'All Status';

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
          // Filter Bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildSearchField()),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdown(
                    value: _selectedMethod,
                    items: ['All Payment Methods', 'UPI', 'Card', 'Cash'],
                    onChanged: (val) => setState(() => _selectedMethod = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdown(
                    value: _selectedStatus,
                    items: ['All Status', 'COMPLETED', 'PENDING', 'FAILED'],
                    onChanged: (val) => setState(() => _selectedStatus = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: _buildDatePicker()),
                const SizedBox(width: 12),
                _buildExportButton(),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),

          // Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.white),
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
                DataColumn(label: Text('TRANSACTION ID')),
                DataColumn(label: Text('RIDER NAME')),
                DataColumn(label: Text('DATE & TIME')),
                DataColumn(label: Text('TRIP ID')),
                DataColumn(label: Text('AMOUNT')),
                DataColumn(label: Text('METHOD')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: [
                _buildRow(
                  txId: '#TXN-88291',
                  riderName: 'Vikram Malhotra',
                  riderType: 'Regular Rider',
                  date: '24 Oct 2023,',
                  time: '08:45 PM',
                  tripId: '#TRP-44201',
                  amount: '₹842.00',
                  method: 'UPI',
                  methodIcon: Icons.account_balance_wallet_outlined,
                  status: 'COMPLETED',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
                ),
                _buildRow(
                  txId: '#TXN-88289',
                  riderName: 'Priya Singh',
                  riderType: 'Gold Member',
                  date: '24 Oct 2023,',
                  time: '08:45 PM',
                  tripId: '#TRP-44198',
                  amount: '₹1,240.00',
                  method: 'Card',
                  methodIcon: Icons.credit_card_outlined,
                  status: 'FAILED',
                  statusColor: const Color(0xFFEA3546),
                  statusBgColor: const Color(0xFFFFECEE),
                ),
                _buildRow(
                  txId: '#TXN-88285',
                  riderName: 'Arjun Verma',
                  riderType: 'New User',
                  date: '24 Oct 2023,',
                  time: '08:45 PM',
                  tripId: '#TRP-44195',
                  amount: '₹350.00',
                  method: 'Cash',
                  methodIcon: Icons.payments_outlined,
                  status: 'PROCESSING',
                  statusColor: const Color(0xFF0066FF),
                  statusBgColor: const Color(0xFFE5F0FF),
                ),
                _buildRow(
                  txId: '#TXN-88282',
                  riderName: 'Sonia Kapoor',
                  riderType: 'Frequent Rider',
                  date: '24 Oct 2023,',
                  time: '08:45 PM',
                  tripId: '#TRP-44182',
                  amount: '₹520.00',
                  method: 'UPI',
                  methodIcon: Icons.account_balance_wallet_outlined,
                  status: 'COMPLETED',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),

          // Pagination
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Showing 4 of 2,450 transactions',
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
                    _buildPaginator('4', isActive: false),
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

  Widget _buildSearchField() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF9EA5AD),
            size: 20,
          ),
          hintText: 'Search by ID or Rider...',
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFF9EA5AD),
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF6F767E),
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6F767E),
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'mm/dd/yyyy',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6F767E),
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.file_download_outlined, size: 18),
      label: const Text('Export CSV'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00A86B),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
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
    required String txId,
    required String riderName,
    required String riderType,
    required String date,
    required String time,
    required String tripId,
    required String amount,
    required String method,
    required IconData methodIcon,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            txId,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                riderName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                riderType,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF6F767E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF6F767E),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            tripId,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF00A86B), // Green distinct color for Trip ID
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(methodIcon, size: 16, color: const Color(0xFF6F767E)),
              const SizedBox(width: 8),
              Text(
                method,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
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
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
