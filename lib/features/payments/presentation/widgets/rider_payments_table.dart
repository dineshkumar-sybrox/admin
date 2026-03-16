import 'package:admin/features/payments/presentation/cubit/payments_cubit.dart';
import 'package:admin/features/payments/presentation/cubit/payments_state.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RiderPaymentsTable extends StatefulWidget {
  RiderPaymentsTable({super.key});

  @override
  State<RiderPaymentsTable> createState() => _RiderPaymentsTableState();
}

class _RiderPaymentsTableState extends State<RiderPaymentsTable> {
  TextEditingController dateController = TextEditingController();
  String _selectedMethod = 'All Payment Methods';
  String _selectedStatus = 'All Status';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allData = [
    {
      'txId': '#TXN-88291',
      'riderName': 'Vikram Malhotra',
      'riderType': 'Regular Rider',
      'date': '24 Oct 2023,',
      'time': '08:45 PM',
      'tripId': '#TRP-44201',
      'amount': '₹842.00',
      'method': 'UPI',
      'methodIcon': Icons.account_balance_wallet_outlined,
      'status': 'COMPLETED',
      'statusColor': AppColors.cFF00C46B,
      'statusBgColor': AppColors.cFFE8FDF2,
    },
    {
      'txId': '#TXN-88289',
      'riderName': 'Priya Singh',
      'riderType': 'Gold Member',
      'date': '24 Oct 2023,',
      'time': '08:45 PM',
      'tripId': '#TRP-44198',
      'amount': '₹1,240.00',
      'method': 'Card',
      'methodIcon': Icons.credit_card_outlined,
      'status': 'FAILED',
      'statusColor': AppColors.cFFEA3546,
      'statusBgColor': AppColors.cFFFFECEE,
    },
    {
      'txId': '#TXN-88285',
      'riderName': 'Arjun Verma',
      'riderType': 'New User',
      'date': '24 Oct 2023,',
      'time': '08:45 PM',
      'tripId': '#TRP-44195',
      'amount': '₹350.00',
      'method': 'Cash',
      'methodIcon': Icons.payments_outlined,
      'status': 'PROCESSING',
      'statusColor': AppColors.cFF0066FF,
      'statusBgColor': AppColors.cFFE5F0FF,
    },
    {
      'txId': '#TXN-88282',
      'riderName': 'Sonia Kapoor',
      'riderType': 'Frequent Rider',
      'date': '24 Oct 2023,',
      'time': '08:45 PM',
      'tripId': '#TRP-44182',
      'amount': '₹520.00',
      'method': 'UPI',
      'methodIcon': Icons.account_balance_wallet_outlined,
      'status': 'COMPLETED',
      'statusColor': AppColors.cFF00C46B,
      'statusBgColor': AppColors.cFFE8FDF2,
    },
  ];

