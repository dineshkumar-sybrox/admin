import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../widgets/rider_header.dart';
import 'rider_overview_tab.dart';
import 'ride_history_tab.dart';
import 'wallet_coins_tab.dart';
import 'complaints_tab.dart';
import 'refund_ticket_page.dart';
import 'safety_tab.dart';

class RiderOverviewPage extends StatefulWidget {
  const RiderOverviewPage({super.key});

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
    _tabController = TabController(length: 5, vsync: this);
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
      title: _isRefunding ? 'Refund For Ticket' : 'Rider Overview',
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
                RiderHeader(
                  tabController: _tabController,
                  isSafetyTabActive: _tabController.index == 4,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      const RiderOverviewTab(), // Overview
                      const RideHistoryTab(), // Ride History
                      const WalletCoinsTab(), // Wallet & Coins
                      ComplaintsTab(
                        onIssueRefund: () {
                          setState(() {
                            _isRefunding = true;
                          });
                        },
                      ), // Complaints
                      const SafetyTab(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
