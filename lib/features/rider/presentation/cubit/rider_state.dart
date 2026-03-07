import 'package:equatable/equatable.dart';

class Rider {
  final String id;
  final String name;
  final String avatarInitials;
  final String phone;
  final String email;
  final int totalRides;
  final double walletBalance;
  final int coins;
  final String status;
  final String? reasonForSuspend;

  const Rider({
    required this.id,
    required this.name,
    required this.avatarInitials,
    required this.phone,
    required this.email,
    required this.totalRides,
    required this.walletBalance,
    required this.coins,
    required this.status,
    this.reasonForSuspend,
  });
}

enum RiderStatusFilter { all, active, inactive, banned }

enum RiderTab { total, active, newRiders, suspended }

class RiderState extends Equatable {
  final bool isLoading;
  final List<Rider> riders;
  final List<Rider> filteredRiders;
  final String searchQuery;
  final RiderStatusFilter statusFilter;
  final RiderTab selectedTab;
  final int currentPage;
  final int totalCount;
  final int totalRiders;
  final int activeToday;
  final int newRegistrations;
  final int bannedRiders;

  const RiderState({
    this.isLoading = true,
    this.riders = const [],
    this.filteredRiders = const [],
    this.searchQuery = '',
    this.statusFilter = RiderStatusFilter.all,
    this.selectedTab = RiderTab.total,
    this.currentPage = 1,
    this.totalCount = 0,
    this.totalRiders = 0,
    this.activeToday = 0,
    this.newRegistrations = 0,
    this.bannedRiders = 0,
  });

  RiderState copyWith({
    bool? isLoading,
    List<Rider>? riders,
    List<Rider>? filteredRiders,
    String? searchQuery,
    RiderStatusFilter? statusFilter,
    RiderTab? selectedTab,
    int? currentPage,
    int? totalCount,
    int? totalRiders,
    int? activeToday,
    int? newRegistrations,
    int? bannedRiders,
  }) {
    return RiderState(
      isLoading: isLoading ?? this.isLoading,
      riders: riders ?? this.riders,
      filteredRiders: filteredRiders ?? this.filteredRiders,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
      selectedTab: selectedTab ?? this.selectedTab,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      totalRiders: totalRiders ?? this.totalRiders,
      activeToday: activeToday ?? this.activeToday,
      newRegistrations: newRegistrations ?? this.newRegistrations,
      bannedRiders: bannedRiders ?? this.bannedRiders,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    riders,
    filteredRiders,
    searchQuery,
    statusFilter,
    selectedTab,
    currentPage,
    totalCount,
    totalRiders,
    activeToday,
    newRegistrations,
    bannedRiders,
  ];
}
