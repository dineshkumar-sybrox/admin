import 'package:flutter_bloc/flutter_bloc.dart';
export 'drivers_management_state.dart';
import 'drivers_management_state.dart';
import '../../../../core/utils/excel_export_helper.dart';

class DriversManagementCubit extends Cubit<DriversManagementState> {
  // ... rest of the class ...

  Future<void> exportToExcel() async {
    if (state.isExporting) return;
    emit(state.copyWith(isExporting: true));

    try {
      final drivers = state.filteredDrivers;
      final headers = [
        'DRIVER ID',
        'DRIVER NAME',
        'VEHICLE TYPE',
        'CITY',
        'LIFETIME RIDES',
        'WALLET BALANCE',
        'STATUS',
        'EARNINGS',
      ];
      final rows = drivers
          .map(
            (d) => [
              d.id,
              d.name,
              d.vehicleType,
              d.city,
              d.lifetimeRides,
              d.walletBalance,
              d.status,
              d.earnings,
            ],
          )
          .toList();

      await ExcelExportHelper.exportToExcel(
        headers: headers,
        rows: rows,
        fileName: 'Drivers_Data_${DateTime.now().millisecondsSinceEpoch}',
      );
    } finally {
      emit(state.copyWith(isExporting: false));
    }
  }

  DriversManagementCubit({DriverTab initialTab = DriverTab.total})
    : super(DriversManagementState(selectedTab: initialTab)) {
    loadDrivers();
  }

  static List<Driver> _allDrivers = [
    Driver(
      id: '#DRV-90832',
      name: 'Rahul Mehta',
      avatarUrl: 'https://i.pravatar.cc/150?u=rahul',
      vehicleType: 'AUTO',
      city: 'Chennai',
      lifetimeRides: 1482,
      walletBalance: 1240.50,
      status: 'Active',
      rank: 1,
      ridesToday: 48,
      onlineHours: 12.5,
      acceptanceRate: 98,
      earnings: 8450.00,
      trendData: [0.2, 0.5, 0.3, 0.8, 0.4, 0.9, 0.5],
    ),
    Driver(
      id: '#DRV-90830',
      name: 'Vikram Singh',
      avatarUrl: 'https://i.pravatar.cc/150?u=vikram',
      vehicleType: 'CAB',
      city: 'Chennai',
      lifetimeRides: 42,
      walletBalance: 7120.50,
      status: 'Active',
      rank: 2,
      ridesToday: 42,
      onlineHours: 11.2,
      acceptanceRate: 94,
      earnings: 7120.50,
      trendData: [0.1, 0.3, 0.2, 0.4, 0.3, 0.5, 0.4],
    ),
    Driver(
      id: '#DRV-90828',
      name: 'Amit Jain',
      avatarUrl: 'https://i.pravatar.cc/150?u=amit',
      vehicleType: 'AUTO',
      city: 'Kanchipuram',
      lifetimeRides: 39,
      walletBalance: 6840.25,
      status: 'Offline',
      rank: 3,
      ridesToday: 39,
      onlineHours: 10.8,
      acceptanceRate: 89,
      earnings: 6840.25,
      trendData: [0.5, 0.4, 0.6, 0.2, 0.7, 0.3, 0.5],
    ),
    Driver(
      id: '#DRV-90826',
      name: 'Priya Sharma',
      avatarUrl: 'https://i.pravatar.cc/150?u=priya',
      vehicleType: 'BIKE/SCOOTER',
      city: 'Kanchipuram',
      lifetimeRides: 37,
      walletBalance: 6420.00,
      status: 'Suspended',
      rank: 4,
      ridesToday: 37,
      onlineHours: 10.2,
      acceptanceRate: 92,
      earnings: 6420.00,
      trendData: [0.1, 0.2, 0.3, 0.4, 0.4, 0.5, 0.6],
      suspensionReason: 'Policy Violation',
      suspensionSubreason: 'unsafe driving reports',
      suspensionDate: '05 Feb, 2026',
      appealStatus: 'PENDING REVIEW',
    ),
    Driver(
      id: '#DRV-90825',
      name: 'Arjun Kapur',
      avatarUrl: 'https://i.pravatar.cc/150?u=arjun',
      vehicleType: 'CAB',
      city: 'Kanchipuram',
      lifetimeRides: 35,
      walletBalance: 5980.00,
      status: 'Active',
      rank: 5,
      ridesToday: 35,
      onlineHours: 9.5,
      acceptanceRate: 82,
      earnings: 5980.00,
      trendData: [0.3, 0.2, 0.3, 0.2, 0.4, 0.3, 0.5],
    ),
  ];

  Future<void> loadDrivers() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(milliseconds: 600));
    final filtered = _filterDrivers(
      state.searchQuery,
      state.statusFilter,
      state.selectedTab,
    );
    emit(
      state.copyWith(
        isLoading: false,
        drivers: _allDrivers,
        filteredDrivers: filtered,
      ),
    );
  }

  void search(String query) {
    final filtered = _filterDrivers(
      query,
      state.statusFilter,
      state.selectedTab,
    );
    emit(
      state.copyWith(
        searchQuery: query,
        filteredDrivers: filtered,
        currentPage: 1,
      ),
    );
  }

  void setStatusFilter(String filter) {
    final filtered = _filterDrivers(
      state.searchQuery,
      filter,
      state.selectedTab,
    );
    emit(
      state.copyWith(
        statusFilter: filter,
        filteredDrivers: filtered,
        currentPage: 1,
      ),
    );
  }

  void selectTab(DriverTab tab) {
    final filtered = _filterDrivers(state.searchQuery, state.statusFilter, tab);
    emit(
      state.copyWith(
        selectedTab: tab,
        filteredDrivers: filtered,
        currentPage: 1,
      ),
    );
  }

  List<Driver> _filterDrivers(
    String query,
    String statusFilter,
    DriverTab tab,
  ) {
    return _allDrivers.where((d) {
      final matchesQuery =
          query.isEmpty ||
          d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.id.toLowerCase().contains(query.toLowerCase()) ||
          d.city.toLowerCase().contains(query.toLowerCase());

      bool matchesStatus = true;
      if (statusFilter == 'Active') {
        matchesStatus = d.status == 'Active';
      } else if (statusFilter == 'Offline') {
        matchesStatus = d.status == 'Offline';
      } else if (statusFilter == 'Suspended') {
        matchesStatus = d.status == 'Suspended';
      }

      bool matchesTab = true;
      if (tab == DriverTab.active) {
        matchesTab = d.status == 'Active';
      } else if (tab == DriverTab.suspended) {
        matchesTab = d.status == 'Suspended';
      }

      return matchesQuery && matchesStatus && matchesTab;
    }).toList();
  }
}

