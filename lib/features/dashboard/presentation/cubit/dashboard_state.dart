import 'package:equatable/equatable.dart';

enum NavItem {
  dashboard,
  rider,
  drivers,
  payments,
  analytics,
  compliance,
  support,
  settings,
  revenue,
  cancellation,
  createIncentive,
  incentiveHistory,
  incentiveDetail,
}

class StatCard {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;

  const StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
  });
}

class DriverApproval {
  final String name;
  final String driverId;
  final int documentCount;
  final int progress;
  final List<String> approvedDocs;
  final List<String> pendingDocs;

  const DriverApproval({
    required this.name,
    required this.driverId,
    required this.documentCount,
    required this.progress,
    required this.approvedDocs,
    required this.pendingDocs,
  });
}

class SupportTicket {
  final String ticketId;
  final String userName;
  final String issue;
  final String timeAgo;
  final String priority;

  const SupportTicket({
    required this.ticketId,
    required this.userName,
    required this.issue,
    required this.timeAgo,
    required this.priority,
  });
}

class DashboardState extends Equatable {
  final bool isLoading;
  final NavItem selectedNav;
  final List<StatCard> statCards;
  final List<DriverApproval> driverApprovals;
  final List<SupportTicket> supportTickets;
  final int pendingApprovals;
  final int newTickets;

  const DashboardState({
    this.isLoading = true,
    this.selectedNav = NavItem.dashboard,
    this.statCards = const [],
    this.driverApprovals = const [],
    this.supportTickets = const [],
    this.pendingApprovals = 0,
    this.newTickets = 0,
  });

  DashboardState copyWith({
    bool? isLoading,
    NavItem? selectedNav,
    List<StatCard>? statCards,
    List<DriverApproval>? driverApprovals,
    List<SupportTicket>? supportTickets,
    int? pendingApprovals,
    int? newTickets,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      selectedNav: selectedNav ?? this.selectedNav,
      statCards: statCards ?? this.statCards,
      driverApprovals: driverApprovals ?? this.driverApprovals,
      supportTickets: supportTickets ?? this.supportTickets,
      pendingApprovals: pendingApprovals ?? this.pendingApprovals,
      newTickets: newTickets ?? this.newTickets,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    selectedNav,
    statCards,
    driverApprovals,
    supportTickets,
    pendingApprovals,
    newTickets,
  ];
}
