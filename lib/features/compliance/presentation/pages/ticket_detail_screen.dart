import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'close_ticket_dialog.dart';
import '../../../rider/presentation/pages/refund_ticket_page.dart';

class TicketDetailScreen extends StatefulWidget {
  final Map<String, dynamic> ticketData;

  TicketDetailScreen({super.key, required this.ticketData});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  bool _isRefunded = false;
  bool _isClosed = false;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Complaints',
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftPanel(context),
                VerticalDivider(width: 1, color: AppColors.grey.shade200),
                Expanded(child: _buildRightPanel(context)),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildLeftPanel(context),
                  Divider(height: 1),
                  _buildRightPanel(context),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLeftPanel(BuildContext context) {
    return Container(
      width: 350,
      padding: EdgeInsets.all(24.0),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.cFFE5E7EB,
                child: Icon(Icons.person, color: AppColors.grey),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.ticketData['personName'] ?? 'Anita Mehra',
                          style: AppTypography.h3.copyWith(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.activeTagBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'ACTIVE',
                            style: AppTypography.base.copyWith(
                              color: AppColors.activeTagText,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ID: ${widget.ticketData['id'] ?? 'RD-44921'}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.star, color: AppColors.amber, size: 16),
              SizedBox(width: 4),
              Text(
                '4.8',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '(2.4k Rides)',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildInfoRow(Icons.phone_outlined, '9021443372'),
          _buildInfoRow(Icons.email_outlined, 'Anita@gmail.com'),
          SizedBox(height: 32),
          Text(
            'DRIVER DETAILS',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          _buildDetailItem('RIDER', '#DRV-00278 (Vikram Seth)'),
          _buildDetailItem('RIDE ID', '#TRIP-990231'),
          _buildDetailItem('ESTIMATED FARE', '₹ 452.00'),
          _buildDetailItem(
            'ACTUAL COLLECTED',
            '₹ 352.00',
            valueColor: AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(BuildContext context) {
    return Container(
      color: AppColors.cFFF9FAFB,
      child: Column(
        children: [
          _buildChatHeader(context),
          Expanded(child: _buildChatHistory()),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildChatHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey.shade100)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Complaints & Resolution',
                      style: AppTypography.h3.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cFFF3F4F6,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'BILLING',
                        style: AppTypography.base.copyWith(
                          color: AppColors.cFF6B7280,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Ticket ID: #${widget.ticketData['id'] ?? 'TC-8839'}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (!_isClosed) ...[
            OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CloseTicketDialog(
                    ticketId: widget.ticketData['id'] ?? 'TC-8839',
                    onSuccess: () {
                      setState(() {
                        _isClosed = true;
                      });
                    },
                  ),
                );
              },
              icon: Icon(Icons.check_circle_outline, size: 18),
              label: Text('CLOSE TICKET'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(color: AppColors.divider),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            if (!_isRefunded) ...[
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RefundTicketPage(
                        ticketId: widget.ticketData['id'] ?? 'TK-8839',
                        rideId:
                            '#TRIP-990231', // Mock ride ID as seen in mockup
                        onCancel: () => Navigator.pop(context),
                        onSuccess: () {
                          setState(() {
                            _isRefunded = true;
                          });
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 18,
                ),
                label: Text('Issue Refund'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildChatHistory() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        _buildUserMessage(
          'Hi, I was charged ₹452 for a ride from Prestige Tech Park to Indiranagar, but the app estimated only ₹352. Could you please look into why the final fare was so high? There was no significant traffic.',
          'Rahul Sharma • 10:42 AM',
        ),
        SizedBox(height: 24),
        _buildAdminMessage(
          'Hello Rahul, I am checking the ride logs right now. It appears the driver deviated from the suggested route. Please give me a moment to calculate the refund amount based on the estimated path.',
          'Admin • 10:55 AM',
        ),
        if (_isClosed) ...[
          SizedBox(height: 24),
          _buildTicketClosedCard(),
        ],
        SizedBox(height: 24),
        _buildRideReferenceCard(),
        if (_isRefunded && !_isClosed) ...[
          SizedBox(height: 24),
          _buildRefundSuccessCard(),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 44),
              child: Text(
                'Admin • 11:05 AM',
                style: AppTypography.base.copyWith(fontSize: 10, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUserMessage(String message, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.cFFE5E7EB,
          child: Icon(Icons.person, size: 16, color: AppColors.grey),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey.shade100),
                ),
                child: Text(
                  message,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: AppTypography.base.copyWith(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        SizedBox(width: 100), // Push to left
      ],
    );
  }

  Widget _buildAdminMessage(String message, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100), // Push to right
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cFF1A1D1F,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: AppTypography.base.copyWith(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.cFF1A1D1F,
          child: Icon(Icons.headset_mic, size: 16, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildRideReferenceCard() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 300,
        margin: EdgeInsets.only(right: 44),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.shade100),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RIDE REFERENCE RD-1205',
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'COMPLETED',
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FARE CHARGED',
                          style: AppTypography.base.copyWith(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹452.00',
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ESTIMATED',
                          style: AppTypography.base.copyWith(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹352.00',
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildChatInput() {
    if (_isClosed) {
      return Container(
        padding: EdgeInsets.all(24),
        color: AppColors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cFFF9FAFB,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.grey, size: 20),
              SizedBox(width: 12),
              Text(
                'This ticket is closed and can no longer be edited..',
                style: AppTypography.bodySmall.copyWith(color: AppColors.grey),
              ),
              Spacer(),
              Icon(
                Icons.camera_alt_outlined,
                color: AppColors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(24),
      color: AppColors.white,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.grey.shade200),
            ),
            child: Icon(Icons.add, color: AppColors.grey, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.grey,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.grey.shade200),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          SizedBox(width: 16),
          Icon(Icons.mic_none, color: AppColors.primary, size: 24),
        ],
      ),
    );
  }

  Widget _buildRefundSuccessCard() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 450,
        margin: EdgeInsets.only(right: 44),
        decoration: BoxDecoration(
          color: AppColors.cFFF0FDF4, // Light mint green
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cFFDCFCE7),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.cFF22C55E, // Success green
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: AppColors.white, size: 16),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Refund Successful',
                      style: AppTypography.base.copyWith(
                        color: AppColors.cFF166534, // Dark success green
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'Refund of '),
                          TextSpan(
                            text: '₹125.00',
                            style: AppTypography.base.copyWith(
                              color: AppColors.cFF22C55E,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' has been credited to your Wallet for Trip ',
                          ),
                          TextSpan(
                            text: '#RD-1205',
                            style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '. Reason: Driver Detour. We apologize for the inconvenience.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketClosedCard() {
    return Center(
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: AppColors.cFFE9EDF5, // Light greyish blue
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cFFD1D5DB),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history,
                      color: AppColors.cFF1F2937,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ticket closed on 04 Nov, 02:15 PM',
                    style: AppTypography.base.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cFF111827,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.cFF4B5563,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Resolution: ',
                          style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'Policy Violation - No Refund'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.cFF4B5563,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Admin Notes: ',
                          style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'Requested refund for a successful ride with no documented issues.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




