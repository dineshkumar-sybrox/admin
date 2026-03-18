import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import 'package:admin/features/rider/presentation/widgets/refund_success_dialog.dart';

class RefundTicketPage extends StatefulWidget {
  final String ticketId;
  final String rideId;
  final bool wrapWithScaffold;
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;

  RefundTicketPage({
    super.key,
    required this.ticketId,
    required this.rideId,
    this.wrapWithScaffold = true,
    this.onCancel,
    this.onSuccess,
  });

  @override
  State<RefundTicketPage> createState() => _RefundTicketPageState();
}

class _RefundTicketPageState extends State<RefundTicketPage> {
  String selectedRefundMethod = 'wallet';
  String selectedReason = 'Driver Detour';
  final TextEditingController amountController = TextEditingController(
    text: '125.00',
  );
  final TextEditingController notesController = TextEditingController(
    text:
        "Hello Rahul, we've reviewed your ride and noticed the driver took an unnecessary detour. We're refunding you for the excess fare charged. Apologies for the hassle.",
  );

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        // Sub-header area
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: widget.onCancel,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          ' Back to Ticket',
                          style: AppTypography.base.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Refund for Ticket ',
                        style: AppTypography.base.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        widget.ticketId,
                        style: AppTypography.base.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 4),
                      RichText(
                        text: TextSpan(
                          text: 'Linked Ride ID: ',
                          style: AppTypography.base.copyWith(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: widget.rideId,
                              style: AppTypography.base.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cFFFEF3C7, // Light yellow/orange
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'ACTION REQUIRED',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cFFD97706, // Dark orange
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: AppColors.divider),

        // Main Content Scrollable Area
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ORIGINAL FARE BREAKDOWN Card
                _buildFareBreakdownCard(),
                SizedBox(height: 24),

                // Two Column Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Refund Calculator
                    Expanded(flex: 2, child: _buildRefundCalculatorCard()),
                    SizedBox(width: 24),

                    // Right Column: Refund Method
                    Expanded(flex: 1, child: _buildRefundMethodCard()),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Bottom Footer bar
        _buildFooter(context),
      ],
    );

    if (widget.wrapWithScaffold) {
      return AdminScaffold(title: 'Refund Process', body: body);
    }

    return body;
  }

  Widget _buildFareBreakdownCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.divider.withValues(alpha: 0.4),
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 8),
                Text(
                  'ORIGINAL FARE BREAKDOWN',
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFareItem('DISTANCE FARE', '₹300.00'),
                _buildFareItem(
                  'TIME (3 MINS DELAY)',
                  '₹2',
                ), // As per screenshot, odd value but mirroring it
                _buildFareItem('SURGE', '₹50.00'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL CHARGED',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹352.00',
                        style: AppTypography.base.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.base.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: AppTypography.base.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRefundCalculatorCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              SizedBox(width: 8),
              Text(
                'Refund Calculator',
                style: AppTypography.base.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Refund Amount (₹)',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        prefixText: '₹ ',
                        prefixStyle: AppTypography.base.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
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
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Suggested refund based on detour: ₹125.00',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Refund',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                        ), // Active border in screenshot
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
                              [
                                    'Driver Detour',
                                    'App Glitch',
                                    'Service Failure',
                                    'Incorrect Surge Pricing',
                                    'Safety Issue',
                                  ]
                                  .map(
                                    (reason) => DropdownMenuItem(
                                      value: reason,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            reason,
                                            style: AppTypography.base.copyWith(
                                              fontSize: 14,
                                              color: reason == 'Driver Detour'
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                              fontWeight:
                                                  reason == 'Driver Detour'
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                          if (reason == 'Driver Detour')
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 16,
                                              color: AppColors.primary,
                                            ),
                                        ],
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
          Text(
            'Customer-facing Notes',
            style: AppTypography.base.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: notesController,
            maxLines: 4,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
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
            style: AppTypography.base.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefundMethodCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REFUND METHOD',
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 16),

          // Wallet Refund Option
          InkWell(
            onTap: () => setState(() => selectedRefundMethod = 'wallet'),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedRefundMethod == 'wallet'
                      ? AppColors.primary
                      : AppColors.divider,
                  width: selectedRefundMethod == 'wallet' ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: selectedRefundMethod == 'wallet'
                    ? AppColors.cFFF0FDF4
                    : AppColors.white, // Very light mint if active
              ),
              child: Row(
                children: [
                  Icon(
                    selectedRefundMethod == 'wallet'
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: selectedRefundMethod == 'wallet'
                        ? AppColors.primary
                        : AppColors.divider,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet Refund',
                          style: AppTypography.base.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Instant credit to user wallet',
                          style: AppTypography.base.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: selectedRefundMethod == 'wallet'
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          // Bank Transfer Option
          InkWell(
            onTap: () => setState(() => selectedRefundMethod = 'bank'),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedRefundMethod == 'bank'
                      ? AppColors.primary
                      : AppColors.divider,
                  width: selectedRefundMethod == 'bank' ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: selectedRefundMethod == 'bank'
                    ? AppColors.cFFF0FDF4
                    : AppColors.white,
              ),
              child: Row(
                children: [
                  Icon(
                    selectedRefundMethod == 'bank'
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: selectedRefundMethod == 'bank'
                        ? AppColors.primary
                        : AppColors.divider,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Transfer',
                          style: AppTypography.base.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Takes 5-7 business days',
                          style: AppTypography.base.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.credit_card_outlined,
                    color: selectedRefundMethod == 'bank'
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 32),
          Divider(height: 1, color: AppColors.divider),
          SizedBox(height: 24),

          // Summary calculations
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Collect Amount',
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '₹452.00',
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Final Fare',
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '₹352.00',
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Refund Amount',
                style: AppTypography.base.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '₹100.00', // Note: This doesn't match the 125 input in screenshot but matches UI text lower down. Sticking to screenshot text.
                style: AppTypography.base.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // Green color as per screenshot
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8),
              Text(
                'This action cannot be undone once processed.',
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.divider),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.scaffoldBackground,
                ),
                child: Text(
                  'Cancel',
                  style: AppTypography.base.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Process refund logic (API call would go here)
                  if (widget.onSuccess != null) {
                    widget.onSuccess!();
                  }

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => RefundSuccessDialog(
                      ticketId: widget.ticketId.replaceAll(
                        '#',
                        '',
                      ), // Clean up for UI
                      rideId: widget.rideId,
                      refundAmount: amountController.text,
                      onBackToTicket: () {
                        Navigator.of(context).pop(); // Close dialog
                        if (widget.onCancel != null) {
                          widget.onCancel!(); // Return to ticket view
                        }
                      },
                      onViewWalletLogs: () {
                        Navigator.of(context).pop(); // Close dialog
                        // Navigate to wallet logs or switch tab (not fully implemented yet)
                        if (widget.onCancel != null) {
                          widget.onCancel!();
                        }
                      },
                    ),
                  );
                },
                icon: Icon(Icons.check_circle_outline, size: 18),
                label: Text('Process Refund'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
