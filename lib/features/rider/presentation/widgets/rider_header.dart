import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'adjust_wallet_dialog.dart';
import 'emergency_contact_log_dialog.dart';

class RiderHeader extends StatelessWidget {
  final bool isSafetyTabActive;
  final TabController? tabController;

  const RiderHeader({
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
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/rahul_sharma.jpg'),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Name & ID & Contact Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Rahul Sharma',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.activeTagBg, // Fixed: Use new bg color
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors
                              .activeTagText, // Fixed: Use new text color
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(
                      Icons.badge_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ID: RD-9021',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.phone, size: 12, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text(
                      '9021443372',
                      style: TextStyle(
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
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Actions
            if (isSafetyTabActive) ...[
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const EmergencyContactLogDialog(),
                  );
                },
                icon: const Icon(
                  Icons.emergency,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
                label: const Text(
                  'Emergency Contact Log',
                  style: TextStyle(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text(
                  'Flag for Investigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626), // Red
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.block, size: 16),
                label: const Text('BLOCK USER'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.divider),
                  backgroundColor: AppColors.background,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AdjustWalletDialog(
                      riderName: 'Rahul Sharma',
                      currentBalance: '450',
                    ),
                  );
                },
                icon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 16,
                ),
                label: const Text('ADJUST WALLET'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),

        // Tabs
        TabBar(
          controller: tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelColor: AppColors.textSecondary,
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.tab, // Full tab width indicator
          indicatorWeight: 3,
          labelPadding: EdgeInsets.only(right: 32),
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start, // Align tabs to start
          tabs: [
            Tab(text: 'OVERVIEW'),
            Tab(text: 'RIDE HISTORY'),
            Tab(text: 'WALLET & COINS'),
            Tab(text: 'COMPLAINTS'),
            Tab(text: 'SAFETY'),
          ],
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}
