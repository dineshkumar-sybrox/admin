import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/payments_cubit.dart';
import '../cubit/payments_state.dart';
import '../pages/driver_payout_details_screen.dart';

class DriverPayoutList extends StatelessWidget {
  TextEditingController dateController = TextEditingController();
  DriverPayoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, state) {
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
              _buildFilterBar(context, state),
              Divider(height: 1, color: AppColors.cFFF0F1F3),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  showCheckboxColumn: false,
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.cFFF8FAFC,
                  ),
                  headingTextStyle: AppTypography.base.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                  dataTextStyle: AppTypography.base.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  horizontalMargin: 24,
                  columnSpacing: 24,
                  headingRowHeight: 56,
                  dataRowMaxHeight: 72,
                  dataRowMinHeight: 72,
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: AppColors.cFFF3F4F6,
                      width: 1,
                    ),
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
                  rows: state.filteredPayouts.map((payout) {
                    return _buildRow(
                      context,
                      id: payout['id'],
                      vehicleType: payout['vehicleType'],
                      vehicleColor: payout['vehicleColor'],
                      vehicleBgColor: payout['vehicleBgColor'],
                      dateAndTime: payout['dateAndTime'],
                      driverName: payout['driverName'],
                      driverDesc: payout['driverDesc'],
                      amount: payout['amount'],
                      paymentTransfer: payout['paymentTransfer'],
                      paymentIcon: payout['paymentIcon'],
                      status: payout['status'],
                      statusColor: payout['statusColor'],
                      statusBgColor: payout['statusBgColor'],
                    );
                  }).toList(),
                ),
              ),
              Divider(height: 1, color: AppColors.cFFF0F1F3),
              _buildPagination(state.filteredPayouts.length),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar(BuildContext context, PaymentsState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Driver Payout List', style: AppTypography.h3),
              SizedBox(height: 4),
              Text(
                'Settlements for drivers',
                style: AppTypography.base.copyWith(),
              ),
            ],
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

Widget _buildPagination(int total) {
  return Padding(
    padding: EdgeInsets.all(24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing 1-${total > 10 ? 10 : total} of $total payout requests',
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

DataRow _buildRow(
  BuildContext context, {
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DriverPayoutDetailsScreen(driverName: driverName),
        ),
      );
    },
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: vehicleBgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            vehicleType,
            style: AppTypography.base.copyWith(
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
          style: AppTypography.base.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: AppColors.cFF6F767E,
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
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(height: 2),
            Text(
              driverDesc,
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
          children: [
            Icon(paymentIcon, size: 16, color: AppColors.cFF6F767E),
            SizedBox(width: 6),
            Text(
              paymentTransfer,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
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
        ),
      ),
    ],
  );
}
