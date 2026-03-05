import 'package:flutter/material.dart';

import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalDocumentsScreen extends StatelessWidget {
  const TotalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Compliance - Total Documents',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatCardsRow(),
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
                  _buildControlsRow(),
                  const Divider(height: 1),
                  _buildDataTable(context),
                  const Divider(height: 1),
                  _buildPagination(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCardsRow() {
    return Row(
      children: [
        Expanded(
          child: _TopStatCard(
            title: 'NEW DOCUMENTS',
            value: '4.2K',
            trend: '+2.2%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'REJECTED DOCUMENTS',
            value: '100',
            trend: '+2.1%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'RESEND DOCUMENTS',
            value: '140',
            trend: '+5.2%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'VERIFIED DOCUMENTS',
            value: '4.2K',
            trend: '+2.2%',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildControlsRow() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildTextField('Search Ticket ID or Name...', Icons.search),
          ),
          const SizedBox(width: 24),
          const Spacer(),
          SizedBox(width: 180, child: _buildDropdown('All Categories')),
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
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
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
          items: const [],
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
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
          rows: [
            _buildDataRow(
              id: '#DOC-8801',
              driverName: 'Vikram Seth',
              documents: 'DRIVING LICENSE',
              category: 'RESEND',
              categoryColor: const Color(0xFFFFF7ED),
              categoryTextColor: const Color(0xFFC2410C),
              status: 'Pending',
              statusColor: const Color(0xFFF97316),
              dateTime: '04 Nov 2025\n05:20 PM',
            ),
            _buildDataRow(
              id: '#DOC-8798',
              driverName: 'Anita Mehra',
              documents: 'ALL DOCUMENTS',
              category: 'NEW DRIVER',
              categoryColor: const Color(0xFFEFF6FF),
              categoryTextColor: const Color(0xFF1D4ED8),
              status: 'Pending',
              statusColor: const Color(0xFFF97316),
              dateTime: '04 Nov 2025\n04:15 PM',
            ),
            _buildDataRow(
              id: '#DOC-8795',
              driverName: 'Sam Yogi',
              documents: 'VEHICLE RC',
              category: 'REJECTED',
              categoryColor: const Color(0xFFFEF2F2),
              categoryTextColor: const Color(0xFFB91C1C),
              status: 'Rejected',
              statusColor: const Color(0xFFEF4444),
              dateTime: '04 Nov 2025\n03:45 PM',
            ),
            _buildDataRow(
              id: '#DOC-8792',
              driverName: 'Kabir Singh',
              documents: 'ALL DOCUMENTS',
              category: 'VERIFIED',
              categoryColor: const Color(0xFFF0FDF4),
              categoryTextColor: const Color(0xFF15803D),
              status: 'Approved',
              statusColor: const Color(0xFF22C55E),
              dateTime: '04 Nov 2025\n02:10 PM',
            ),
            _buildDataRow(
              id: '#DOC-8789',
              driverName: 'Zara Khan',
              documents: 'ALL DOCUMENTS',
              category: 'VERIFIED',
              categoryColor: const Color(0xFFF0FDF4),
              categoryTextColor: const Color(0xFF15803D),
              status: 'Approved',
              statusColor: const Color(0xFF22C55E),
              dateTime: '04 Nov 2025\n01:30 PM',
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow({
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
          Icon(Icons.visibility_outlined, color: Color(0xFF6F767E), size: 20),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 1-10 of 4,842 documents',
            style: TextStyle(
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

  const _TopStatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = const Color(0xFF22C55E); // Green from mockup
    const trendIcon = Icons.trending_up;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
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
                  const Icon(trendIcon, size: 14, color: Color(0xFF22C55E)),
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
    );
  }
}
