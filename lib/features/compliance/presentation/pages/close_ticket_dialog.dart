import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CloseTicketDialog extends StatelessWidget {
  final String ticketId;
  final VoidCallback? onSuccess;

  CloseTicketDialog({super.key, required this.ticketId, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: AppColors.transparent,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cFFF0FAF8,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Close Ticket #$ticketId',
                    style: AppTypography.h3.copyWith(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: AppColors.grey, size: 20),
                ),
              ],
            ),
          ),
          Divider(height: 1),

          // Body
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Resolution Category', isRequired: true),
                SizedBox(height: 8),
                _buildDropdownField('Select Reason'),
                SizedBox(height: 24),
                _buildLabel('Final Internal Notes'),
                SizedBox(height: 8),
                _buildTextArea(
                  'Enter detailed resolution notes for internal tracking...',
                ),
              ],
            ),
          ),

          Divider(height: 1),

          // Footer
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onSuccess != null) {
                      onSuccess!();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('CONFIRM & CLOSE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (isRequired)
          Text(
            ' *',
            style: AppTypography.base.copyWith(color: AppColors.red, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: AppTypography.bodySmall.copyWith(color: AppColors.grey),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
        ],
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: SizedBox(
        height: 100,
        child: TextField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.grey),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}




