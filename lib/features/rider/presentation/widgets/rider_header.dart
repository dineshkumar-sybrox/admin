import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import 'adjust_wallet_dialog.dart';
import 'emergency_contact_log_dialog.dart';

class RiderHeader extends StatelessWidget {
  final bool isSafetyTabActive;
  final TabController? tabController;

  RiderHeader({
    super.key,
    this.isSafetyTabActive = false,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/rahul_sharma.jpg'),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    border: Border.all(color: AppColors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),

            // Name & ID & Contact Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Rahul Sharma',
                      style: AppTypography.base.copyWith(
                        fontSize: 20,
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
                        color: AppColors.activeTagBg, // Fixed: Use new bg color
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: AppTypography.base.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors
                              .activeTagText, // Fixed: Use new text color
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.badge_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ID: RD-9021',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone, size: 12, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text(
                      '9021443372',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.email_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'rahul@gmail.com',
                      style: AppTypography.base.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Spacer(),

            // Actions
            if (isSafetyTabActive) ...[
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EmergencyContactLogDialog(),
                  );
                },
                icon: Icon(
                  Icons.emergency,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
                label: Text(
                  'Emergency Contact Log',
                  style: AppTypography.base.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldBackground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: AppColors.white,
                ),
                label: Text(
                  'Flag for Investigation',
                  style: AppTypography.base.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cFFDC2626, // Red
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.block, size: 16),
                label: Text('BLOCK USER'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.divider),
                  backgroundColor: AppColors.background,
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AdjustWalletDialog(
                      riderName: 'Rahul Sharma',
                      currentBalance: '450',
                    ),
                  );
                },
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 16,
                ),
                label: Text('ADJUST WALLET'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 24),

        // Tabs
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.base.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label, // 👈 Important
          indicatorWeight: 3,
          labelPadding: EdgeInsets.symmetric(horizontal: 16),
          dividerColor: AppColors.transparent,
          tabs: const [
            Tab(text: 'OVERVIEW'),
            Tab(text: 'RIDE HISTORY'),
            Tab(text: 'WALLET & COINS'),
            Tab(text: 'COMPLAINTS'),
            Tab(text: 'SAFETY'),
          ],
        ),
        Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}




