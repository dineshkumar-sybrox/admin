import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../widgets/cancellation/cancellation_stat_cards.dart';

class RiderCancellationScreen extends StatefulWidget {
  const RiderCancellationScreen({super.key});

  @override
  State<RiderCancellationScreen> createState() =>
      _RiderCancellationScreenState();
}

class _RiderCancellationScreenState extends State<RiderCancellationScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Cancellation - Rider',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CancellationStatCards(
              selectedIndex: 1,
              onCardTapped: (index) {
                if (index == 0) {
                  Navigator.pop(context); // Go back to total cancellation
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
          Expanded(flex: 1, child: _buildDropdown('Reason for cancellation')),
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
            DataColumn(label: Text('VEHICLE')),
            DataColumn(label: Text('REASON FOR CANCELLATION')),
            DataColumn(label: Text('PICKUP-DROP\nLOCATION')),
            DataColumn(label: Text('DISTANCE')),
            DataColumn(label: Text('TIME &\nDATE')),
            DataColumn(label: Text('PENALTY(₹)')),
          ],
          rows: [
            _buildDataRow(
              id: '#TXN-88291',
              name: 'Vikram\nMalhotra',
              vehicle: 'CAB',
              vehicleColor: const Color(0xFFFFA629),
              vehicleBgColor: const Color(0xFFFFF7DB),
              reason: 'Long Wait Time',
              reasonColor: const Color(0xFFEA3546),
              reasonBgColor: const Color(0xFFFFECEE),
              location: 'Besant Naga -\nGuindy Tech Park',
              distance: '8.2km',
              timeDate: '08:45 PM\n24 Feb 2026',
              penalty: '₹0.00',
            ),
            _buildDataRow(
              id: '#TXN-88290',
              name: 'Rahul\nMalhotra',
              vehicle: 'AUTO',
              vehicleColor: const Color(0xFF2E5BFF),
              vehicleBgColor: const Color(0xFFEAF0FF),
              reason: 'Wrong pickup location',
              reasonColor: const Color(0xFFD4A000),
              reasonBgColor: const Color(0xFFFFF7DB),
              location: 'Besant Naga -\nGuindy Tech Park',
              distance: '8.2km',
              timeDate: '08:45 PM\n24 Feb 2026',
              penalty: '₹0.00',
            ),
            _buildDataRow(
              id: '#TXN-88289',
              name: 'Arun\nMalhotra',
              vehicle: 'BIKE/SCOOTER',
              vehicleColor: const Color(0xFF00A86B),
              vehicleBgColor: const Color(0xFFE8FDF2),
              reason: 'Driver too far away',
              reasonColor: const Color(0xFF6F767E),
              reasonBgColor: const Color(0xFFF4F6F9),
              location: 'Besant Naga -\nGuindy Tech Park',
              distance: '8.2km',
              timeDate: '08:45 PM\n24 Feb 2026',
              penalty: '₹0.00',
            ),
            _buildDataRow(
              id: '#TXN-88288',
              name: 'Mani\nMalhotra',
              vehicle: 'CAB',
              vehicleColor: const Color(0xFFFFA629),
              vehicleBgColor: const Color(0xFFFFF7DB),
              reason: 'The price is not reasonable',
              reasonColor: const Color(0xFF2E5BFF),
              reasonBgColor: const Color(0xFFEAF0FF),
              location: 'Besant Naga -\nGuindy Tech Park',
              distance: '8.2km',
              timeDate: '08:45 PM\n24 Feb 2026',
              penalty: '₹0.00',
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required String id,
    required String name,
    required String vehicle,
    required Color vehicleColor,
    required Color vehicleBgColor,
    required String reason,
    required Color reasonColor,
    required Color reasonBgColor,
    required String location,
    required String distance,
    required String timeDate,
    required String penalty,
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
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
              height: 1.4,
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
              vehicle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: vehicleColor,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: reasonBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reason,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: reasonColor,
              ),
            ),
          ),
        ),
        DataCell(
          Text(
            location,
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
            distance,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF6F767E),
            ),
          ),
        ),
        DataCell(
          Text(
            timeDate,
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
            penalty,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFFEA3546), // Red penalty
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
