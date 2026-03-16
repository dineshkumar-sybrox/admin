import 'package:equatable/equatable.dart';
import '../../../drivers/presentation/cubit/drivers_management_state.dart';

enum NavItem {
  dashboard,
  rider,
  drivers,
  payments,
  analytics,
  compliance,
  totalDocuments,
  totalTickets,
  complianceScoreDetails,
  support,
  settings,
  revenue,
  cancellation,
  createIncentive,
  incentiveHistory,
  incentiveDetail,
  zoneWisePricing,
}

class StatCard {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;

  StatCard({
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

  DriverApproval({
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

  SupportTicket({
    required this.ticketId,
    required this.userName,
    required this.issue,
    required this.timeAgo,
    required this.priority,
  });
}

class Transaction {
  final String id;
  final String amount;
  final String serviceType;
  final String paymentMethod;
  final String status;
  final bool isCompleted;

  Transaction({
    required this.id,
    required this.amount,
    required this.serviceType,
    required this.paymentMethod,
    required this.status,
    required this.isCompleted,
  });
}

class DashboardState extends Equatable {
  final bool isLoading;
  final NavItem selectedNav;
  final List<StatCard> statCards;
  final List<DriverApproval> driverApprovals;
  final List<SupportTicket> supportTickets;
  final List<Transaction> recentTransactions;
  final int pendingApprovals;
  final int newTickets;
  final DriverTab? initialDriverTab;
  final bool isExportingReport;

  DashboardState({
    this.isLoading = true,
    this.selectedNav = NavItem.dashboard,
    this.statCards = const [],
    this.driverApprovals = const [],
    this.supportTickets = const [],
    this.recentTransactions = const [],
    this.pendingApprovals = 0,
    this.newTickets = 0,
    this.initialDriverTab,
    this.isExportingReport = false,
  });

  DashboardState copyWith({
    bool? isLoading,
    NavItem? selectedNav,
    List<StatCard>? statCards,
    List<DriverApproval>? driverApprovals,
    List<SupportTicket>? supportTickets,
    List<Transaction>? recentTransactions,
    int? pendingApprovals,
    int? newTickets,
    DriverTab? initialDriverTab,
    bool? isExportingReport,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      selectedNav: selectedNav ?? this.selectedNav,
      statCards: statCards ?? this.statCards,
      driverApprovals: driverApprovals ?? this.driverApprovals,
      supportTickets: supportTickets ?? this.supportTickets,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      pendingApprovals: pendingApprovals ?? this.pendingApprovals,
      newTickets: newTickets ?? this.newTickets,
      initialDriverTab: initialDriverTab ?? this.initialDriverTab,
      isExportingReport: isExportingReport ?? this.isExportingReport,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    selectedNav,
    statCards,
    driverApprovals,
    supportTickets,
    recentTransactions,
    pendingApprovals,
    newTickets,
    initialDriverTab,
    isExportingReport,
  ];
}

