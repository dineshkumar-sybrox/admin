import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class ReasonsForCancellation extends StatefulWidget {
  ReasonsForCancellation({super.key});

  @override
  State<ReasonsForCancellation> createState() => _ReasonsForCancellationState();
}

class _ReasonsForCancellationState extends State<ReasonsForCancellation> {
  String _selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reasons for Cancellation',
                    style: AppTypography.base.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF1A1D1F,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Breakdown of user-reported reasons',
                    style: AppTypography.base.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFF9EA5AD,
                    ),
                  ),
                ],
              ),
              _buildDropdown(),
            ],
          ),
          SizedBox(height: 48),
          _buildReasonBar('Driver No Show', 0.53, AppColors.cFF00C46B),
          SizedBox(height: 32),
          _buildReasonBar(
            'Wrong Pickup Location',
            0.35,
            AppColors.cFF19B277,
          ),
          SizedBox(height: 32),
          _buildReasonBar('Long Wait Time', 0.18, AppColors.cFF8CE0B9),
          SizedBox(height: 32),
          _buildReasonBar('Technical Issue', 0.07, AppColors.cFFB1E7CE),
          SizedBox(height: 32),
          _buildReasonBar('Other Reasons', 0.05, AppColors.cFFD8F1EB),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReasonBar(String title, double progress, Color color) {
    final int percentage = (progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            if (percentage < 30) // if small show percentage top right
              Text(
                '$percentage%',
                style: AppTypography.base.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
          ],
        ),
        SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.cFFF4F6F9,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(width: 32),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: AppColors.cFF6F767E,
            ),
          ],
        ),
        onSelected: (val) {
          setState(() {
            _selectedFilter = val;
          });
        },
        itemBuilder: (context) => [
          _buildPopupItem('Today', _selectedFilter == 'Today'),
          _buildPopupItem('Last 15 Days', _selectedFilter == 'Last 15 Days'),
          _buildPopupItem('Last 30 Days', _selectedFilter == 'Last 30 Days'),
          _buildPopupItem('Last 6 Months', _selectedFilter == 'Last 6 Months'),
          _buildPopupItem('Last 1 Year', _selectedFilter == 'Last 1 Year'),
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
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.cFF00A86B,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}



