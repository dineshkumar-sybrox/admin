import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';

class DriversTableHeader extends StatelessWidget {
  const DriversTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
          SizedBox(
            width: 380,
            height: 44,
            child: TextField(
              onChanged: (v) =>
                  context.read<DriversManagementCubit>().search(v),
              decoration: InputDecoration(
                hintText: 'Search by name, email or phone...',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.6),
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textSecondary.withOpacity(0.6),
                  size: 20,
                ),
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          // Filters and Actions
          Row(
            children: [
              // All Status Dropdown
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child:
                    BlocBuilder<DriversManagementCubit, DriversManagementState>(
                      buildWhen: (p, c) => p.statusFilter != c.statusFilter,
                      builder: (context, state) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.statusFilter,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            items:
                                [
                                  'All Status',
                                  'Active',
                                  'Offline',
                                  'Suspended',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<DriversManagementCubit>()
                                    .setStatusFilter(newValue);
                              }
                            },
                          ),
                        );
                      },
                    ),
              ),
              const SizedBox(width: 16),
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
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.download,
                            size: 18,
                            color: Colors.white,
                          ),
                    label: Text(
                      state.isExporting ? 'Exporting...' : 'Export Data',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
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
