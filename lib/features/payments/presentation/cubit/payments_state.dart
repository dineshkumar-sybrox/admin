import 'package:equatable/equatable.dart';

class PaymentsState extends Equatable {
  final List<Map<String, dynamic>> allTransactions;
  final List<Map<String, dynamic>> filteredTransactions;
  final List<Map<String, dynamic>> allPayouts;
  final List<Map<String, dynamic>> filteredPayouts;
  final String searchQuery;
  final String paymentMethodFilter;
  final String statusFilter;
  final String dateFilter;
  final String payoutMethodFilter;
  final String payoutStatusFilter;
  final String payoutVehicleFilter;
  final int selectedStatIndex;
  final bool isLoading;

  const PaymentsState({
    required this.allTransactions,
    required this.filteredTransactions,
    required this.allPayouts,
    required this.filteredPayouts,
    this.searchQuery = '',
    this.paymentMethodFilter = 'All Payment Methods',
    this.statusFilter = 'All Status',
    this.dateFilter = '',
    this.payoutMethodFilter = 'Payment Methods',
    this.payoutStatusFilter = 'All Status',
    this.payoutVehicleFilter = 'Vehicle',
    this.selectedStatIndex = 0,
    this.isLoading = false,
  });

  PaymentsState copyWith({
    List<Map<String, dynamic>>? allTransactions,
    List<Map<String, dynamic>>? filteredTransactions,
    List<Map<String, dynamic>>? allPayouts,
    List<Map<String, dynamic>>? filteredPayouts,
    String? searchQuery,
    String? paymentMethodFilter,
    String? statusFilter,
    String? dateFilter,
    String? payoutMethodFilter,
    String? payoutStatusFilter,
    String? payoutVehicleFilter,
    int? selectedStatIndex,
    bool? isLoading,
  }) {
    return PaymentsState(
      allTransactions: allTransactions ?? this.allTransactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      allPayouts: allPayouts ?? this.allPayouts,
      filteredPayouts: filteredPayouts ?? this.filteredPayouts,
      searchQuery: searchQuery ?? this.searchQuery,
      paymentMethodFilter: paymentMethodFilter ?? this.paymentMethodFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      dateFilter: dateFilter ?? this.dateFilter,
      payoutMethodFilter: payoutMethodFilter ?? this.payoutMethodFilter,
      payoutStatusFilter: payoutStatusFilter ?? this.payoutStatusFilter,
      payoutVehicleFilter: payoutVehicleFilter ?? this.payoutVehicleFilter,
      selectedStatIndex: selectedStatIndex ?? this.selectedStatIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    allTransactions,
    filteredTransactions,
    allPayouts,
    filteredPayouts,
    searchQuery,
    paymentMethodFilter,
    statusFilter,
    dateFilter,
    payoutMethodFilter,
    payoutStatusFilter,
    payoutVehicleFilter,
    selectedStatIndex,
    isLoading,
  ];
}
