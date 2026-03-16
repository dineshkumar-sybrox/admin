import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'document_verification_page.dart';
import '../cubit/total_documents_cubit.dart';
import '../cubit/total_documents_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalDocumentsScreen extends StatelessWidget {
  const TotalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalDocumentsCubit(),
      child: BlocBuilder<TotalDocumentsCubit, TotalDocumentsState>(
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
                      _buildDataTable(context, state.filteredDocuments),
                      const Divider(height: 1),
                      _buildPagination(state.filteredDocuments.length),
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

  Widget _buildStatCardsRow(BuildContext context, TotalDocumentsState state) {
    return Row(
      children: [
        Expanded(
          child: _TopStatCard(
            title: 'NEW DOCUMENTS',
            value: '4.2K',
            trend: '+2.2%',
            isPositive: true,
            isActive: state.statusFilter == DocumentStatusFilter.newDocs,
            onTap: () => context.read<TotalDocumentsCubit>().filterByStatus(
              DocumentStatusFilter.newDocs,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'REJECTED DOCUMENTS',
            value: '100',
            trend: '+2.1%',
            isPositive: true,
            isActive: state.statusFilter == DocumentStatusFilter.rejected,
            onTap: () => context.read<TotalDocumentsCubit>().filterByStatus(
              DocumentStatusFilter.rejected,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'RESEND DOCUMENTS',
            value: '140',
            trend: '+5.2%',
            isPositive: true,
            isActive: state.statusFilter == DocumentStatusFilter.resend,
            onTap: () => context.read<TotalDocumentsCubit>().filterByStatus(
              DocumentStatusFilter.resend,
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'VERIFIED DOCUMENTS',
            value: '4.2K',
            trend: '+2.2%',
            isPositive: true,
            isActive: state.statusFilter == DocumentStatusFilter.verified,
            onTap: () => context.read<TotalDocumentsCubit>().filterByStatus(
              DocumentStatusFilter.verified,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlsRow(BuildContext context, TotalDocumentsState state) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (val) =>
                  context.read<TotalDocumentsCubit>().searchDocuments(val),
              decoration: InputDecoration(
                hintText: 'Search Ticket ID or Name...',
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
          const Spacer(),
          SizedBox(
            width: 180,
            child: _buildDropdown(
              'All Categories',
              state.categoryFilter,
              (val) =>
                  context.read<TotalDocumentsCubit>().filterByCategory(val!),
              [
                'All Categories',
                'DRIVING LICENSE',
                'VEHICLE RC',
                'PAN CARD',
                'AADHAR CARD',
                'BANK DETAILS',
                'IDENTITY VERIFICATION',
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEFEFEF)),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFF6F767E),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F9).withValues(alpha: 0.5),
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
    List<Map<String, dynamic>> documents,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 64,
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            const Color(0xFFF4F6F9).withValues(alpha: 0.5),
          ),
          dataRowMaxHeight: 70,
          dataRowMinHeight: 70,
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
            DataColumn(label: Text('DOCUMENT ID')),
            DataColumn(label: Text('DRIVER NAME')),
            DataColumn(label: Text('DOCUMENTS')),
            DataColumn(label: Text('CATEGORY')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('CLOSED DATE & TIME')),
            DataColumn(label: Text('ACTION')),
          ],
          rows: documents.map((doc) {
            return _buildDataRow(
              context: context,
              id: doc['id'],
              driverName: doc['driverName'],
              documents: doc['documents'],
              category: doc['category'],
              categoryColor: doc['categoryColor'],
              categoryTextColor: doc['categoryTextColor'],
              status: doc['status'],
              statusColor: doc['statusColor'],
              dateTime: doc['dateTime'],
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required BuildContext context,
    required String id,
    required String driverName,
    required String documents,
    required String category,
    required Color categoryColor,
    required Color categoryTextColor,
    required String status,
    required Color statusColor,
    required String dateTime,
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
            driverName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ),
        DataCell(
          Text(
            documents,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Color(0xFF6F767E),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: categoryTextColor,
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
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: const Color(0xFF1A1D1F),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF6F767E),
            ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              int initialIndex = 0;
              final String docType = documents.toUpperCase();
              if (docType.contains('DRIVING LICENSE')) {
                initialIndex = 0;
              } else if (docType.contains('VEHICLE RC')) {
                initialIndex = 1;
              } else if (docType.contains('PAN CARD')) {
                initialIndex = 2;
              } else if (docType.contains('AADHAR CARD')) {
                initialIndex = 3;
              } else if (docType.contains('BANK DETAILS')) {
                initialIndex = 4;
              } else if (docType.contains('IDENTITY VERIFICATION')) {
                initialIndex = 5;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentVerificationPage(
                    driverName: driverName,
                    documentId: id,
                    initialIndex: initialIndex,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.visibility_outlined,
              color: Color(0xFF6F767E),
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
            'Showing 1-${total > 10 ? 10 : total} of $total documents',
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
    // const trendColor = Color(0xFF22C55E); // Green from mockup
    const trendIcon = Icons.trending_up;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
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
                            fontSize: 11,
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
                                const Icon(
                                  trendIcon,
                                  size: 14,
                                  color: Color(0xFF22C55E),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  trend,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: const Color(0xFF22C55E),
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
