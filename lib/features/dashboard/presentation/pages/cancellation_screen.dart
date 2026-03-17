import 'package:flutter/material.dart';
import '../widgets/cancellation/cancellation_stat_cards.dart';
import '../widgets/cancellation/reasons_for_cancellation.dart';
import '../widgets/cancellation/cancellation_zones_chart.dart';
import '../widgets/cancellation/high_risk_zones_table.dart';

class CancellationScreen extends StatefulWidget {
  final int initialIndex;
  const CancellationScreen({super.key, this.initialIndex = 0});

  @override
  State<CancellationScreen> createState() => _CancellationScreenState();
}

class _CancellationScreenState extends State<CancellationScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth < 1100;

        Widget content;
        switch (_selectedIndex) {
          case 1:
            content = const _RiderCancellationContent();
            break;
          case 2:
            content = const _DriverCancellationContent();
            break;
          default:
            content = _buildTotalContent(isTablet);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CancellationStatCards(
                selectedIndex: _selectedIndex,
                onCardTapped: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              const SizedBox(height: 20),
              content,
            ],
          ),
        );
      },
    );
  }

  Widget _buildTotalContent(bool isTablet) {
    if (isTablet) {
      return Column(
        children: [
          ReasonsForCancellation(),
          SizedBox(height: 16),
          CancellationZonesChart(),
          SizedBox(height: 16),
          HighRiskZonesTable(),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 14, child: ReasonsForCancellation()),
            SizedBox(width: 20),
            Expanded(flex: 9, child: CancellationZonesChart()),
          ],
        ),
        SizedBox(height: 20),
        HighRiskZonesTable(),
      ],
    );
  }
}

// These will be implemented below or extracted
class _RiderCancellationContent extends StatelessWidget {
  const _RiderCancellationContent();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              backgroundColor: const Color(0xFF00A86B),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
    return SizedBox(
      width: double.infinity,
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
          _buildRow(
            id: '#TXN-88291',
            name: 'Vikram\nMalhotra',
            vehicle: 'CAB',
            vColor: const Color(0xFFFFA629),
            vBg: const Color(0xFFFFF7DB),
            reason: 'Long Wait Time',
            rColor: const Color(0xFFEA3546),
            rBg: const Color(0xFFFFECEE),
            loc: 'Besant Naga -\nGuindy Tech Park',
            dist: '8.2km',
            time: '08:45 PM\n24 Feb 2026',
            pen: '₹0.00',
          ),
          _buildRow(
            id: '#TXN-88290',
            name: 'Rahul\nMalhotra',
            vehicle: 'AUTO',
            vColor: const Color(0xFF2E5BFF),
            vBg: const Color(0xFFEAF0FF),
            reason: 'Wrong pickup location',
            rColor: const Color(0xFFD4A000),
            rBg: const Color(0xFFFFF7DB),
            loc: 'Besant Naga -\nGuindy Tech Park',
            dist: '8.2km',
            time: '08:45 PM\n24 Feb 2026',
            pen: '₹0.00',
          ),
        ],
      ),
    );
  }

  DataRow _buildRow({
    required String id,
    required String name,
    required String vehicle,
    required Color vColor,
    required Color vBg,
    required String reason,
    required Color rColor,
    required Color rBg,
    required String loc,
    required String dist,
    required String time,
    required String pen,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.w700))),
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: vBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vehicle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: vColor,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: rBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reason,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: rColor,
              ),
            ),
          ),
        ),
        DataCell(Text(loc, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(Text(dist, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(Text(time, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(
          Text(
            pen,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFFEA3546),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 4 of 2,450 transactions',
            style: TextStyle(color: Color(0xFF6F767E)),
          ),
          Row(
            children: [
              Icon(Icons.chevron_left),
              SizedBox(width: 8),
              Text('1'),
              SizedBox(width: 8),
              Icon(Icons.chevron_right),
            ],
          ),
        ],
      ),
    );
  }
}

class _DriverCancellationContent extends StatelessWidget {
  const _DriverCancellationContent();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              backgroundColor: const Color(0xFF00A86B),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
    return SizedBox(
      width: double.infinity,
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
          _buildRow(
            id: '#TXN-88291',
            name: 'Vikram\nMalhotra',
            vehicle: 'CAB',
            vColor: const Color(0xFFFFA629),
            vBg: const Color(0xFFFFF7DB),
            reason: 'Passenger no-show',
            rColor: const Color(0xFFEA3546),
            rBg: const Color(0xFFFFECEE),
            loc: 'Besant Naga -\nGuindy Tech Park',
            dist: '8.2km',
            time: '08:45 PM\n24 Feb 2026',
            pen: '₹0.00',
          ),
        ],
      ),
    );
  }

  DataRow _buildRow({
    required String id,
    required String name,
    required String vehicle,
    required Color vColor,
    required Color vBg,
    required String reason,
    required Color rColor,
    required Color rBg,
    required String loc,
    required String dist,
    required String time,
    required String pen,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.w700))),
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: vBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vehicle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: vColor,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: rBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reason,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: rColor,
              ),
            ),
          ),
        ),
        DataCell(Text(loc, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(Text(dist, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(Text(time, style: const TextStyle(color: Color(0xFF6F767E)))),
        DataCell(
          Text(
            pen,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFFEA3546),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 4 of 2,450 transactions',
            style: TextStyle(color: Color(0xFF6F767E)),
          ),
          Row(
            children: [
              Icon(Icons.chevron_left),
              SizedBox(width: 8),
              Text('1'),
              SizedBox(width: 8),
              Icon(Icons.chevron_right),
            ],
          ),
        ],
      ),
    );
  }
}
