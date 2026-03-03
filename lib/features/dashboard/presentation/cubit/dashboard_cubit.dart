import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));

    emit(state.copyWith(
      isLoading: false,
      pendingApprovals: 12,
      newTickets: 4,
      statCards: const [
        StatCard(
          title: 'TOTAL ACTIVE DRIVERS',
          value: '24k',
          trend: '+5.2%',
          isPositive: true,
        ),
        StatCard(
          title: 'ACTIVE RIDES',
          value: '8.2k',
          trend: '-2.1%',
          isPositive: false,
        ),
        StatCard(
          title: 'REVENUE TODAY',
          value: '₹1.2M',
          trend: '+12%',
          isPositive: true,
        ),
        StatCard(
          title: 'CANCELLATION %',
          value: '4.2%',
          trend: '-0.5%',
          isPositive: true,
        ),
      ],
      driverApprovals: const [
        DriverApproval(
          name: 'Arun Kumar',
          driverId: '#D-4421',
          documentCount: 5,
          progress: 80,
          approvedDocs: ['ID', 'LICENSE', 'RC', 'INSURANCE'],
          pendingDocs: ['Bank'],
        ),
        DriverApproval(
          name: 'Sam Yogi',
          driverId: '#D-4421',
          documentCount: 5,
          progress: 80,
          approvedDocs: ['ID', 'LICENSE', 'RC', 'INSURANCE'],
          pendingDocs: ['Bank'],
        ),
      ],
      supportTickets: const [
        SupportTicket(
          ticketId: '#TK-8821',
          userName: 'Amit Shah',
          issue: 'Payment Failed',
          timeAgo: '3 mins ago',
          priority: 'URGENT',
        ),
        SupportTicket(
          ticketId: '#TK-8819',
          userName: 'Sonia G.',
          issue: 'GPS Drift',
          timeAgo: '12 mins ago',
          priority: 'MEDIUM',
        ),
      ],
    ));
  }

  void selectNav(NavItem item) {
    emit(state.copyWith(selectedNav: item));
  }

  void approveDriver(String driverId) {
    final updatedApprovals = state.driverApprovals
        .where((d) => d.driverId != driverId)
        .toList();
    emit(state.copyWith(
      driverApprovals: updatedApprovals,
      pendingApprovals: state.pendingApprovals - 1,
    ));
  }

  void resolveTicket(String ticketId) {
    final updatedTickets = state.supportTickets
        .where((t) => t.ticketId != ticketId)
        .toList();
    emit(state.copyWith(
      supportTickets: updatedTickets,
      newTickets: (state.newTickets - 1).clamp(0, 99),
    ));
  }
}
