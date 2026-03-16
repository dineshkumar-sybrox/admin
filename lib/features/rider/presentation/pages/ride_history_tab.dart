import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class RideHistoryTab extends StatelessWidget {
  RideHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 24, bottom: 48),
      child: Column(
        children: [
          // Header Controls
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Ride ID or Route...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.divider),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.divider),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.filter_list, size: 18),
                label: Text('Filters'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.divider),
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Spacer(),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download, size: 18),
                label: Text('Export CSV'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.divider),
                  backgroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Table
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                _buildTableHeader(),
                Divider(height: 1, color: AppColors.divider),
                _RideDataRow(
                  rideId: '#RD-10294',
                  dateTime: '28 Oct 2023\n06:42 PM',
                  routeFrom: 'Prestige Tech Park',
                  routeTo: 'Indiranagar',
                  fare: '₹452.00',
                  coupon: 'SAVE50',
                  coins: '42',
                  tip: '₹20.00',
                  status: 'COMPLETED',
                  isExpanded: true,
                ),
                Divider(height: 1, color: AppColors.divider),
                _RideDataRow(
                  rideId: '#RD-09872',
                  dateTime: '18 Oct 2023\n08:05 AM',
                  routeFrom: 'Domlur',
                  routeTo: 'MG Road Metro',
                  fare: '₹184.00',
                  coupon: 'FIRST30',
                  coins: '12',
                  tip: '₹5.00',
                  status: 'COMPLETED',
                  isExpanded: false,
                ),
                // Add more rows as needed
              ],
            ),
          ),

          SizedBox(height: 24),

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SHOWING 1-10 OF 142 RIDES',
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                children: [
                  _buildPageButton('<', false),
                  SizedBox(width: 8),
                  _buildPageButton('1', true),
                  SizedBox(width: 8),
                  _buildPageButton('2', false),
                  SizedBox(width: 8),
                  _buildPageButton('3', false),
                  SizedBox(width: 8),
                  _buildPageButton('>', false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _buildHeaderCell('RIDE ID', flex: 2),
          _buildHeaderCell('DATE & TIME', flex: 2),
          _buildHeaderCell('ROUTE', flex: 4),
          _buildHeaderCell('FARE', flex: 2),
          _buildHeaderCell('COUPON', flex: 2),
          _buildHeaderCell('COINS', flex: 1),
          _buildHeaderCell('TIP', flex: 1),
          _buildHeaderCell('STATUS', flex: 2),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: AppTypography.base.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPageButton(String text, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.sidebar : AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        text,
        style: AppTypography.base.copyWith(
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _RideDataRow extends StatefulWidget {
  final String rideId;
  final String dateTime;
  final String routeFrom;
  final String routeTo;
  final String fare;
  final String coupon;
  final String coins;
  final String tip;
  final String status;
  final bool isExpanded;

  const _RideDataRow({
    required this.rideId,
    required this.dateTime,
    required this.routeFrom,
    required this.routeTo,
    required this.fare,
    required this.coupon,
    required this.coins,
    required this.tip,
    required this.status,
    this.isExpanded = false,
  });

  @override
  State<_RideDataRow> createState() => _RideDataRowState();
}

class _RideDataRowState extends State<_RideDataRow> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.rideId,
                    style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.dateTime,
                    style: AppTypography.base.copyWith(fontSize: 13, height: 1.4),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Text(
                        widget.routeFrom,
                        style: AppTypography.base.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        widget.routeTo,
                        style: AppTypography.base.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.fare,
                    style: AppTypography.base.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cFFFFF7E6, // Light Orange
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.coupon,
                        style: AppTypography.base.copyWith(
                          color: AppColors.cFFD97706,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.coins,
                    style: AppTypography.base.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.tip,
                    style: AppTypography.base.copyWith(color: AppColors.textSecondary),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.activeTagBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.status,
                        style: AppTypography.base.copyWith(
                          color: AppColors.activeTagText,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (isExpanded)
          Container(
            color: Color(
              0xFFFAFAFA,
            ), // Very light grey bg for expanded area
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 4,
                    color: AppColors.success, // Green indicator line
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 16,
                                color: AppColors.textPrimary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'DETAILED FARE AUDIT',
                                style: AppTypography.base.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAuditItem('BASE FARE', '₹50.00'),
                              SizedBox(width: 48),
                              _buildAuditItem('DISTANCE (12.4 KM)', '₹248.00'),
                              SizedBox(width: 48),
                              _buildAuditItem('TIME (34 MINS)', '₹102.00'),
                              SizedBox(width: 48),
                              _buildAuditItem(
                                'SURGE (1.2X)',
                                '+ ₹72.00',
                                valueColor: AppColors.warning,
                              ),
                              SizedBox(width: 48),
                              _buildAuditItem(
                                'DISCOUNTS',
                                '- ₹40.00',
                                valueColor: AppColors.success,
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          Divider(height: 1),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              _buildAuditItem(
                                'DRIVER PAYOUT',
                                '₹384.20',
                                isLarge: true,
                              ),
                              SizedBox(width: 48),
                              _buildAuditItem(
                                'PLATFORM FEE',
                                '₹67.80',
                                isLarge: true,
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View Support Ticket',
                                  style: AppTypography.base.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAuditItem(
    String label,
    String value, {
    Color? valueColor,
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.base.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: AppTypography.base.copyWith(
            fontSize: isLarge ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}




