import 'package:flutter/material.dart';

import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TotalTicketsScreen extends StatelessWidget {
  const TotalTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Compliance - Total Tickets',
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
            title: 'OPEN TICKETS',
            value: '142',
            trend: '-5.2%',
            isPositive: false,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'CLOSED TICKETS',
            value: '100',
            trend: '+2.1%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _TopStatCard(
            title: 'REFUND AMOUNT',
            value: '₹4.2K',
            trend: '-2.2%',
            isPositive: false,
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
            flex: 2,
            child: _buildTextField(
              'Search by Ticket ID or Name...',
              Icons.search,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(flex: 1, child: _buildDropdown('All Categories')),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _buildDropdown('issue category')),
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
          minWidth:
              MediaQuery.of(context).size.width -
              64, // Subtracting outer padding
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            const Color(0xFFF4F6F9).withValues(alpha: 0.5),
          ),
          dataRowMaxHeight: 80,
          dataRowMinHeight: 80,
          horizontalMargin: 24,
          columnSpacing: 40, // Increased spacing
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
          rows: [
            _buildDataRow(
              id: '#TK-8842',
              personName: 'Vikram Seth',
              personType: 'Driver',
              category: 'BILLING ISSUE',
              status: 'IN-PROGRESS',
              statusColor: const Color(
                0xFFF2C94C,
              ), // Assuming yellow for in-progress based on generic UI
            ),
            _buildDataRow(
              id: '#TK-8839',
              personName: 'Anita Mehra',
              personType: 'Customer',
              category: 'SAFETY',
              status: 'OPEN',
              statusColor: const Color(0xFF2F80ED), // Assuming blue
            ),
            _buildDataRow(
              id: '#TK-8835',
              personName: 'Sam Yogi',
              personType: 'Driver',
              category: 'APP GLITCH',
              status: 'CLOSED',
              statusColor: const Color(0xFF00A86B), // Assuming Green
            ),
            _buildDataRow(
              id: '#TK-8831',
              personName: 'Kabir Singh',
              personType: 'Customer',
              category: 'PAYMENT ERROR',
              status: 'OPEN',
              statusColor: const Color(0xFF2F80ED),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required String id,
    required String personName,
    required String personType,
    required String category,
    required String status,
    required Color statusColor,
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

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 1-10 of 142 tickets',
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
    final trendColor = isPositive ? AppColors.primary : AppColors.error;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

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
    );
  }
}
