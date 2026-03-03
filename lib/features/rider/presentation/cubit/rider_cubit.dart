import 'package:flutter_bloc/flutter_bloc.dart';
import 'rider_state.dart';

class RiderCubit extends Cubit<RiderState> {
  RiderCubit() : super(const RiderState());

  static const List<Rider> _allRiders = [
    Rider(
      id: '#CUST-90821',
      name: 'Rahul Sharma',
      avatarInitials: 'RS',
      phone: '+91 98765 43210',
      email: 'arjun.s@outlook.com',
      totalRides: 142,
      walletBalance: 1240.50,
      coins: 4850,
      status: 'Active',
    ),
    Rider(
      id: '#CUST-90822',
      name: 'Priya Verma',
      avatarInitials: 'PV',
      phone: '+91 91234 56789',
      email: 'priya.v@gmail.com',
      totalRides: 12,
      walletBalance: 45.00,
      coins: 120,
      status: 'Active',
    ),
    Rider(
      id: '#CUST-90825',
      name: 'Rohan Das',
      avatarInitials: 'RD',
      phone: '+91 99887 76655',
      email: 'rohan_das@corp.in',
      totalRides: 356,
      walletBalance: 8920.00,
      coins: 12400,
      status: 'Active',
    ),
    Rider(
      id: '#CUST-90830',
      name: 'Sanya Malhotra',
      avatarInitials: 'SM',
      phone: '+91 77665 54433',
      email: 'sanya_m@outlook.com',
      totalRides: 88,
      walletBalance: 620.00,
      coins: 2100,
      status: 'Active',
    ),
    Rider(
      id: '#CUST-90832',
      name: 'Vikram Singh',
      avatarInitials: 'VS',
      phone: '+91 90000 11111',
      email: 'v.singh@gmail.com',
      totalRides: 0,
      walletBalance: 0.00,
      coins: 0,
      status: 'Active',
    ),
    Rider(
      id: '#CUST-90840',
      name: 'Ananya Patel',
      avatarInitials: 'AP',
      phone: '+91 98123 45678',
      email: 'ananya.p@gmail.com',
      totalRides: 210,
      walletBalance: 3100.00,
      coins: 6200,
      status: 'Inactive',
    ),
    Rider(
      id: '#CUST-90845',
      name: 'Kiran Rao',
      avatarInitials: 'KR',
      phone: '+91 70001 23456',
      email: 'kiran.r@yahoo.com',
      totalRides: 5,
      walletBalance: 0.00,
      coins: 50,
      status: 'Banned',
    ),
    Rider(
      id: '#CUST-90847',
      name: 'Mohit Joshi',
      avatarInitials: 'MJ',
      phone: '+91 88765 43210',
      email: 'mohit.j@corp.in',
      totalRides: 78,
      walletBalance: 450.00,
      coins: 900,
      status: 'Active',
    ),
  ];

  Future<void> loadRiders() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(state.copyWith(
      isLoading: false,
      riders: _allRiders,
      filteredRiders: _allRiders,
      totalCount: 12482,
      totalRiders: 48921,
      activeToday: 12402,
      newRegistrations: 428,
      bannedRiders: 152,
    ));
  }

  void search(String query) {
    final filtered = _filterRiders(query, state.statusFilter);
    emit(state.copyWith(
      searchQuery: query,
      filteredRiders: filtered,
      currentPage: 1,
    ));
  }

  void setStatusFilter(RiderStatusFilter filter) {
    final filtered = _filterRiders(state.searchQuery, filter);
    emit(state.copyWith(
      statusFilter: filter,
      filteredRiders: filtered,
      currentPage: 1,
    ));
  }

  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  List<Rider> _filterRiders(String query, RiderStatusFilter filter) {
    return _allRiders.where((r) {
      final matchesQuery = query.isEmpty ||
          r.name.toLowerCase().contains(query.toLowerCase()) ||
          r.email.toLowerCase().contains(query.toLowerCase()) ||
          r.phone.contains(query);
      final matchesStatus = filter == RiderStatusFilter.all ||
          (filter == RiderStatusFilter.active && r.status == 'Active') ||
          (filter == RiderStatusFilter.inactive && r.status == 'Inactive') ||
          (filter == RiderStatusFilter.banned && r.status == 'Banned');
      return matchesQuery && matchesStatus;
    }).toList();
  }
}
