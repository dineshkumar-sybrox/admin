import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../widgets/cancellation/cancellation_stat_cards.dart';
import 'rider_cancellation_screen.dart'; // To allow back-and-forth navigation if needed

class DriverCancellationScreen extends StatefulWidget {
  DriverCancellationScreen({super.key});

  @override
  State<DriverCancellationScreen> createState() =>
      _DriverCancellationScreenState();
}

class _DriverCancellationScreenState extends State<DriverCancellationScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Cancellation - Driver',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CancellationStatCards(
              selectedIndex: 2,
              onCardTapped: (index) {
                if (index == 0) {
                  Navigator.pop(context); // Go back to total cancellation
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RiderCancellationScreen(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cFFF0F1F3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildFilterBar(),
                  Divider(height: 1, color: AppColors.cFFF0F1F3),
                  _buildDataTable(),
                  Divider(height: 1, color: AppColors.cFFF0F1F3),
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
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildTextField('Search by ID or Rider...', Icons.search),
          ),
          SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('Reason for cancellation')),
          SizedBox(width: 16),
          Expanded(flex: 1, child: _buildTextField('mm/dd/yyyy', null)),
          SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('Vehicle')),
          SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cFF00A86B, // Green
              foregroundColor: AppColors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: Icon(Icons.download_rounded, size: 18),
            label: Text(
              'Export CSV',
              style: AppTypography.base.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
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
        hintStyle: AppTypography.base.copyWith(
          color: AppColors.cFF9EA5AD,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.cFF9EA5AD, size: 18)
            : null,
        filled: true,
        fillColor: AppColors.cFFF9FAFB,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.cFFEFEFEF),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.cFFEFEFEF),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ), // Adjust for height
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: AppTypography.base.copyWith(
              color: AppColors.cFF6F767E,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.cFF6F767E,
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
          AppColors.cFFF4F6F9.withValues(alpha: 0.5),
        ),
        dataRowMaxHeight: 80,
        dataRowMinHeight: 80,
        horizontalMargin: 24,
        columnSpacing: 24,
        dividerThickness: 1,
        headingTextStyle: AppTypography.base.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.cFF6F767E,
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
            vehicleColor: AppColors.cFFFFA629,
            vehicleBgColor: AppColors.cFFFFF7DB,
            reason: 'Passenger no-show',
            reasonColor: AppColors.cFFEA3546,
            reasonBgColor: AppColors.cFFFFECEE,
            location: 'Besant Naga -\nGuindy Tech Park',
            distance: '8.2km',
            timeDate: '08:45 PM\n24 Feb 2026',
            penalty: '₹0.00',
          ),
          _buildDataRow(
            id: '#TXN-88290',
            name: 'Rahul\nMalhotra',
            vehicle: 'CAB',
            vehicleColor: AppColors.cFFFFA629,
            vehicleBgColor: AppColors.cFFFFF7DB,
            reason: 'Wrong address shown',
            reasonColor: AppColors.cFFD4A000,
            reasonBgColor: AppColors.cFFFFF7DB,
            location: 'Besant Naga -\nGuindy Tech Park',
            distance: '8.2km',
            timeDate: '08:45 PM\n24 Feb 2026',
            penalty: '₹0.00',
          ),
          _buildDataRow(
            id: '#TXN-88289',
            name: 'Arun\nMalhotra',
            vehicle: 'BIKE/SCOOTER',
            vehicleColor: AppColors.cFF00A86B,
            vehicleBgColor: AppColors.cFFE8FDF2,
            reason: 'Vehicle issue',
            reasonColor: AppColors.cFF6F767E,
            reasonBgColor: AppColors.cFFF4F6F9,
            location: 'Besant Naga -\nGuindy Tech Park',
            distance: '8.2km',
            timeDate: '08:45 PM\n24 Feb 2026',
            penalty: '₹0.00',
          ),
          _buildDataRow(
            id: '#TXN-88288',
            name: 'Mani\nMalhotra',
            vehicle: 'CAB',
            vehicleColor: AppColors.cFFFFA629,
            vehicleBgColor: AppColors.cFFFFF7DB,
            reason: 'Emergency / Safety concern',
            reasonColor: AppColors.cFF2E5BFF,
            reasonBgColor: AppColors.cFFEAF0FF,
            location: 'Besant Naga -\nGuindy Tech Park',
            distance: '8.2km',
            timeDate: '08:45 PM\n24 Feb 2026',
            penalty: '₹0.00',
          ),
        ],
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
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            name,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: vehicleBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vehicle,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: vehicleColor,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: reasonBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reason,
              style: AppTypography.base.copyWith(
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
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.cFF6F767E,
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Text(
            distance,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        DataCell(
          Text(
            timeDate,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.cFF6F767E,
              height: 1.4,
            ),
          ),
        ),
        DataCell(
          Text(
            penalty,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFFEA3546, // Red penalty
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 4 of 2,450 transactions',
            style: AppTypography.base.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.cFF6F767E,
            ),
          ),
          Row(
            children: [
              _buildPaginator('<', isActive: false),
              SizedBox(width: 8),
              _buildPaginator('1', isActive: true),
              SizedBox(width: 8),
              _buildPaginator('2', isActive: false),
              SizedBox(width: 8),
              _buildPaginator('3', isActive: false),
              SizedBox(width: 8),
              _buildPaginator('4', isActive: false),
              SizedBox(width: 8),
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
        color: isActive ? AppColors.cFF00A86B : AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: isActive ? null : Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.base.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isActive ? AppColors.white : AppColors.cFF1A1D1F,
          ),
        ),
      ),
    );
  }
}




