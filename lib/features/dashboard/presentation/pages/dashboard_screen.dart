import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/demand_map_widget.dart';
import '../widgets/document_approvals_panel.dart';
import '../widgets/ride_trend_chart.dart';
import '../widgets/stat_cards_row.dart';
import '../widgets/support_tickets_panel.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../rider/presentation/pages/rider_list_screen.dart';
import 'revenue_today_screen.dart';
import 'cancellation_screen.dart';
import '../../../../features/payments/presentation/pages/payments_screen.dart';
import '../../../../features/analytics/presentation/pages/analytics_screen.dart';
import '../../../../features/incentives/presentation/pages/create_incentive_screen.dart';
import '../../../../features/incentives/presentation/pages/incentive_historical_screen.dart';
import '../../../../features/incentives/presentation/pages/incentive_detail_screen.dart';
import '../../../../features/compliance/presentation/pages/compliance_screen.dart';
import '../../../../features/drivers/presentation/pages/drivers_management_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFF4F6F9),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF00A86B)),
            ),
          );
        }
        return AdminScaffold(
          title: _titleFor(state.selectedNav),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth < 1100;
              return _buildBody(state, isTablet);
            },
          ),
        );
      },
    );
  }

  String _titleFor(NavItem nav) {
    switch (nav) {
      case NavItem.rider:
        return 'Rider Management';
      case NavItem.drivers:
        return 'Drivers Management - Total Drivers';
      case NavItem.payments:
        return 'Payment Management';
      case NavItem.analytics:
        return 'Analytics';
      case NavItem.support:
        return 'Support Center';
      case NavItem.settings:
        return 'System Settings';
      case NavItem.revenue:
        return 'Revenue Today';
      case NavItem.cancellation:
        return 'Cancellation';
      case NavItem.createIncentive:
        return 'Create Incentive - Daily';
      case NavItem.incentiveHistory:
        return 'Incentive History';
      case NavItem.incentiveDetail:
        return 'Morning Commute Rush';
      case NavItem.compliance:
        return 'Compliance';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildBody(DashboardState state, bool isTablet) {
    switch (state.selectedNav) {
      case NavItem.rider:
        return const RiderScreen();
      case NavItem.payments:
        return const PaymentsScreen();
      case NavItem.analytics:
        return const AnalyticsScreen();
      case NavItem.revenue:
        return const RevenueTodayScreen();
      case NavItem.cancellation:
        return const CancellationScreen();
      case NavItem.createIncentive:
        return const CreateIncentiveScreen();
      case NavItem.incentiveHistory:
        return const IncentiveHistoricalScreen();
      case NavItem.incentiveDetail:
        return const IncentiveDetailScreen();
      case NavItem.compliance:
        return const ComplianceScreen();
      case NavItem.drivers:
        return const DriversManagementScreen();
      default:
        return _DashboardBody(isTablet: isTablet);
    }
  }
}

class _DashboardBody extends StatelessWidget {
  final bool isTablet;
  const _DashboardBody({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatCardsRow(),
          const SizedBox(height: 20),
          if (isTablet)
            const Column(
              children: [
                DemandMapWidget(),
                SizedBox(height: 16),
                DocumentApprovalsPanel(),
              ],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: DemandMapWidget()),
                SizedBox(width: 16),
                Expanded(flex: 2, child: DocumentApprovalsPanel()),
              ],
            ),
          const SizedBox(height: 20),
          if (isTablet)
            const Column(
              children: [
                RideTrendChart(),
                SizedBox(height: 16),
                SupportTicketsPanel(),
              ],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: RideTrendChart()),
                SizedBox(width: 16),
                Expanded(flex: 2, child: SupportTicketsPanel()),
              ],
            ),
        ],
      ),
    );
  }
}
