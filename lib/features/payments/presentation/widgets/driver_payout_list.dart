import 'package:flutter/material.dart';

class DriverPayoutList extends StatefulWidget {
  const DriverPayoutList({super.key});

  @override
  State<DriverPayoutList> createState() => _DriverPayoutListState();
}

class _DriverPayoutListState extends State<DriverPayoutList> {
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
          const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Driver Payout List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1D1F),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Settlements for drivers',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9EA5AD),
                  ),
                ),
              ],
            ),
          ),
          _buildFilterBar(),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.white),
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
                DataColumn(label: Text('REQUEST ID')),
                DataColumn(label: Text('VEHICLE TYPE')),
                DataColumn(label: Text('DATE & TIME')),
                DataColumn(label: Text('DRIVER NAME')),
                DataColumn(label: Text('AMOUNT')),
                DataColumn(label: Text('PAYMENT\nTRANSFER')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: [
                _buildRow(
                  id: '#PAY-99210',
                  vehicleType: 'CAB',
                  vehicleColor: const Color(0xFFFFA629),
                  vehicleBgColor: const Color(0xFFFFF7DB),
                  dateAndTime: '24 Feb 2026,\n08:45 PM',
                  driverName: 'Rahul Jaiswal',
                  driverDesc: 'Driver',
                  amount: '₹24,500.00',
                  paymentTransfer: 'UPI',
                  paymentIcon: Icons.account_balance_wallet_outlined,
                  status: 'SUCCESSFUL',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
                ),
                _buildRow(
                  id: '#PAY-99210',
                  vehicleType: 'BIKE/SCOOTER',
                  vehicleColor: const Color(0xFF00A86B),
                  vehicleBgColor: const Color(0xFFE8FDF2),
                  dateAndTime: '24 Feb 2026,\n08:45 PM',
                  driverName: 'Sam Yogi',
                  driverDesc: 'Driver',
                  amount: '₹24,500.00',
                  paymentTransfer: 'Bank',
                  paymentIcon: Icons.account_balance_outlined,
                  status: 'PENDING',
                  statusColor: const Color(0xFFD4A000),
                  statusBgColor: const Color(0xFFFFF7DB),
                ),
                _buildRow(
                  id: '#PAY-99210',
                  vehicleType: 'CAB',
                  vehicleColor: const Color(0xFFFFA629),
                  vehicleBgColor: const Color(0xFFFFF7DB),
                  dateAndTime: '24 Feb 2026,\n08:45 PM',
                  driverName: 'Rahul Singh',
                  driverDesc: 'Driver',
                  amount: '₹24,500.00',
                  paymentTransfer: 'Bank',
                  paymentIcon: Icons.account_balance_outlined,
                  status: 'REJECTED',
                  statusColor: const Color(0xFFEA3546),
                  statusBgColor: const Color(0xFFFFECEE),
                ),
                _buildRow(
                  id: '#PAY-99210',
                  vehicleType: 'AUTO',
                  vehicleColor: const Color(0xFF2E5BFF),
                  vehicleBgColor: const Color(0xFFEAF0FF),
                  dateAndTime: '24 Feb 2026,\n08:45 PM',
                  driverName: 'Aruk Kumar',
                  driverDesc: 'Driver',
                  amount: '₹24,500.00',
                  paymentTransfer: 'UPI',
                  paymentIcon: Icons.account_balance_wallet_outlined,
                  status: 'SUCCESSFUL',
                  statusColor: const Color(0xFF00C46B),
                  statusBgColor: const Color(0xFFE8Fdf2),
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
                  'Showing 4 of 12 payout requests',
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

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildDropdown('Payment Methods')),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('All Status')),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildTextField('mm/dd/yyyy', null)),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('Vehicle')),
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
        fillColor: Colors.white,
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
        color: Colors.white,
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
    required String id,
    required String vehicleType,
    required Color vehicleColor,
    required Color vehicleBgColor,
    required String dateAndTime,
    required String driverName,
    required String driverDesc,
    required String amount,
    required String paymentTransfer,
    required IconData paymentIcon,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return DataRow(
      onSelectChanged: (_) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         DriverPayoutDetailsScreen(driverName: driverName),
        //   ),
        // );
      },
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: vehicleBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vehicleType,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: vehicleColor,
              ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                driverName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                driverDesc,
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
                paymentTransfer,
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
}
