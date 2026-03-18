import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import 'package:admin/features/rider/presentation/widgets/adjust_wallet_dialog.dart';
import 'package:admin/features/rider/presentation/widgets/emergency_contact_log_dialog.dart';
import 'rider_overview_tab.dart';
import 'ride_history_tab.dart';
import 'wallet_tab.dart';
import 'driver_incentive_tab.dart';
import 'driver_documents_tab.dart';
import 'complaints_tab.dart';
import 'refund_ticket_page.dart';
import 'safety_tab.dart';

class RiderOverviewPage extends StatefulWidget {
  RiderOverviewPage({super.key});

  @override
  State<RiderOverviewPage> createState() => _RiderOverviewPageState();
}

class _RiderOverviewPageState extends State<RiderOverviewPage>
    with SingleTickerProviderStateMixin {
  bool _isRefunding = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: _isRefunding ? 'Refund For Ticket' : 'Driver Overview',
      body: _isRefunding
          ? RefundTicketPage(
              ticketId: '#TC-8821',
              rideId: 'RD-1205',
              wrapWithScaffold: false,
              onCancel: () {
                setState(() {
                  _isRefunding = false;
                });
              },
            )
          : Column(
              children: [
                _DriverOverviewHeader(
                  tabController: _tabController,
                  isSafetyTabActive: _tabController.index == 6,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RiderOverviewTab(), // Overview
                      RideHistoryTab(), // Ride History
                      WalletCoinsTab(), // Wallet
                      const DriverIncentiveTab(),
                      const DriverDocumentsTab(),
                      ComplaintsTab(
                        onIssueRefund: () {
                          setState(() {
                            _isRefunding = true;
                          });
                        },
                      ), // Complaints
                      SafetyTab(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _DriverOverviewHeader extends StatelessWidget {
  final bool isSafetyTabActive;
  final TabController? tabController;

  const _DriverOverviewHeader({
    required this.isSafetyTabActive,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/images/rahul_sharma.jpg'),
                ),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    border: Border.all(color: AppColors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Rahul Sharma', style: AppTypography.h3),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.activeTagText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ID: DR-9021',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '9021443372',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.email_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'rahul@gmail.com',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            if (isSafetyTabActive) ...[
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EmergencyContactLogDialog(),
                  );
                },
                icon: const Icon(
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
                  backgroundColor: AppColors.cFFDC2626,
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
                label: const Text('SUSPEND DRIVER'),
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
                    builder: (context) => AdjustWalletDialog(
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
                  backgroundColor: AppColors.green,
                  elevation: 0,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.base.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          dividerColor: AppColors.transparent,
          tabs: const [
            Tab(text: 'OVERVIEW'),
            Tab(text: 'RIDE HISTORY'),
            Tab(text: 'WALLET'),
            Tab(text: 'INCENTIVE'),
            Tab(text: 'DOCUMENTS'),
            Tab(text: 'COMPLAINTS'),
            Tab(text: 'SAFETY'),
          ],
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}

class _EmptyTabPlaceholder extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyTabPlaceholder({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cFFE5E7EB),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTypography.h3,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTypography.base.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
