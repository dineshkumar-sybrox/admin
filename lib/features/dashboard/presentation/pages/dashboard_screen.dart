import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
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
import '../../../../features/compliance/presentation/pages/total_documents_screen.dart';
import '../../../../features/compliance/presentation/pages/total_tickets_screen.dart';
import '../../../../features/compliance/presentation/pages/compliance_score_details_screen.dart';
import '../../../../features/drivers/presentation/pages/drivers_management_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
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
      case NavItem.totalDocuments:
        return 'Total Documents';
      case NavItem.totalTickets:
        return 'Total Tickets';
      case NavItem.complianceScoreDetails:
        return 'Compliance Score Details';
      default:
        return 'Dashboard';
    }
  }

  Widget _buildBody(DashboardState state, bool isTablet) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.cFF00A86B),
      );
    }
    switch (state.selectedNav) {
      case NavItem.rider:
        return RiderScreen();
      case NavItem.payments:
        return PaymentsScreen();
      case NavItem.analytics:
        return AnalyticsScreen();
      case NavItem.revenue:
        return RevenueTodayScreen();
      case NavItem.cancellation:
        return CancellationScreen();
      case NavItem.createIncentive:
        return CreateIncentiveScreen();
      case NavItem.incentiveHistory:
        return IncentiveHistoricalScreen();
      case NavItem.incentiveDetail:
        return IncentiveDetailScreen();
      case NavItem.compliance:
        return ComplianceScreen();
      case NavItem.totalDocuments:
        return TotalDocumentsScreen();
      case NavItem.totalTickets:
        return TotalTicketsScreen();
      case NavItem.complianceScoreDetails:
        return ComplianceScoreDetailsScreen();
      case NavItem.drivers:
        return DriversManagementScreen(initialTab: state.initialDriverTab);
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
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardsRow(),
          SizedBox(height: 20),
          if (isTablet)
            Column(
              children: [
                DemandMapWidget(),
                SizedBox(height: 16),
                DocumentApprovalsPanel(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: DemandMapWidget()),
                SizedBox(width: 16),
                Expanded(flex: 2, child: DocumentApprovalsPanel()),
              ],
            ),
          SizedBox(height: 20),
          if (isTablet)
            Column(
              children: [
                RideTrendChart(),
                SizedBox(height: 16),
                SupportTicketsPanel(),
              ],
            )
          else
            Row(
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


