import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class RateCardHistoryPage extends StatefulWidget {
  const RateCardHistoryPage({super.key});

  @override
  State<RateCardHistoryPage> createState() => _RateCardHistoryPageState();
}

class _RateCardHistoryPageState extends State<RateCardHistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'TOTAL PARTICIPATING',
                  value: '1,248',
                  subtitle: 'Drivers',
                  borderColor: AppColors.primary,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  title: 'COMPLETED TARGET',
                  value: '848',
                  subtitle: 'Total Payout: ₹21,22,500',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  title: 'PENDING PROGRESS',
                  value: '400',
                  subtitle: 'Focusing on high-probability completions',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Main Table Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF1F3F5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Header / Search
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Search field
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFEAECF0)),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name, email or phone...',
                              hintStyle: AppTypography.base.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Status dropdown
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEAECF0)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'All Status',
                              style: AppTypography.base.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Export button
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.file_download_outlined,
                          size: 18,
                        ),
                        label: const Text('Export Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          textStyle: AppTypography.base.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Data Table
                SizedBox(width: double.infinity, child: _buildHistoryTable()),

                // Pagination
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? const Color(0xFFF1F3F5),
          width: borderColor != null ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTypography.base.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.base.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: const Color(0xFFF1F3F5)),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
        columnSpacing: 24,
        headingRowHeight: 56,
        dataRowHeight: 80,
        columns: [
          _buildColumn('DATE & TIME'),
          _buildColumn('ADMIN NAME'),
          _buildColumn('CITY'),
          _buildColumn('VEHICLE CATEGORY'),
          _buildColumn('DESCRIPTION'),
          _buildColumn('ACTION'),
        ],
        rows: [
          _buildRow(
            'Oct 23, 2026',
            '10:45 AM',
            'Sanjay Mehra',
            'Chennai',
            'Cab Premium',
            Icons.local_taxi_outlined,
            'Base fare increased by ₹5 due to peak s...',
          ),
          _buildRow(
            'Oct 23, 2026',
            '02:15 PM',
            'Alex Johnson',
            'Madurai',
            'Bike',
            Icons.two_wheeler_outlined,
            'Minimum distance for surge pricing chan...',
          ),
          _buildRow(
            'Oct 23, 2026',
            '09:30 AM',
            'Riya Kapoor',
            'Coimbatore',
            'Auto',
            Icons.electric_rickshaw_outlined,
            'Waiting charges reduced by 15% for off-...',
          ),
          _buildRow(
            'Oct 23, 2026',
            '11:10 AM',
            'Sanjay Mehra',
            'Chennai',
            'Cab Economy',
            Icons.local_taxi_outlined,
            'New per-km rate (₹18) applied for night ...',
          ),
          _buildRow(
            'Oct 23, 2026',
            '05:40 PM',
            'Riya Kapoor',
            'Tiruchirappalli',
            'SUV',
            Icons.directions_car_outlined,
            'Airport pickup surcharges updated for la...',
          ),
        ],
      ),
    );
  }

  DataColumn _buildColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: AppTypography.base.copyWith(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  DataRow _buildRow(
    String date,
    String time,
    String admin,
    String city,
    String category,
    IconData icon,
    String description,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                time,
                style: AppTypography.base.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            admin,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        DataCell(
          Text(
            city,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(
                category,
                style: AppTypography.base.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          SizedBox(
            width: 300,
            child: Text(
              description,
              style: AppTypography.base.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 20),
            color: const Color(0xFF98A2B3),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Showing 1 to 5 of 142 updates',
            style: AppTypography.base.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          // Pagination controls
          _buildPageButton(
            icon: Icons.chevron_left,
            isActive: false,
            isIcon: true,
          ),
          const SizedBox(width: 4),
          _buildPageButton(label: '1', isActive: true),
          const SizedBox(width: 4),
          _buildPageButton(label: '2'),
          const SizedBox(width: 4),
          _buildPageButton(label: '3'),
          const SizedBox(width: 4),
          const Text('...', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          _buildPageButton(label: '29'),
          const SizedBox(width: 4),
          _buildPageButton(
            icon: Icons.chevron_right,
            isActive: false,
            isIcon: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton({
    IconData? icon,
    String label = '',
    bool isActive = false,
    bool isIcon = false,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: isActive ? null : Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Center(
        child: isIcon && icon != null
            ? Icon(icon, size: 18, color: AppColors.textSecondary)
            : Text(
                label,
                style: AppTypography.base.copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
      ),
    );
  }
}
