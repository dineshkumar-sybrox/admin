import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/rate_card_update_dialog.dart';

class RateCardHistoryPage extends StatefulWidget {
  const RateCardHistoryPage({super.key});

  @override
  State<RateCardHistoryPage> createState() => _RateCardHistoryPageState();
}

class _RateCardHistoryPageState extends State<RateCardHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedVehicle = 'All';

  final List<_HistoryRow> _allRows = const [
    _HistoryRow(
      date: 'Oct 23, 2026',
      time: '10:45 AM',
      admin: 'Sanjay Mehra',
      city: 'Chennai',
      category: 'Cab Premium',
      icon: Icons.local_taxi_outlined,
      description: 'Base fare increased by ₹5 due to peak s...',
    ),
    _HistoryRow(
      date: 'Oct 23, 2026',
      time: '02:15 PM',
      admin: 'Alex Johnson',
      city: 'Madurai',
      category: 'Bike',
      icon: Icons.two_wheeler_outlined,
      description: 'Minimum distance for surge pricing chan...',
    ),
    _HistoryRow(
      date: 'Oct 23, 2026',
      time: '09:30 AM',
      admin: 'Riya Kapoor',
      city: 'Coimbatore',
      category: 'Auto',
      icon: Icons.electric_rickshaw_outlined,
      description: 'Waiting charges reduced by 15% for off-...',
    ),
    _HistoryRow(
      date: 'Oct 23, 2026',
      time: '11:10 AM',
      admin: 'Sanjay Mehra',
      city: 'Chennai',
      category: 'Cab Economy',
      icon: Icons.local_taxi_outlined,
      description: 'New per-km rate (₹18) applied for night ...',
    ),
    _HistoryRow(
      date: 'Oct 23, 2026',
      time: '05:40 PM',
      admin: 'Riya Kapoor',
      city: 'Tiruchirappalli',
      category: 'Cab',
      icon: Icons.directions_car_outlined,
      description: 'Airport pickup surcharges updated for la...',
    ),
  ];

  static const List<RateCardChange> _sampleChanges = [
    RateCardChange(
      parameter: 'Base Fare',
      previousValue: '₹20',
      newValue: '₹25',
    ),
    RateCardChange(
      parameter: 'Night Surcharge',
      previousValue: '25%',
      newValue: '30%',
    ),
    RateCardChange(
      parameter: 'Platform Commission',
      previousValue: '20%',
      newValue: '20%',
    ),
    RateCardChange(
      parameter: 'GST',
      previousValue: '5%',
      newValue: '5%',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredRows = _allRows.where((r) {
      final matchesSearch = query.isEmpty ||
          r.admin.toLowerCase().contains(query) ||
          r.city.toLowerCase().contains(query) ||
          r.category.toLowerCase().contains(query) ||
          r.description.toLowerCase().contains(query);
      final matchesVehicle = _selectedVehicle == 'All' ||
          r.category.toLowerCase().contains(_selectedVehicle.toLowerCase());
      return matchesSearch && matchesVehicle;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  padding: const EdgeInsets.all(14),
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
                            onChanged: (_) => setState(() {}),
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedVehicle,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _selectedVehicle = value);
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                            ),
                            style: AppTypography.base.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'All',
                                child: Text('All Vehicles'),
                              ),
                              DropdownMenuItem(
                                value: 'Cab',
                                child: Text('Cab'),
                              ),
                              DropdownMenuItem(
                                value: 'Auto',
                                child: Text('Auto'),
                              ),
                              DropdownMenuItem(
                                value: 'Bike',
                                child: Text('Bike'),
                              ),
                            ],
                          ),
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
                SizedBox(
                  width: double.infinity,
                  child: _buildHistoryTable(filteredRows),
                ),

                // Pagination
                Divider(color: AppColors.divider),
                _buildPagination(
                  filteredCount: filteredRows.length,
                  totalCount: _allRows.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openUpdateDialog(_HistoryRow row) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return RateCardUpdateDialog(
          adminName: row.admin,
          date: row.date,
          time: row.time,
          city: row.city,
          vehicleCategory: row.category,
          vehicleIcon: row.icon,
          changes: _sampleChanges,
          description:
              'Base fare increased by ₹5 due to peak season demand in Chennai central zones.',
        );
      },
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

  Widget _buildHistoryTable(List<_HistoryRow> rows) {
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
              fontSize: 20,
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
            border: TableBorder(
              horizontalInside: BorderSide(
                color: AppColors.cFFF3F4F6,
                width: 1,
              ),
            ),
            columns: [
              _buildColumn('DATE & TIME'),
              _buildColumn('ADMIN NAME'),
              _buildColumn('CITY'),
              _buildColumn('VEHICLE CATEGORY'),
              _buildColumn('DESCRIPTION'),
              _buildColumn('ACTION'),
            ],
            rows: rows
                .map(
                  (r) => _buildRow(
                    r.date,
                    r.time,
                    r.admin,
                    r.city,
                    r.category,
                    r.icon,
                    r.description,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  DataColumn _buildColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: AppTypography.base.copyWith(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
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
                  fontSize: 14,
                ),
              ),
              Text(
                time,
                style: AppTypography.base.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
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
              fontSize: 14,
            ),
          ),
        ),
        DataCell(
          Text(
            city,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
                  fontSize: 14,
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
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 20),
            color: const Color(0xFF98A2B3),
            onPressed: () {
              _openUpdateDialog(
                _HistoryRow(
                  date: date,
                  time: time,
                  admin: admin,
                  city: city,
                  category: category,
                  icon: icon,
                  description: description,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPagination({
    required int filteredCount,
    required int totalCount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cFFF8FAFC,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Text(
              'Showing $filteredCount of $totalCount updates',
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

class _HistoryRow {
  final String date;
  final String time;
  final String admin;
  final String city;
  final String category;
  final IconData icon;
  final String description;

  const _HistoryRow({
    required this.date,
    required this.time,
    required this.admin,
    required this.city,
    required this.category,
    required this.icon,
    required this.description,
  });
}

