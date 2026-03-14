import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticket_detail_screen.dart';
import '../cubit/total_tickets_cubit.dart';
import '../cubit/total_tickets_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalTicketsScreen extends StatelessWidget {
  const TotalTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalTicketsCubit(),
      child: BlocBuilder<TotalTicketsCubit, TotalTicketsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStatCardsRow(context, state),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
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
                      _buildControlsRow(context, state),
                      const Divider(height: 1),
                      _buildDataTable(context, state.filteredTickets),
                      const Divider(height: 1),
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
        const SizedBox(width: 24),
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
        const SizedBox(width: 24),
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
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (value) =>
                  context.read<TotalTicketsCubit>().searchTickets(value),
              decoration: InputDecoration(
                hintText: 'Search by Ticket ID or Name...',
                hintStyle: const TextStyle(
                  color: Color(0xFF9EA5AD),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF9EA5AD),
                  size: 18,
                ),
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
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
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
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _buildDropdown(
              'issue category',
              'issue category',
              (val) {},
              [],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEFEFEF)),
            ),
            child: const Icon(
              Icons.filter_list,
              color: Color(0xFF6F767E),
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

  Widget _buildDataTable(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        showCheckboxColumn: false,
        headingRowColor: WidgetStateProperty.all(
          const Color(0xFFF4F6F9).withValues(alpha: 0.5),
        ),
        dataRowMaxHeight: 80,
        dataRowMinHeight: 80,
        horizontalMargin: 24,
        columnSpacing: 40,
        dividerThickness: 1,
        headingTextStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Color(0xFF6F767E),
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
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
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
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1A1D1F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                personType,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Color(0xFF6F767E),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0xFF1A1D1F),
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
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
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
            icon: const Icon(Icons.more_vert, color: Color(0xFF6F767E)),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(int totalFiltered) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1-${totalFiltered > 10 ? 10 : totalFiltered} of $totalFiltered tickets',
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
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
                  color: isActive ? AppColors.primary : Colors.transparent,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
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
                        const SizedBox(height: 16),
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
                            const SizedBox(width: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(trendIcon, size: 16, color: trendColor),
                                const SizedBox(width: 4),
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
