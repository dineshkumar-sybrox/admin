import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class RefundSuccessDialog extends StatelessWidget {
  final String ticketId;
  final String rideId;
  final String refundAmount;
  final VoidCallback onBackToTicket;
  final VoidCallback onViewWalletLogs;

  RefundSuccessDialog({
    super.key,
    required this.ticketId,
    required this.rideId,
    required this.refundAmount,
    required this.onBackToTicket,
    required this.onViewWalletLogs,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: AppColors.transparent,
      child: Container(
        width: 480,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cFFF0FDF4, // light green bg
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            SizedBox(height: 24),

            // Title
            Text(
              'Refund Processed Successfully',
              style: AppTypography.base.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),

            // Subtitle IDs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4),
                Text(
                  'Ticket $ticketId',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '•',
                  style: AppTypography.base.copyWith(color: AppColors.textSecondary),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.directions_car_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4),
                Text(
                  'Ride ID $rideId',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Details Box
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REFUND AMOUNT',
                              style: AppTypography.base.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹$refundAmount',
                              style: AppTypography.base.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'TRANSACTION ID',
                              style: AppTypography.base.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'TXN_882910',
                              style: AppTypography.base.copyWith(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),

                        // Right Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'DESTINATION',
                              style: AppTypography.base.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'User Wallet',
                                  style: AppTypography.base.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 32,
                            ), // Add visual space to align
                            Text(
                              'STATUS',
                              style: AppTypography.base.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cFFD1FAE5, // Light green
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'CREDITED',
                                    style: AppTypography.base.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: AppColors.divider),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Processed at Oct 24, 2023 • 14:45 PM by Admin System',
                          style: AppTypography.base.copyWith(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onBackToTicket,
                    icon: Icon(Icons.arrow_back, size: 16),
                    label: Text('Back to Ticket'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onViewWalletLogs,
                    icon: Icon(Icons.history, size: 16),
                    label: Text('View Wallet Logs'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: BorderSide(color: AppColors.divider),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Footer Text
            Text(
              'A notification has been sent to the customer regarding this refund.',
              style: AppTypography.base.copyWith(fontSize: 12, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}




