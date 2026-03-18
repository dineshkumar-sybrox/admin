import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import '../../pages/ticket_detail_screen.dart';
import '../../cubit/total_tickets_state.dart';

class TotalTicketsTable extends StatelessWidget {
  final List<Map<String, dynamic>> tickets;
  final TicketStatusFilter statusFilter;

  const TotalTicketsTable({
    super.key,
    required this.tickets,
    required this.statusFilter,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusFilter) {
      case TicketStatusFilter.refund:
        return _buildRefundTable(context, tickets);
      case TicketStatusFilter.closed:
        return _buildClosedTable(context, tickets);
      case TicketStatusFilter.open:
      case TicketStatusFilter.all:    
      return _buildOpenTable(context, tickets);
    }
  }

  Widget _buildOpenTable(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width > 1200
              ? MediaQuery.of(context).size.width - 320
              : 1000,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
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
          showCheckboxColumn: false,
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.cFFF3F4F6, width: 1),
          ),
          columns: const [
            DataColumn(label: Text('TICKET ID')),
            DataColumn(label: Text('RIDER/DRIVER')),
            DataColumn(label: Text('ISSUE CATEGORY')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('CREATED DATE & TIME')),
            DataColumn(label: Text('ACTIONS')),
          ],
          rows: tickets.map((ticket) {
            return _buildDataRow(
              context: context,
              id: ticket['id'],
              personName: ticket['personName'],
              personType: ticket['personType'],
              category: ticket['category'],
              status: ticket['status'],
              dateTime: ticket['dateTime'],
              statusColor: ticket['statusColor'],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildClosedTable(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width > 1200
              ? MediaQuery.of(context).size.width - 320
              : 1100,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
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
          showCheckboxColumn: false,
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.cFFF3F4F6, width: 1),
          ),
          columns: const [
            DataColumn(label: Text('TICKET ID')),
            DataColumn(label: Text('RIDER/DRIVER')),
            DataColumn(label: Text('ISSUE CATEGORY')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('CLOSED DATE & TIME')),
            DataColumn(label: Text('RESOLUTION METHOD')),
            // DataColumn(label: Text('ACTIONS')),
          ],
          rows: tickets.map((ticket) {
            return _buildClosedRow(
              context: context,
              id: ticket['id'],
              personName: ticket['personName'],
              personType: ticket['personType'],
              category: ticket['category'],
              status: ticket['status'],
              dateTime: ticket['dateTime'],
              statusColor: ticket['statusColor'],
              resolution: 'Resolved by Admin',
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRefundTable(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width > 1200
              ? MediaQuery.of(context).size.width - 200
              : 1300,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
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
          showCheckboxColumn: false,
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.cFFF3F4F6, width: 1),
          ),
          columns: const [
            DataColumn(label: Text('TICKET ID')),
            DataColumn(label: Text('RIDER/DRIVER')),
            DataColumn(label: Text('ISSUE CATEGORY')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('REFUND ASK')),
            DataColumn(label: Text('REFUND GIVEN')),
            DataColumn(label: Text('REFUND DATE & TIME')),
            DataColumn(label: Text('REFUND DESTINATION')),
            DataColumn(label: Text('ACTIONS')),
          ],
          rows: tickets.map((ticket) {
            return _buildRefundRow(
              context: context,
              id: ticket['id'],
              personName: ticket['personName'],
              personType: ticket['personType'],
              category: ticket['category'],
              status: ticket['status'],
              dateTime: ticket['dateTime'],
              statusColor: ticket['statusColor'],
              refundAsk: '₹500.00',
              refundGiven: '₹450.00',
              refundDestination: 'Wallet',
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required BuildContext context,
    required String id,
    required String personName,
    required String personType,
    required String category,
    required String dateTime,
    required String status,
    required Color statusColor,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                personName,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 4),
              Text(
                personType,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cFFF0F2F5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: AppColors.cFF1A1D1F,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
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
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetailScreen(
                    ticketData: {
                      'id': id,
                      'personName': personName,
                      'personType': personType,
                      'category': category,
                      'status': status,
                      'dateTime': dateTime,
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.message_rounded, color: AppColors.cFF6F767E),
          ),
        ),
      ],
    );
  }

  DataRow _buildClosedRow({
    required BuildContext context,
    required String id,
    required String personName,
    required String personType,
    required String category,
    required String dateTime,
    required String status,
    required Color statusColor,
    required String resolution,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                personName,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 4),
              Text(
                personType,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cFFF0F2F5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: AppColors.cFF1A1D1F,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
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
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        DataCell(
          Text(
            resolution,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        // DataCell(
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => TicketDetailScreen(
        //             ticketData: {
        //               'id': id,
        //               'personName': personName,
        //               'personType': personType,
        //               'category': category,
        //               'status': status,
        //               'dateTime': dateTime,
        //             },
        //           ),
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.message_rounded, color: AppColors.cFF6F767E),
        //   ),
        // ),
      ],
    );
  }

  DataRow _buildRefundRow({
    required BuildContext context,
    required String id,
    required String personName,
    required String personType,
    required String category,
    required String dateTime,
    required String status,
    required Color statusColor,
    required String refundAsk,
    required String refundGiven,
    required String refundDestination,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                personName,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 4),
              Text(
                personType,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cFFF0F2F5,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: AppColors.cFF1A1D1F,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
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
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            refundAsk,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            refundGiven,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.cFF00A86B,
            ),
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        DataCell(
          Text(
            refundDestination,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetailScreen(
                    ticketData: {
                      'id': id,
                      'personName': personName,
                      'personType': personType,
                      'category': category,
                      'status': status,
                      'dateTime': dateTime,
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.message_rounded, color: AppColors.cFF6F767E),
          ),
        ),
      ],
    );
  }
}

