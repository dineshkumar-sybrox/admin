import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/total_tickets_cubit.dart';
import '../../cubit/total_tickets_state.dart';

class TotalTicketsControls extends StatefulWidget {
  final TotalTicketsState state;

  const TotalTicketsControls({super.key, required this.state});

  @override
  State<TotalTicketsControls> createState() => _TotalTicketsControlsState();
}

class _TotalTicketsControlsState extends State<TotalTicketsControls> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'All Categories';

  final List<String> items = [
    'All Categories',
    'BILLING ISSUE',
    'SAFETY',
    'APP GLITCH',
    'PAYMENT ERROR',
    'REFUND',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          /// 🔍 Search Field
          SizedBox(
            width: 300,
            height: 40,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<TotalTicketsCubit>().searchTickets(value);
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
                context.read<TotalTicketsCubit>().filterByCategory(value);
              },
              itemBuilder: (context) => [
                _buildPopupItem(
                  'All Categories',
                  _selectedCategory == 'All Categories',
                ),
                _buildPopupItem(
                  'BILLING ISSUE',
                  _selectedCategory == 'BILLING ISSUE',
                ),
                _buildPopupItem('SAFETY', _selectedCategory == 'SAFETY'),
                _buildPopupItem(
                  'APP GLITCH',
                  _selectedCategory == 'APP GLITCH',
                ),
                _buildPopupItem(
                  'PAYMENT ERROR',
                  _selectedCategory == 'PAYMENT ERROR',
                ),
                _buildPopupItem(
                  'REFUND',
                  _selectedCategory == 'REFUND',
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
        ],
      ),
    );
  }

  /// ✅ Popup Menu Item Widget
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
}
