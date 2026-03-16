import 'package:equatable/equatable.dart';

enum DriverTab { total, active, newDrivers, suspended, leaderboard }

class Driver {
  final String id;
  final String name;
  final String avatarUrl;
  final String vehicleType;
  final String city;
  final int lifetimeRides;
  final double walletBalance;
  final String status;

  // Fields for Leaderboard/Active tab
  final int? rank;
  final int? ridesToday;
  final double? onlineHours;
  final int? acceptanceRate;
  final double? earnings;
  final List<double>? trendData;

  // Fields for Suspended tab
  final String? suspensionReason;
  final String? suspensionSubreason;
  final String? suspensionDate;
  final String? appealStatus;

  const Driver({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.vehicleType,
    required this.city,
    required this.lifetimeRides,
    required this.walletBalance,
    required this.status,
    this.rank,
    this.ridesToday,
    this.onlineHours,
    this.acceptanceRate,
    this.earnings,
    this.trendData,
    this.suspensionReason,
    this.suspensionSubreason,
    this.suspensionDate,
    this.appealStatus,
  });
}

class DriversManagementState extends Equatable {
  final bool isLoading;
  final List<Driver> drivers;
  final List<Driver> filteredDrivers;
  final String searchQuery;
  final String statusFilter;
  final DriverTab selectedTab;
  final int currentPage;
  final bool isExporting;

  const DriversManagementState({
    this.isLoading = true,
    this.drivers = const [],
    this.filteredDrivers = const [],
    this.searchQuery = '',
    this.statusFilter = 'All Status',
    this.selectedTab = DriverTab.total,
    this.currentPage = 1,
    this.isExporting = false,
  });

  DriversManagementState copyWith({
    bool? isLoading,
    List<Driver>? drivers,
    List<Driver>? filteredDrivers,
    String? searchQuery,
    String? statusFilter,
    DriverTab? selectedTab,
    int? currentPage,
    bool? isExporting,
  }) {
    return DriversManagementState(
      isLoading: isLoading ?? this.isLoading,
      drivers: drivers ?? this.drivers,
      filteredDrivers: filteredDrivers ?? this.filteredDrivers,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
      selectedTab: selectedTab ?? this.selectedTab,
      currentPage: currentPage ?? this.currentPage,
      isExporting: isExporting ?? this.isExporting,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    drivers,
    filteredDrivers,
    searchQuery,
    statusFilter,
    selectedTab,
    currentPage,
    isExporting,
  ];
}
