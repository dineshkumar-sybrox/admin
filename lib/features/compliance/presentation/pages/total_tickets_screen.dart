import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticket_detail_screen.dart';
import '../cubit/total_tickets_cubit.dart';
import '../cubit/total_tickets_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalTicketsScreen extends StatelessWidget {
  TotalTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalTicketsCubit(),
      child: BlocBuilder<TotalTicketsCubit, TotalTicketsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStatCardsRow(context, state),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey.shade200),
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
                      _buildControlsRow(context, state),
                      Divider(height: 1),
                      _buildDataTable(context, state.filteredTickets),
                      Divider(height: 1),
                      _buildPagination(state.filteredTickets.length),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCardsRow(BuildContext context, TotalTicketsState state) {
    return Row(
      children: [
        Expanded(
          child: _TopStatCard(
            title: 'OPEN TICKETS',
            value: '142',
            trend: '-5.2%',
            isPositive: false,
            isActive: state.statusFilter == TicketStatusFilter.open,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.open,
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'CLOSED TICKETS',
            value: '100',
            trend: '+2.1%',
            isPositive: true,
            isActive: state.statusFilter == TicketStatusFilter.closed,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.closed,
            ),
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'REFUND AMOUNT',
            value: '₹4.2K',
            trend: '-2.2%',
            isPositive: false,
            isActive: state.statusFilter == TicketStatusFilter.refund,
            onTap: () => context.read<TotalTicketsCubit>().filterByStatus(
              TicketStatusFilter.refund,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlsRow(BuildContext context, TotalTicketsState state) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (value) =>
                  context.read<TotalTicketsCubit>().searchTickets(value),
              decoration: InputDecoration(
                hintText: 'Search by Ticket ID or Name...',
                hintStyle: AppTypography.base.copyWith(
                  color: AppColors.cFF9EA5AD,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.cFF9EA5AD,
                  size: 18,
                ),
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
                  vertical: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildDropdown(
              'All Categories',
              state.categoryFilter,
              (val) => context.read<TotalTicketsCubit>().filterByCategory(val!),
              [
                'All Categories',
                'BILLING ISSUE',
                'SAFETY',
                'APP GLITCH',
                'PAYMENT ERROR',
                'REFUND',
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _buildDropdown(
              'issue category',
              'issue category',
              (val) {},
              [],
            ),
          ),
          SizedBox(width: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFEFEFEF),
            ),
            child: Icon(
              Icons.filter_list,
              color: AppColors.cFF6F767E,
              size: 20,
            ),
          ),
        ],
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : null,
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        showCheckboxColumn: false,
        headingRowColor: WidgetStateProperty.all(
          AppColors.cFFF4F6F9.withValues(alpha: 0.5),
        ),
        dataRowMaxHeight: 80,
        dataRowMinHeight: 80,
        horizontalMargin: 24,
        columnSpacing: 40,
        dividerThickness: 1,
        headingTextStyle: AppTypography.base.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.cFF6F767E,
          letterSpacing: 0.5,
        ),
        columns: const [
          DataColumn(label: Text('TICKET ID')),
          DataColumn(label: Text('CUSTOMER/DRIVER')),
          DataColumn(label: Text('ISSUE CATEGORY')),
          DataColumn(label: Text('STATUS')),
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
            statusColor: ticket['statusColor'],
          );
        }).toList(),
      ),
    );
  }

  DataRow _buildDataRow({
    required BuildContext context,
    required String id,
    required String personName,
    required String personType,
    required String category,
    required String status,
    required Color statusColor,
  }) {
    return DataRow(
      onSelectChanged: (selected) {
        if (selected != null && selected) {
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
                },
              ),
            ),
          );
        }
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
                  color:
                      statusColor, // Match text color to dot color as per mockup design style
                ),
              ),
            ],
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: AppColors.cFF6F767E),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(int totalFiltered) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1-${totalFiltered > 10 ? 10 : totalFiltered} of $totalFiltered tickets',
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

class _TopStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final bool isActive;
  final VoidCallback? onTap;

  const _TopStatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppColors.primary : AppColors.error;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.shade200, width: 1),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3,
                  color: isActive ? AppColors.primary : AppColors.transparent,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.bodySmall.copyWith(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              value,
                              style: AppTypography.h1.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 32,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(width: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(trendIcon, size: 16, color: trendColor),
                                SizedBox(width: 4),
                                Text(
                                  trend,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: trendColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



