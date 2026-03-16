import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/payment_stat_cards.dart';
import '../widgets/payment_analytics_chart.dart';
import '../widgets/payment_method_chart.dart';
import '../widgets/driver_payout_list.dart';
import '../cubit/payments_cubit.dart';
import '../cubit/payments_state.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentsCubit(),
      child: BlocBuilder<PaymentsCubit, PaymentsState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentStatCards(
                      selectedIndex: state.selectedStatIndex,
                      onCardTapped: (index) {
                        context.read<PaymentsCubit>().changeStatIndex(index);
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildView(context, state, constraints),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildView(
    BuildContext context,
    PaymentsState state,
    BoxConstraints constraints,
  ) {
    if (state.selectedStatIndex == 0) {
      return _buildDashboardView(constraints);
    } else {
      return _buildTransactionListView(context, state);
    }
  }

  Widget _buildDashboardView(BoxConstraints constraints) {
    final isTablet = constraints.maxWidth < 1100;
    if (isTablet) {
      return const Column(
        children: [
          PaymentAnalyticsChart(),
          SizedBox(height: 16),
          PaymentMethodChart(),
          SizedBox(height: 16),
          DriverPayoutList(),
        ],
      );
    } else {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 14, child: PaymentAnalyticsChart()),
              SizedBox(width: 20),
              Expanded(flex: 9, child: PaymentMethodChart()),
            ],
          ),
          SizedBox(height: 20),
          DriverPayoutList(),
        ],
      );
    }
  }

  Widget _buildTransactionListView(BuildContext context, PaymentsState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F1F3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFilterBar(context, state),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          _buildDataTable(state.filteredTransactions),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          _buildPagination(state.filteredTransactions.length),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, PaymentsState state) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;
          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (val) =>
                      context.read<PaymentsCubit>().searchTransactions(val),
                  decoration: _getSearchInputDecoration(
                    'Search by ID or Rider...',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        'All Payment Methods',
                        state.paymentMethodFilter,
                        (val) => context
                            .read<PaymentsCubit>()
                            .filterByPaymentMethod(val!),
                        ['All Payment Methods', 'UPI', 'Cash', 'Card'],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown(
                        'All Status',
                        state.statusFilter,
                        (val) =>
                            context.read<PaymentsCubit>().filterByStatus(val!),
                        ['All Status', 'Completed', 'Failed', 'Pending'],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildTextField('mm/dd/yyyy', null)),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text(
                        'Export',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  onChanged: (val) =>
                      context.read<PaymentsCubit>().searchTransactions(val),
                  decoration: _getSearchInputDecoration(
                    'Search by ID or Rider...',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: _buildDropdown(
                  'All Payment Methods',
                  state.paymentMethodFilter,
                  (val) =>
                      context.read<PaymentsCubit>().filterByPaymentMethod(val!),
                  ['All Payment Methods', 'UPI', 'Cash', 'Card'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: _buildDropdown(
                  'All Status',
                  state.statusFilter,
                  (val) => context.read<PaymentsCubit>().filterByStatus(val!),
                  ['All Status', 'Completed', 'Failed', 'Pending'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _buildTextField('mm/dd/yyyy', null)),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A86B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
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
          );
        },
      ),
    );
  }

  InputDecoration _getSearchInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9EA5AD),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: const Icon(Icons.search, color: Color(0xFF9EA5AD), size: 18),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  Widget _buildDropdown(
    String hint,
    String? value,
    void Function(String?)? onChanged,
    List<String> items,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : null,
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> transactions) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor: WidgetStateProperty.all(
                const Color(0xFFF4F6F9).withOpacity(0.5),
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
              rows: transactions.map((txn) {
                return _buildDataRow(
                  id: txn['id'],
                  riderName: txn['riderName'],
                  driverName: txn['driverName'],
                  dateAndTime: txn['dateAndTime'],
                  tripId: txn['tripId'],
                  amount: txn['amount'],
                  paymentMethod: txn['paymentMethod'],
                  paymentIcon: txn['paymentIcon'],
                  status: txn['status'],
                  statusColor: txn['statusColor'],
                  statusBgColor: txn['statusBgColor'],
                );
              }).toList(),
            ),
          ),
        );
      },
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

  Widget _buildPagination(int total) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${total > 0 ? 1 : 0}-${total > 10 ? 10 : total} of $total transactions',
            style: const TextStyle(
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
