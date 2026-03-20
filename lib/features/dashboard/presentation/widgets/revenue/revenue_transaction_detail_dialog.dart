import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'revenue_transactions_table.dart';

class RevenueTransactionDetailDialog extends StatelessWidget {
  final dynamic row;

  const RevenueTransactionDetailDialog({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 980,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DialogHeader(
                  title: _dialogTitle(row),
                  statusText: 'Completed',
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: _LeftPanel(row: row)),
                    SizedBox(width: 16),
                    Expanded(flex: 4, child: _RightPanel(row: row)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _dialogTitle(dynamic row) {
    return 'Total Revenue - Today Transactions';
  }
}

class _DialogHeader extends StatelessWidget {
  final String title;
  final String statusText;

  const _DialogHeader({required this.title, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: AppTypography.h3),
            Spacer(),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close, size: 18, color: AppColors.textSecondary),
            ),
          ],
        ),
        SizedBox(height: 4),
        Divider(color: AppColors.divider),
        SizedBox(height: 4),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Breakdown',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Detailed breakdown of ride',
                  style: AppTypography.bodyRegular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Spacer(),
            _StatusPill(text: statusText),
          ],
        ),
      ],
    );
  }
}

class _LeftPanel extends StatelessWidget {
  final dynamic row;

  const _LeftPanel({required this.row});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cFFE5E7EB),
          ),
          child: Column(
            children: [
              _InfoHeader(
                timeAndDate: row?.timeAndDate ?? 'Feb 24, 2026 - 04:12 PM',
              ),
              SizedBox(height: 12),
              _MapCard(),
              SizedBox(height: 12),
              _PickupDropCard(),
            ],
          ),
        ),

        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PersonCard(
                title: 'RIDER DETAILS',
                name: row?.riderName ?? 'Rider Name',
                subtitle: 'View Profile',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PersonCard(
                title: 'DRIVER DETAILS',
                name: row?.driverName ?? 'Driver Name',
                subtitle: 'Vehicle Profile',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RightPanel extends StatelessWidget {
  final dynamic row;

  const _RightPanel({required this.row});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cFFE5E7EB),
          ),
          child: Column(
            children: [
              _TotalFareCard(
                total: row?.totalAmount ?? '0.00',
                paymentMethod: row?.paymentMethod ?? 'CASH',
              ),
              _BreakdownCard(
                total: row?.totalAmount ?? '0.00',
                driver: row?.driverEarning ?? '0.00',
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        SizedBox(height: 12),
        _FeedbackCard(title: 'RIDER FEEDBACK', text: 'He safely dropped me.'),
        SizedBox(height: 12),
        _FeedbackCard(title: 'DRIVER FEEDBACK', text: 'Polite Rider'),
      ],
    );
  }
}

class _InfoHeader extends StatelessWidget {
  final String timeAndDate;

  const _InfoHeader({required this.timeAndDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.route_rounded, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Ride Information',
                style: AppTypography.bodyRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
            ],
          ),
          Text(
            timeAndDate,
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(color: AppColors.cFFF1F5F9),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/images/map_placeholder.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return Center(
                    child: Icon(
                      Icons.map_outlined,
                      size: 48,
                      color: AppColors.activeTagBg,
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            left: 16,
            bottom: 14,
            child: Row(
              children: [
                _SmallStatCard(label: 'DISTANCE', value: '8.5 km'),

                SizedBox(width: 10),
                _SmallStatCard(label: 'DURATION', value: '24 mins'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PickupDropCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),

      child: Column(
        children: [
          _LocationRow(
            label: 'PICKUP',
            title: 'Anna Nagar, West Extension',
            subtitle: 'Near Blue Star Petrol Bunk, Chennai 600040',
            color: AppColors.primary,
          ),
          SizedBox(height: 8),
          _LocationRow(
            label: 'DROP-OFF',
            title: 'T-Nagar Shopping Hub',
            subtitle: 'Pondy Bazaar, Sir Thyagaraya Rd, Chennai 600017',
            color: AppColors.error,
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final Color color;

  const _LocationRow({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(height: 6),
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 2),
              Text(
                title,
                style: AppTypography.bodyRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PersonCard extends StatelessWidget {
  final String title;
  final String name;
  final String subtitle;

  const _PersonCard({
    required this.title,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTypography.bodyRegular.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Icon(Icons.person, size: 16, color: AppColors.primary),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.cFFF1F5F9,
                child: Text(_initials(name), style: AppTypography.base),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    if (title == "DRIVER DETAILS") ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Auto",
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.cFF1A1D1F,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                ".",
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "TN 01 AB 1234",
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 12,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "4.8",
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.cFF1A1D1F,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                    ] else ...[
                      Row(
                        children: [
                          Icon(Icons.star, size: 12, color: AppColors.primary),
                          SizedBox(width: 5),
                          Text(
                            "4.8",
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.cFF1A1D1F,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            ".",
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "12 Rides Total",
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: AppColors.divider),
          SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              subtitle,
              style: AppTypography.bodyRegular.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    final first = parts.first.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}

class _TotalFareCard extends StatelessWidget {
  final String total;
  final String paymentMethod;

  const _TotalFareCard({required this.total, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL FARE',
                style: AppTypography.bodyRegular.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              Icon(
                Icons.account_balance_wallet,
                size: 16,
                color: AppColors.white,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '₹$total',
            style: AppTypography.base.copyWith(
              fontSize: 32,
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'PAID VIA ${paymentMethod.toUpperCase()}',
              style: AppTypography.base.copyWith(
                fontSize: 12,
                color: AppColors.white,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  final String total;
  final String driver;

  const _BreakdownCard({required this.total, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAYMENT BREAKDOWN',
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 8),
          _BreakdownRow(label: 'Base Fare', value: '₹$total'),
          _BreakdownRow(label: 'Platform Fee', value: '₹15.00'),
          _BreakdownRow(label: 'GST', value: '₹5.00'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cFFF4FDF8,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DRIVER REVENUE',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF1A1D1F,
                      ),
                    ),
                    Text(
                      '₹$driver',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  final String label;
  final String value;

  const _BreakdownRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final String title;
  final String text;

  const _FeedbackCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cFFE5E7EB),
            ),
            child: Text(
              text,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String label;
  final String value;

  const _SmallStatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cFFE5E7EB),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.base.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.base.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String text;

  const _StatusPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.success.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: AppTypography.bodyRegular.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
