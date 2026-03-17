import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class AdjustWalletDialog extends StatefulWidget {
  final String riderName;
  final String currentBalance;

  AdjustWalletDialog({
    super.key,
    required this.riderName,
    required this.currentBalance,
  });

  @override
  State<AdjustWalletDialog> createState() => _AdjustWalletDialogState();
}

class _AdjustWalletDialogState extends State<AdjustWalletDialog> {
  bool isAddMoney = true;
  String selectedReason = 'Incorrect Fare';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Adjust Wallet - ${widget.riderName}',
                  style: AppTypography.base.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Toggle Buttons
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => isAddMoney = true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          color: isAddMoney
                              ? AppColors.primary
                              : AppColors.divider,
                          width: isAddMoney ? 1.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: isAddMoney
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Add Money',
                            style: AppTypography.base.copyWith(
                              color: isAddMoney
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isAddMoney
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => isAddMoney = false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          color: !isAddMoney
                              ? AppColors.primary
                              : AppColors.divider,
                          width: !isAddMoney ? 1.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            size: 18,
                            color: !isAddMoney
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Add Coin',
                            style: AppTypography.base.copyWith(
                              color: !isAddMoney
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: !isAddMoney
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Amount & Reason
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AMOUNT (₹)',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '130',
                          hintStyle: AppTypography.base.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.divider),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.divider),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REASON',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.divider),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedReason,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                            ),
                            items:
                                ['Incorrect Fare', 'Refund', 'Penalty', 'Other']
                                    .map(
                                      (reason) => DropdownMenuItem(
                                        value: reason,
                                        child: Text(
                                          reason,
                                          style: AppTypography.base.copyWith(
                                            fontSize: 14,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedReason = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Admin Remarks
            Text(
              'ADMIN REMARKS',
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe the reason for adjustment...',
                hintStyle: AppTypography.base.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Current Balance
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Balance:',
                    style: AppTypography.base.copyWith(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '₹${widget.currentBalance}',
                    style: AppTypography.base.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm Adjustment',
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
                child: Text(
                  'Cancel',
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
