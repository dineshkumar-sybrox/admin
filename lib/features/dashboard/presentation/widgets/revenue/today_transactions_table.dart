import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';

class TodayTransactionsTable extends StatelessWidget {
  TodayTransactionsTable({super.key});

  final List<_TodayTxRow> _rows = const [
    _TodayTxRow(
      rideId: '#RD-82708',
      totalAmount: '85.00',
      driverEarnings: '65.00',
      serviceType: 'AUTO',
      paymentMethod: 'Cash',
    ),
    _TodayTxRow(
      rideId: '#RD-82708',
      totalAmount: '245.50',
      driverEarnings: '190.50',
      serviceType: 'AUTO',
      paymentMethod: 'UPI',
    ),
    _TodayTxRow(
      rideId: '#RD-82708',
      totalAmount: '1,420.00',
      driverEarnings: '1,020.00',
      serviceType: 'CAB',
      paymentMethod: 'UPI',
    ),
    _TodayTxRow(
      rideId: '#RD-82708',
      totalAmount: '92.00',
      driverEarnings: '75.00',
      serviceType: 'BIKE/SCOOTER',
      paymentMethod: 'UPI',
    ),
  ];

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
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Text("Today Transactions", style: AppTypography.h3),

                Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download, size: 16, color: Colors.grey),
                  label: Text(
                    'Download PDF',
                    style: AppTypography.base.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    foregroundColor: AppColors.textSecondary,
                  ),
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
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
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
                      DataColumn(label: Text('RIDE ID')),
                      DataColumn(label: Text('TOTAL\nAMOUNT')),
                      DataColumn(label: Text('DRIVER\nEARNINGS')),
                      DataColumn(label: Text('SERVICE\nTYPE')),
                      DataColumn(label: Text('PAYMENT\nMETHOD')),
                      DataColumn(label: Text('ACTION')),
                    ],
                    rows: _rows.map(_buildRow).toList(),
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
  }

  DataRow _buildRow(_TodayTxRow row) {
    final serviceBadge = _serviceBadge(row.serviceType);
    final paymentIcon = row.paymentMethod == 'UPI'
        ? Icons.qr_code_2
        : Icons.money;

    return DataRow(
      cells: [
        DataCell(
          Text(
            row.rideId,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
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
            '₹${row.driverEarnings}',
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(serviceBadge),
        DataCell(
          Row(
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
          Icon(Icons.remove_red_eye_outlined, size: 16, color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _serviceBadge(String serviceType) {
    Color bg;
    Color fg;
    switch (serviceType) {
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
        serviceType,
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

class _TodayTxRow {
  final String rideId;
  final String totalAmount;
  final String driverEarnings;
  final String serviceType;
  final String paymentMethod;

  const _TodayTxRow({
    required this.rideId,
    required this.totalAmount,
    required this.driverEarnings,
    required this.serviceType,
    required this.paymentMethod,
  });
}
