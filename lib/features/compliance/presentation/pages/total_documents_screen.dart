import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'document_verification_page.dart';
import '../cubit/total_documents_cubit.dart';
import '../cubit/total_documents_state.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalDocumentsScreen extends StatefulWidget {
  TotalDocumentsScreen({super.key});

  @override
  State<TotalDocumentsScreen> createState() => _TotalDocumentsScreenState();
}

class _TotalDocumentsScreenState extends State<TotalDocumentsScreen> {
  TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'All Categories';

  final List<String> items = [
    'All Categories',
    'DRIVING LICENSE',
    'VEHICLE RC',
    'PAN CARD',
    'AADHAR CARD',
    'BANK DETAILS',
    'IDENTITY VERIFICATION',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalDocumentsCubit(),
      child: BlocBuilder<TotalDocumentsCubit, TotalDocumentsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
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
                      // Divider(height: 1),
                      _buildDataTable(context, state.filteredDocuments),
                      Divider(height: 1),
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
        SizedBox(width: 24),
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
        SizedBox(width: 24),
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
        SizedBox(width: 24),
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
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          SizedBox(
            width: 400,
            height: 40,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<TotalDocumentsCubit>().searchDocuments(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Document ID or Driver Name...',
                hintStyle: AppTypography.base.copyWith(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 18),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Spacer(),

          const SizedBox(width: 16),

          /// 📂 Category Dropdown (Popup)
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
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
              onSelected: (value) {
                setState(() => _selectedCategory = value);

                /// Optional: call bloc filter
                context.read<TotalDocumentsCubit>().filterByCategory(value);
              },
              itemBuilder: (context) => [
                _buildPopupItem(
                  'All Categories',
                  _selectedCategory == 'All Categories',
                ),
                _buildPopupItem(
                  'DRIVING LICENSE',
                  _selectedCategory == 'DRIVING LICENSE',
                ),
                _buildPopupItem(
                  'VEHICLE RC',
                  _selectedCategory == 'VEHICLE RC',
                ),
                _buildPopupItem('PAN CARD', _selectedCategory == 'PAN CARD'),
                _buildPopupItem(
                  'AADHAR CARD',
                  _selectedCategory == 'AADHAR CARD',
                ),
                _buildPopupItem(
                  'BANK DETAILS',
                  _selectedCategory == 'BANK DETAILS',
                ),
                _buildPopupItem(
                  'IDENTITY VERIFICATION',
                  _selectedCategory == 'IDENTITY VERIFICATION',
                ),
              ],
              child: Row(
                children: [
                  Text(
                    _selectedCategory,
                    style: AppTypography.base.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cFF1A1D1F,
                    ),
                  ),
                  const SizedBox(width: 32),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: AppColors.cFF6F767E,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// 📅 Calendar Button
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFEFEFEF),
            ),
            child: Center(
              child: IconButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    /// handle date filter here
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined),
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// ⚙️ Filter Button
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFEFEFEF),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  /// Open advanced filter dialog
                },
                icon: const Icon(Icons.filter_list_rounded),
              ),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: TextField(
          // onChanged: (val) =>
          //     context.read<TotalDocumentsCubit>().searchDocuments(val),
          //     decoration: InputDecoration(
          //       hintText: 'Search Ticket ID or Name...',
          //       hintStyle: AppTypography.base.copyWith(
          //         color: AppColors.cFF9EA5AD,
          //         fontSize: 13,
          //         fontWeight: FontWeight.w500,
          //       ),
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: AppColors.cFF9EA5AD,
          //         size: 18,
          //       ),
          //       filled: true,
          //       fillColor: AppColors.cFFF9FAFB,
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         borderSide: BorderSide(color: AppColors.cFFEFEFEF),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         borderSide: BorderSide(color: AppColors.cFFEFEFEF),
          //       ),
          //       contentPadding: EdgeInsets.symmetric(
          //         horizontal: 16,
          //         vertical: 12,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(width: 24),
          // Spacer(),
          // SizedBox(
          //   width: 180,
          //   child: _buildDropdown(
          //     'All Categories',
          //     state.categoryFilter,
          //     (val) =>
          //         context.read<TotalDocumentsCubit>().filterByCategory(val!),
          // [
          //   'All Categories',
          //   'DRIVING LICENSE',
          //   'VEHICLE RC',
          //   'PAN CARD',
          //   'AADHAR CARD',
          //   'BANK DETAILS',
          //   'IDENTITY VERIFICATION',
          // ],
          //   ),
          // ),
          // SizedBox(width: 16),
          // Container(
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: AppColors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(color: AppColors.cFFEFEFEF),
          //   ),
          //   child: Icon(
          //     Icons.calendar_today_outlined,
          //     color: AppColors.cFF6F767E,
          //     size: 20,
          //   ),
          // ),
          // SizedBox(width: 16),
          // Container(
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: AppColors.cFFF4F6F9.withValues(alpha: 0.5),
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(color: AppColors.cFFEFEFEF),
          //   ),
          //   child: Icon(
          //     Icons.filter_list,
          //     color: AppColors.cFF6F767E,
          //     size: 20,
          //   ),
          // ),
        ],
      ),
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

  Widget _buildDataTable(
    BuildContext context,
    List<Map<String, dynamic>> documents,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
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
              fontSize: 13,
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
            border: TableBorder(horizontalInside: BorderSide.none),
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
                id: doc['id'] ?? '',
                driverName: doc['driverName'] ?? '',
                documents: doc['documents'] ?? '',
                category: doc['category'] ?? '',
                categoryColor: doc['categoryColor'] ?? Colors.grey,
                categoryTextColor: doc['categoryTextColor'] ?? Colors.black,
                status: doc['status'] ?? '',
                statusColor: doc['statusColor'] ?? Colors.grey,
                dateTime: doc['dateTime'] ?? '',
              );
            }).toList(),
          ),
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
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            driverName,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            documents,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: AppColors.cFF6F767E,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: AppTypography.base.copyWith(
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
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.cFF6F767E,
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
                    category: category,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.visibility_outlined,
              color: AppColors.cFF6F767E,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(int total) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1-${total > 10 ? 10 : total} of $total documents',
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
    const trendColor = AppColors.cFF22C55E; // Green from mockup
    const trendIcon = Icons.trending_up;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isActive
                  ? AppColors.primary
                  : AppColors.transparent, // 👈 Hide when not selected
              width: 4, // Thickness of left border
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   width: 3,
                //   color: isActive ? AppColors.primary : AppColors.transparent,
                // ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
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
                                Icon(
                                  trendIcon,
                                  size: 14,
                                  color: AppColors.cFF22C55E,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  trend,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.cFF22C55E,
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
