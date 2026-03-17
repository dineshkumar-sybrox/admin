import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class SuspensionDetailsDialog extends StatelessWidget {
  final bool showActions;
  SuspensionDetailsDialog({super.key, this.showActions = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 900 ? 940.0 : screenWidth * 0.92;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.transparent,
      child: Container(
        width: dialogWidth,
        constraints: BoxConstraints(maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Divider(height: 1, color: AppColors.cFFF3F4F6),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _buildLeftColumn()),
                    SizedBox(width: 24),
                    Expanded(flex: 4, child: _buildRightColumn()),
                  ],
                ),
              ),
            ),
            if (showActions) ...[
              // const SizedBox(height: 8),
              Divider(height: 1, color: AppColors.cFFF3F4F6),

              const SizedBox(height: 8),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cFFF3F4F6,
                          elevation: 0,
                          
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTypography.base.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                
                    const SizedBox(width: 16),
                
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Your confirm logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green, // green
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Confirm Activate",
                          style: AppTypography.base.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            'Rider Profile Audit - Rahul Sharma',
            style: AppTypography.h3.copyWith(),
          ),
          SizedBox(width: 12),
          _StatusPill(
            label: 'SUSPENDED',
            color: AppColors.error,
            bgColor: AppColors.cFFFFEBEE,
          ),
          SizedBox(width: 10),
          Text(
            '#RDR-90830',
            style: AppTypography.base.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: AppColors.textSecondary, size: 18),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Activity Overview'),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(title: 'TOTAL RIDES', value: '142'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _OverviewStatCard(title: 'ACCOUNT AGE', value: '2 Years'),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(
                title: 'CANCELLATION RATE',
                value: '8.2%',
                isErrorValue: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _OverviewStatCard(
                title: 'LAST RIDE DATE',
                value: 'Oct 12, 2023',
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        _SectionTitle('Frequent Locations'),
        SizedBox(height: 8),
        _buildMapCard(),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Suspension Details'),
        SizedBox(height: 8),
        _buildSuspensionDetailsCard(),
        SizedBox(height: 16),
        _SectionTitle('Referral Network Audit'),
        SizedBox(height: 8),
        _buildReferralAuditCard(),
      ],
    );
  }

  Widget _buildMapCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.cFFF8FAFC,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFF1F5F9),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/map.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.cFFE5E7EB),
              ),
              child: Text(
                'Primary Pickup: Chennai, Tamil Nadu',
                style: AppTypography.base.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuspensionDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEEBC8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusPill(
                label: 'FRAUD',
                color: AppColors.white,
                bgColor: AppColors.error,
                dense: true,
              ),
              SizedBox(width: 8),
              Text(
                'Flagged on Oct 14, 2023',
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  color: AppColors.cFF6B7280,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Internal Admin Note:',
            style: AppTypography.base.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFEEBC8)),
            ),
            child: Text(
              'Detected suspicious coin redemption patterns. Multiple accounts linked to the same device ID tried to redeem referral bonuses within a 2-hour window. Account flagged for manual audit of wallet transactions and ride activity.',
              style: AppTypography.base.copyWith(
                fontSize: 13,
                color: AppColors.cFF6B7280,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.verified, size: 14, color: AppColors.cFF3B82F6),
              SizedBox(width: 6),
              Text(
                'Audited by: Aryan Sharma (Super Admin)',
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  color: AppColors.cFF64748B,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferralAuditCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFF1F5F9),
      ),
      child: Column(
        children: [
          _InfoRow(label: 'Referred Users', value: '12 Users'),
          SizedBox(height: 12),
          _InfoRow(label: 'Coins Earned from Referrals', value: '4,200'),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final bool dense;

  const _StatusPill({
    required this.label,
    required this.color,
    required this.bgColor,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 10,
        vertical: dense ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTypography.base.copyWith(
          fontSize: dense ? 10 : 11,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _OverviewStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isErrorValue;

  const _OverviewStatCard({
    required this.title,
    required this.value,
    this.isErrorValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cFFF8FAFC,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cFFF1F5F9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              color: AppColors.cFF94A3B8,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: AppTypography.base.copyWith(
              color: isErrorValue ? AppColors.error : AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            fontWeight: FontWeight.w700,
            color: AppColors.cFF00A86B,
          ),
        ),
      ],
    );
  }
}
