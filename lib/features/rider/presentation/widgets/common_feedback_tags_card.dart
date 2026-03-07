import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CommonFeedbackTagsCard extends StatefulWidget {
  const CommonFeedbackTagsCard({super.key});

  @override
  State<CommonFeedbackTagsCard> createState() => _CommonFeedbackTagsCardState();
}

class _CommonFeedbackTagsCardState extends State<CommonFeedbackTagsCard> {
  String _selectedFilter = 'Last 6 Months';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Common Feedback Tags',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEFEFEF)),
                  ),
                  child: PopupMenuButton<String>(
                    offset: const Offset(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFEFEFEF)),
                    ),
                    color: Colors.white,
                    elevation: 6,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedFilter,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1D1F),
                          ),
                        ),
                        const SizedBox(width: 32),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: Color(0xFF6F767E),
                        ),
                      ],
                    ),
                    onSelected: (val) {
                      setState(() {
                        _selectedFilter = val;
                      });
                    },
                    itemBuilder: (context) => [
                      _buildPopupItem('Hourly', _selectedFilter == 'Hourly'),
                      _buildPopupItem('Today', _selectedFilter == 'Today'),
                      _buildPopupItem(
                        'Last Week',
                        _selectedFilter == 'Last Week',
                      ),
                      _buildPopupItem(
                        'Last 30 Months',
                        _selectedFilter == 'Last 30 Months',
                      ),
                      _buildPopupItem(
                        'Last 6 Months',
                        _selectedFilter == 'Last 6 Months',
                      ),
                      _buildPopupItem(
                        'Last 1 Year',
                        _selectedFilter == 'Last 1 Year',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                _buildTag(
                  'Polite Driver',
                  20,
                  FontWeight.w800,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Clean Car',
                  16,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
                _buildTag(
                  'Smooth Ride',
                  18,
                  FontWeight.bold,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Professional',
                  12,
                  FontWeight.w600,
                  const Color(0xFF94A3B8),
                ), // Light grey text
                _buildTag(
                  'Great Route',
                  22,
                  FontWeight.w900,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Safe Driving',
                  14,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
                _buildTag(
                  'Punctual',
                  10,
                  FontWeight.w800,
                  AppColors.textPrimary,
                ),
                _buildTag('Music', 16, FontWeight.bold, AppColors.textPrimary),
                _buildTag(
                  'Helpful',
                  18,
                  FontWeight.bold,
                  AppColors.textPrimary,
                ),
                _buildTag(
                  'Quick Pickup',
                  12,
                  FontWeight.bold,
                  const Color(0xFF94A3B8),
                ),
                _buildTag(
                  'Fair Price',
                  14,
                  FontWeight.bold,
                  AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? const Color(0xFFF4Fdf8) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF00A86B),
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(
    String text,
    double fontSize,
    FontWeight weight,
    Color color,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        height: 1.0,
      ),
    );
  }
}
