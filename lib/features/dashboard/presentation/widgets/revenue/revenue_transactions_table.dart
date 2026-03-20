import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:admin/features/dashboard/presentation/widgets/revenue/revenue_stat_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'revenue_transaction_detail_dialog.dart';

class RevenueTransactionsTable extends StatefulWidget {
  RevenueTransactionsTable({super.key});

  @override
  State<RevenueTransactionsTable> createState() =>
      _RevenueTransactionsTableState();
}

class _RevenueTransactionsTableState extends State<RevenueTransactionsTable> {
  TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevenueStatCubit, RevenueStatState>(
      builder: (context, state) {
        final rows = _filteredRows(state);
        final showVehicleColumn = state.selectedTab == RevenueTab.total;
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
              SizedBox(height: 8),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: SizedBox(
              //           width: 380,
              //           height: 44,
              //           child: TextField(
              //             controller: _searchController,
              //             onChanged: (v) =>
              //                 context.read<RevenueStatCubit>().setSearch(v),
              //             decoration: InputDecoration(
              //               hintText: 'Search by ID, Rider or Driver...',
              //               hintStyle: AppTypography.base.copyWith(
              //                 color: AppColors.textSecondary,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //               prefixIcon: Icon(
              //                 Icons.search,
              //                 color: AppColors.textSecondary,
              //               ),
              //               filled: true,
              //               fillColor: AppColors.cFFF1F5F9,
              //               border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(8),
              //                 borderSide: BorderSide.none,
              //               ),

              //               contentPadding: EdgeInsets.symmetric(
              //                 vertical: 0,
              //                 horizontal: 16,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),

              //       SizedBox(width: 12),
              //       Spacer(),
              //       _FilterBox(label: 'mm/dd/yyyy'),
              //       if (showVehicleColumn) ...[
              //         SizedBox(width: 12),
              //         _VehicleDropdown(
              //           value: state.vehicleFilter,
              // onChanged: (value) => context
              //     .read<RevenueStatCubit>()
              //     .setVehicleFilter(value),
              //         ),
              //       ],
              //       SizedBox(width: 12),
              //       ElevatedButton.icon(
              //         onPressed: () =>
              //             context.read<DashboardCubit>().exportTodayReport(),
              //         icon: Icon(Icons.download, size: 16),
              //         label: Text(
              //           'Export CSV',
              //           style: AppTypography.base.copyWith(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w700,
              //             color: AppColors.white,
              //           ),
              //         ),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: AppColors.primary,
              //           foregroundColor: AppColors.white,
              //           padding: EdgeInsets.symmetric(
              //             horizontal: 16,
              //             vertical: 12,
              //           ),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Search Box
                    SizedBox(
                      width: 380,
                      height: 44,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (v) => context.read<RevenueStatCubit>().setSearch(v),
                        decoration: InputDecoration(
                          hintText: 'Search by name, email or phone...',
                          hintStyle: AppTypography.base.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          filled: true,
                          fillColor: AppColors.cFFF1F5F9,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        // Status Dropdown
                        if (showVehicleColumn) ...[
                          SizedBox(width: 12),

                          Container(
                            height: 44,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cFFF1F5F9,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.cFFEFEFEF),
                            ),
                            child: PopupMenuButton<String>(
                              offset: Offset(0, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: AppColors.cFFEFEFEF),
                              ),
                              color: AppColors.white,
                              elevation: 6,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    state.vehicleFilter,
                                    style: AppTypography.base.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.cFF1A1D1F,
                                    ),
                                  ),
                                  SizedBox(width: 32),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 16,
                                    color: AppColors.cFF6F767E,
                                  ),
                                ],
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  _selectedFilter = newValue;
                                });

                                context
                                    .read<RevenueStatCubit>()
                                    .setVehicleFilter(newValue);
                              },
                              itemBuilder: (context) => [
                                _buildPopupItem(
                                  'All',
                                  _selectedFilter == 'All',
                                ),
                                _buildPopupItem(
                                  'CAB',
                                  _selectedFilter == 'CAB',
                                ),
                                _buildPopupItem(
                                  'AUTO',
                                  _selectedFilter == 'AUTO',
                                ),
                                _buildPopupItem(
                                  'BIKE/SCOOTER',
                                  _selectedFilter == 'BIKE/SCOOTER',
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(width: 16),
                        Container(
                          height: 44,
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.cFFF1F5F9,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.cFFEFEFEF),
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
                        ),
                        SizedBox(width: 16),

                        // Export Button
                        SizedBox(
                          height: 44,
                          child: ElevatedButton.icon(
                            onPressed: () => context
                                .read<DashboardCubit>()
                                .exportTodayReport(),
                            icon: Icon(Icons.download, size: 16),
                            label: Text(
                              'Export CSV',
                              style: AppTypography.base.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 1, color: AppColors.cFFF0F1F3),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                      ),
                      child: DataTable(
                        columnSpacing: 40,
                        horizontalMargin: 16,
                        headingRowHeight: 60,
                        dataRowMinHeight: 60,
                        dataRowMaxHeight: 60,
                        headingRowColor: MaterialStateProperty.all(
                          AppColors.cFFF8F8F8,
                        ),
                        headingTextStyle: AppTypography.base.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                        columns: [
                          const DataColumn(label: Text('TRANSACTION ID')),
                          const DataColumn(label: Text('RIDER NAME')),
                          if (showVehicleColumn)
                            const DataColumn(label: Text('VEHICLE')),
                          const DataColumn(label: Text('DRIVER NAME')),
                          const DataColumn(label: Text('TIME &\nDATE')),
                          const DataColumn(label: Text('PAYMENT\nMETHOD')),
                          const DataColumn(label: Text('TOTAL AMOUNT')),
                          const DataColumn(label: Text('DRIVER\nEARNING')),
                          const DataColumn(label: Text('ACTION')),
                        ],
                        rows: rows
                            .map(
                              (t) => _buildRow(
                                row: t,
                                showVehicle: showVehicleColumn,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
              Divider(height: 1, color: AppColors.cFFF0F1F3),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOAD OLDER HISTORY',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cFF6F767E,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.cFF6F767E,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? AppColors.cFFF4FDF8 : AppColors.transparent,
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
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.cFF00A86B,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  String _tableTitle(RevenueTab tab) {
    switch (tab) {
      case RevenueTab.cab:
        return 'Total Revenue - Car Revenue';
      case RevenueTab.auto:
        return 'Total Revenue - Auto Revenue';
      case RevenueTab.bike:
        return 'Total Revenue - Bike / Scooter Revenue';
      case RevenueTab.total:
        return 'Total Revenue - Today Transactions';
    }
  }

  DataRow _buildRow({
    required _RevenueTransactionRow row,
    required bool showVehicle,
  }) {
    final vehicleBadge = _vehicleBadge(row.vehicleType);
    final paymentIcon = row.paymentMethod == 'UPI'
        ? Icons.qr_code_2
        : Icons.money;
    return DataRow(
      cells: [
        DataCell(
          Text(
            row.id,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            row.riderName,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        if (showVehicle) DataCell(vehicleBadge),
        DataCell(
          Text(
            row.driverName,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            row.timeAndDate,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(paymentIcon, size: 16, color: AppColors.cFF9EA5AD),
              SizedBox(width: 8),
              Text(
                row.paymentMethod,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            '₹${row.totalAmount}',
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            '₹${row.driverEarning}',
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          IconButton(
            icon: Icon(
              Icons.remove_red_eye_outlined,
              size: 16,
              color: AppColors.grey,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => RevenueTransactionDetailDialog(row: row),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _vehicleBadge(String vehicleType) {
    Color bg;
    Color fg;
    switch (vehicleType) {
      case 'CAB':
        bg = AppColors.cFFFFF6ED;
        fg = AppColors.cFFDC6803;
        break;
      case 'AUTO':
        bg = AppColors.cFFE8F2FF;
        fg = AppColors.cFF2970FF;
        break;
      case 'BIKE/SCOOTER':
      default:
        bg = AppColors.cFFECFDF3;
        fg = AppColors.cFF027A48;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        vehicleType,
        style: AppTypography.base.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

List<_RevenueTransactionRow> _filteredRows(RevenueStatState state) {
  List<_RevenueTransactionRow> rows = _allRows;
  if (state.selectedTab != RevenueTab.total) {
    final vehicle = switch (state.selectedTab) {
      RevenueTab.cab => 'CAB',
      RevenueTab.auto => 'AUTO',
      RevenueTab.bike => 'BIKE/SCOOTER',
      RevenueTab.total => '',
    };
    rows = rows.where((r) => r.vehicleType == vehicle).toList();
  } else if (state.vehicleFilter != 'All') {
    rows = rows.where((r) => r.vehicleType == state.vehicleFilter).toList();
  }

  final q = state.searchQuery.trim().toLowerCase();
  if (q.isEmpty) return rows;

  return rows.where((r) {
    return r.id.toLowerCase().contains(q) ||
        r.riderName.toLowerCase().contains(q) ||
        r.driverName.toLowerCase().contains(q);
  }).toList();
}

List<_RevenueTransactionRow> _transactionsForTab(RevenueTab tab) {
  if (tab == RevenueTab.total) {
    return _allRows;
  }
  final vehicle = switch (tab) {
    RevenueTab.cab => 'CAB',
    RevenueTab.auto => 'AUTO',
    RevenueTab.bike => 'BIKE/SCOOTER',
    RevenueTab.total => '',
  };
  return _allRows.where((r) => r.vehicleType == vehicle).toList();
}

class _FilterBox extends StatelessWidget {
  final String label;

  const _FilterBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _VehicleDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: AppColors.textSecondary,
          ),
          style: AppTypography.base.copyWith(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('Vehicle')),
            DropdownMenuItem(value: 'CAB', child: Text('Cab')),
            DropdownMenuItem(value: 'AUTO', child: Text('Auto')),
            DropdownMenuItem(
              value: 'BIKE/SCOOTER',
              child: Text('Bike/Scooter'),
            ),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _RevenueTransactionRow {
  final String id;
  final String riderName;
  final String vehicleType;
  final String driverName;
  final String timeAndDate;
  final String paymentMethod;
  final String totalAmount;
  final String driverEarning;

  const _RevenueTransactionRow({
    required this.id,
    required this.riderName,
    required this.vehicleType,
    required this.driverName,
    required this.timeAndDate,
    required this.paymentMethod,
    required this.totalAmount,
    required this.driverEarning,
  });
}

const List<_RevenueTransactionRow> _allRows = [
  _RevenueTransactionRow(
    id: '#TXN-88291',
    riderName: 'Vikram Malhotra',
    vehicleType: 'CAB',
    driverName: 'Sammy',
    timeAndDate: '24 Feb 2026\n08:45 PM',
    paymentMethod: 'UPI',
    totalAmount: '85.00',
    driverEarning: '65.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88290',
    riderName: 'Rahul Malhotra',
    vehicleType: 'AUTO',
    driverName: 'Arun',
    timeAndDate: '24 Feb 2026\n08:45 PM',
    paymentMethod: 'Cash',
    totalAmount: '85.00',
    driverEarning: '65.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88289',
    riderName: 'Arun Malhotra',
    vehicleType: 'BIKE/SCOOTER',
    driverName: 'Kumar',
    timeAndDate: '24 Feb 2026\n08:45 PM',
    paymentMethod: 'UPI',
    totalAmount: '85.00',
    driverEarning: '65.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88288',
    riderName: 'Mani Malhotra',
    vehicleType: 'CAB',
    driverName: 'Yogesh',
    timeAndDate: '24 Feb 2026\n08:45 PM',
    paymentMethod: 'UPI',
    totalAmount: '85.00',
    driverEarning: '65.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88287',
    riderName: 'Neha Iyer',
    vehicleType: 'AUTO',
    driverName: 'Suresh',
    timeAndDate: '24 Feb 2026\n08:30 PM',
    paymentMethod: 'UPI',
    totalAmount: '75.00',
    driverEarning: '55.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88286',
    riderName: 'Kiran Das',
    vehicleType: 'BIKE/SCOOTER',
    driverName: 'Pavan',
    timeAndDate: '24 Feb 2026\n08:20 PM',
    paymentMethod: 'Cash',
    totalAmount: '60.00',
    driverEarning: '45.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88285',
    riderName: 'Riya Sen',
    vehicleType: 'CAB',
    driverName: 'Naveen',
    timeAndDate: '24 Feb 2026\n08:05 PM',
    paymentMethod: 'UPI',
    totalAmount: '95.00',
    driverEarning: '70.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88284',
    riderName: 'Imran Ali',
    vehicleType: 'AUTO',
    driverName: 'Sanjay',
    timeAndDate: '24 Feb 2026\n07:55 PM',
    paymentMethod: 'UPI',
    totalAmount: '70.00',
    driverEarning: '50.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88283',
    riderName: 'Pooja Rao',
    vehicleType: 'BIKE/SCOOTER',
    driverName: 'Rahul',
    timeAndDate: '24 Feb 2026\n07:40 PM',
    paymentMethod: 'UPI',
    totalAmount: '55.00',
    driverEarning: '40.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88282',
    riderName: 'Ajay Kumar',
    vehicleType: 'CAB',
    driverName: 'Dev',
    timeAndDate: '24 Feb 2026\n07:25 PM',
    paymentMethod: 'Cash',
    totalAmount: '120.00',
    driverEarning: '85.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88281',
    riderName: 'Sneha Jain',
    vehicleType: 'AUTO',
    driverName: 'Vikas',
    timeAndDate: '24 Feb 2026\n07:10 PM',
    paymentMethod: 'UPI',
    totalAmount: '65.00',
    driverEarning: '48.00',
  ),
  _RevenueTransactionRow(
    id: '#TXN-88280',
    riderName: 'Arjun Nair',
    vehicleType: 'BIKE/SCOOTER',
    driverName: 'Hari',
    timeAndDate: '24 Feb 2026\n06:55 PM',
    paymentMethod: 'UPI',
    totalAmount: '50.00',
    driverEarning: '36.00',
  ),
];