  List<Map<String, dynamic>> get _filteredData {
    return _allData.where((item) {
      final matchesMethod =
          _selectedMethod == 'All Payment Methods' ||
          item['method'] == _selectedMethod;
      final matchesStatus =
          _selectedStatus == 'All Status' || item['status'] == _selectedStatus;
      final matchesSearch =
          _searchQuery.isEmpty ||
          item['txId'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item['riderName'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesMethod && matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter Bar
          _buildFilterBar(context, context.watch<PaymentsCubit>().state),
          Divider(height: 1, color: AppColors.cFFF0F1F3),

          // Data Table
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor: WidgetStateProperty.all(AppColors.white),
              dataRowMaxHeight: 80,
              dataRowMinHeight: 80,
              horizontalMargin: 24,
              columnSpacing: 40,
              dividerThickness: 1,
              headingTextStyle: AppTypography.base.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF6F767E,
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('TRANSACTION IDd')),
                DataColumn(label: Text('RIDER NAME')),
                DataColumn(label: Text('DATE & TIME')),
                DataColumn(label: Text('TRIP ID')),
                DataColumn(label: Text('AMOUNT')),
                DataColumn(label: Text('METHOD')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: _filteredData.map((item) {
                return _buildRow(
                  txId: item['txId'],
                  riderName: item['riderName'],
                  riderType: item['riderType'],
                  date: item['date'],
                  time: item['time'],
                  tripId: item['tripId'],
                  amount: item['amount'],
                  method: item['method'],
                  methodIcon: item['methodIcon'],
                  status: item['status'],
                  statusColor: item['statusColor'],
                  statusBgColor: item['statusBgColor'],
                );
              }).toList(),
            ),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),

          // Pagination
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_filteredData.length} of ${_allData.length} transactions',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(ValueChanged<String> onChanged) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.cFFF4F6F9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.cFF9EA5AD,
            size: 20,
          ),
          hintText: 'Search by ID or Rider...',
          hintStyle: AppTypography.base.copyWith(
            fontSize: 13,
            color: AppColors.cFF9EA5AD,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, PaymentsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: Row(
        children: [
          Expanded(
                  flex: 3,
                  child: _buildSearchField(
                    (val) => setState(() => _searchQuery = val),
                  ),
                ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 48,
              child: _buildDropdown(
                'Payment Methods',
                state.payoutMethodFilter,
                (val) =>
                    context.read<PaymentsCubit>().filterPayoutByMethod(val!),
                ['Payment Methods', 'UPI', 'Bank'],
              ),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 48,
              child: _buildDropdown(
                'All Status',
                state.payoutStatusFilter,
                (val) =>
                    context.read<PaymentsCubit>().filterPayoutByStatus(val!),
                ['All Status', 'Successful', 'Pending', 'Rejected'],
              ),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 48,
              child: _buildDateField(context, dateController),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 48,
              child: _buildDropdown(
                'Vehicle',
                state.payoutVehicleFilter,
                (val) =>
                    context.read<PaymentsCubit>().filterPayoutByVehicle(val!),
                ['Vehicle', 'Cab', 'Bike/Scooter', 'Auto'],
              ),
            ),
          ),

          const SizedBox(width: 10),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cFF00A86B,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.download_rounded, size: 18),
              label: Text(
                'Export CSV',
                style: AppTypography.base.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDateField(BuildContext context, TextEditingController controller) {
  return TextField(
    controller: controller,
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        String formattedDate =
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";

        controller.text = formattedDate;
      }
    },
    decoration: InputDecoration(
      hintText: 'dd/mm/yyyy',
      hintStyle: AppTypography.base.copyWith(
        color: AppColors.cFF9EA5AD,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: const Icon(
        Icons.calendar_today_outlined,
        size: 18,
        color: AppColors.cFF9EA5AD,
      ),
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.cFFEFEFEF),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.cFFEFEFEF),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.cFF00A86B),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}

Widget _buildDropdown(
  String hint,
  String selectedValue,
  Function(String?) onSelected,
  List<String> items,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.cFFEFEFEF),
    ),
    child: PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.cFFEFEFEF),
      ),
      color: AppColors.white,
      elevation: 6,
      onSelected: onSelected,
      itemBuilder: (context) => items
          .map((item) => _buildPopupItem(item, selectedValue == item))
          .toList(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedValue.isEmpty ? hint : selectedValue,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.cFF1A1D1F,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: AppColors.cFF6F767E,
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
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      color: isSelected ? AppColors.cFFF4FDF8 : Colors.transparent,
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
            const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.cFF00A86B,
              size: 18,
            ),
        ],
      ),
    ),
  );
}


  

  Widget _buildDatePicker() {
    return Container(
      height: 42,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cFFF4F6F9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'mm/dd/yyyy',
          style: AppTypography.base.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.cFF6F767E,
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.file_download_outlined, size: 18),
      label: Text('Export CSV'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cFF00A86B,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTypography.base.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
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
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
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
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 2),
              Text(
                riderType,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.cFF9EA5AD,
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
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.cFF6F767E,
                ),
              ),
              SizedBox(height: 2),
              Text(
                time,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            tripId,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF00A86B, // Green distinct color for Trip ID
            ),
          ),
        ),
        DataCell(
          Text(
            amount,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(methodIcon, size: 16, color: AppColors.cFF6F767E),
              SizedBox(width: 8),
              Text(
                method,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                SizedBox(width: 6),
                Text(
                  status,
                  style: AppTypography.base.copyWith(
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
            icon: Icon(
              Icons.visibility_outlined,
              color: AppColors.cFF9EA5AD,
              size: 20,
            ),
            splashRadius: 20,
          ),
        ),
      ],
    );
  }



