import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_cubit.dart';
import '../cubit/rider_state.dart';
import '../widgets/rider_stat_cards.dart';
import '../widgets/rider_table.dart';
import '../widgets/suspended_riders_table.dart';

class RiderScreen extends StatelessWidget {
  RiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RiderCubit()..loadRiders(),
      child: const _RiderScreenBody(),
    );
  }
}

class _RiderScreenBody extends StatefulWidget {
  const _RiderScreenBody();

  @override
  State<_RiderScreenBody> createState() => _RiderScreenBodyState();
}

class _RiderScreenBodyState extends State<_RiderScreenBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiderCubit, RiderState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RiderStatCards(),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cFFE5E7EB),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SearchFilterBar(searchController: _searchController),
                    Divider(height: 1, color: AppColors.cFFE5E7EB),
                    if (state.selectedTab == RiderTab.suspended)
                      SuspendedRidersTable(state: state)
                    else
                      RiderTable(state: state),
                    Divider(height: 1, color: AppColors.cFFE5E7EB),
                    Container(
                      color: AppColors.cFFF8FAFC,
                      child: _Pagination(state: state),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchFilterBar extends StatefulWidget {
  final TextEditingController searchController;

  const _SearchFilterBar({required this.searchController});

  @override
  State<_SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<_SearchFilterBar> {
  String _selectedFilter = 'All Status';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Box
          SizedBox(
            width: 380,
            height: 44,
            child: TextField(
              controller: searchController,
              onChanged: (v) => context.read<RiderCubit>().search(v),
              decoration: InputDecoration(
                hintText: 'Search by name, email or phone...',
                hintStyle: AppTypography.base.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.cFFF1F5F9,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),

          Row(
            children: [
              // Status Dropdown
              Container(
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cFFF1F5F9,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.cFFEFEFEF),
                ),
                child: PopupMenuButton<String>(
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.cFFEFEFEF),
                  ),
                  color: AppColors.white,
                  elevation: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedFilter,
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cFF1A1D1F,
                        ),
                      ),
                      SizedBox(width: 32),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.cFF6F767E,
                      ),
                    ],
                  ),
                  onSelected: (String newValue) {
                    setState(() {
                      _selectedFilter = newValue;
                    });

                    context.read<RiderCubit>().setStatusFilter(newValue);
                  },
                  itemBuilder: (context) => [
                    _buildPopupItem(
                      'All Status',
                      _selectedFilter == 'All Status',
                    ),
                    _buildPopupItem('Active', _selectedFilter == 'Active'),
                    _buildPopupItem('Inactive', _selectedFilter == 'Inactive'),
                    _buildPopupItem(
                      'Suspended',
                      _selectedFilter == 'Suspended',
                    ),
                  ],
                ),
              ),

              SizedBox(width: 16),

              // Export Button
              BlocBuilder<RiderCubit, RiderState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: state.isExporting
                          ? null
                          : () => context.read<RiderCubit>().exportToExcel(),
                      icon: state.isExporting
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : Icon(
                              Icons.download,
                              size: 18,
                              color: AppColors.white,
                            ),
                      label: Text(
                        state.isExporting ? 'Exporting...' : 'Export Data',
                        style: AppTypography.base.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success, // Green as per mock
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget _buildDropdown() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColors.cFFEFEFEF),
//       ),
//       child: PopupMenuButton<String>(
//         offset: Offset(0, 40),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: AppColors.cFFEFEFEF),
//         ),
//         color: AppColors.white,
//         elevation: 6,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               _selectedFilter,
//               style: AppTypography.base.copyWith(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.cFF1A1D1F,
//               ),
//             ),
//             SizedBox(width: 32),
//             Icon(
//               Icons.keyboard_arrow_down_rounded,
//               size: 16,
//               color: AppColors.cFF6F767E,
//             ),
//           ],
//         ),
//         onSelected: (val) {
//           setState(() {
//             _selectedFilter = val;
//           });
//         },
//         itemBuilder: (context) => [
//           _buildPopupItem('All Status', _selectedFilter == 'All Status'),
//           _buildPopupItem('Active', _selectedFilter == 'Active'),
//           _buildPopupItem('Inactive', _selectedFilter == 'Inactive'),
//           _buildPopupItem('Suspended', _selectedFilter == 'Suspended'),
//         ],
//       ),
//     );
//   }

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

class _Pagination extends StatelessWidget {
  final RiderState state;
  const _Pagination({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.filteredRiders.isEmpty) return SizedBox.shrink();

    // Showing dummy numbers as the mock shows "Showing 1 - 5 of 22,482 drivers" despite being Rider Screen
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing 1 - 5 of 22,482 drivers', // Replicated explicitly from mockup typo
            style: AppTypography.base.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              _PageButton(icon: Icons.chevron_left, onPressed: () {}),
              SizedBox(width: 8),
              _PageButton(label: '1', onPressed: () {}, isActive: true),
              SizedBox(width: 8),
              _PageButton(label: '2', onPressed: () {}),
              SizedBox(width: 8),
              _PageButton(label: '3', onPressed: () {}),
              SizedBox(width: 8),
              _PageButton(icon: Icons.chevron_right, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isActive;

  const _PageButton({
    this.label,
    this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.cFFE5E7EB,
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 16, color: AppColors.cFF6B7280)
            : Text(
                label!,
                style: AppTypography.base.copyWith(
                  color: isActive ? AppColors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
