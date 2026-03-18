import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/total_tickets_cubit.dart';
import '../../cubit/total_tickets_state.dart';

class TotalTicketsControls extends StatelessWidget {
  final TotalTicketsState state;

  const TotalTicketsControls({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: TextField(
              onChanged: (v) =>
                  context.read<TotalTicketsCubit>().searchTickets(v),
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
          SizedBox(width: 24),
          Expanded(
            flex: 2,
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
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: _buildDropdown(
              'issue category',
              'issue category',
              (val) {},
              [],
            ),
          ),
          SizedBox(width: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFEFEFEF),
            ),
            child: Icon(
              Icons.filter_list,
              color: AppColors.cFF6F767E,
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : null,
          isExpanded: true,
          hint: Text(
            hint,
            style: AppTypography.base.copyWith(
              color: AppColors.cFF6F767E,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.cFF6F767E,
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
}
