import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class DriversTableHeader extends StatefulWidget {
  DriversTableHeader({super.key});

  @override
  State<DriversTableHeader> createState() => _DriversTableHeaderState();
}

class _DriversTableHeaderState extends State<DriversTableHeader> {
  String _selectedFilter = 'All Status';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
          SizedBox(
            width: 380,
            height: 44,
            child: TextField(
              controller: searchController,
              onChanged: (v) => context.read<DriversManagementCubit>().search(v),
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
         
          // Filters and Actions
          Row(
            children: [
              // All Status Dropdown
              
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

                    context.read<DriversManagementCubit>().setStatusFilter(newValue);
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
              BlocBuilder<DriversManagementCubit, DriversManagementState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: state.isExporting
                        ? null
                        : () => context
                              .read<DriversManagementCubit>()
                              .exportToExcel(),
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
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
