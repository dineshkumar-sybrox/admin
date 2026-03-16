import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit()
    : super(
        PaymentsState(
          allTransactions: [],
          filteredTransactions: [],
          allPayouts: [],
          filteredPayouts: [],
        ),
      ) {
    _initializeData();
  }

  void _initializeData() {
    final mockTransactions = [
      {
        'id': '#TXN-88291',
        'riderName': 'Vikram\nMalhotra',
        'driverName': 'Sam\nYogi',
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'tripId': '#TRP-44201',
        'amount': '₹842.00',
        'paymentMethod': 'UPI',
        'paymentIcon': Icons.account_balance_wallet_outlined,
        'status': 'COMPLETED',
        'statusColor': AppColors.cFF2E5BFF,
        'statusBgColor': AppColors.cFFEAF0FF,
        'type': 'Cab',
      },
      {
        'id': '#TXN-88289',
        'riderName': 'Priya\nSingh',
        'driverName': 'Pream\nSingh',
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'tripId': '#TRP-44201',
        'amount': '₹842.00',
        'paymentMethod': 'Cash',
        'paymentIcon': Icons.payments_outlined,
        'status': 'COMPLETED',
        'statusColor': AppColors.cFF00A86B,
        'statusBgColor': AppColors.cFFE8FDF2,
        'type': 'Cab',
      },
      {
        'id': '#TXN-88285',
        'riderName': 'Arjun\nVerma',
        'driverName': 'Arun\nVerma',
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'tripId': '#TRP-44201',
        'amount': '₹842.00',
        'paymentMethod': 'UPI',
        'paymentIcon': Icons.account_balance_wallet_outlined,
        'status': 'FAILED',
        'statusColor': AppColors.cFFEA3546,
        'statusBgColor': AppColors.cFFFFECEE,
        'type': 'Bike/Scooter',
      },
      {
        'id': '#TXN-88282',
        'riderName': 'Sonia\nKapoor',
        'driverName': 'Sai\nKapoor',
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'tripId': '#TRP-44201',
        'amount': '₹842.00',
        'paymentMethod': 'UPI',
        'paymentIcon': Icons.account_balance_wallet_outlined,
        'status': 'COMPLETED',
        'statusColor': AppColors.cFF00A86B,
        'statusBgColor': AppColors.cFFE8FDF2,
        'type': 'Auto',
      },
    ];

    final mockPayouts = [
      {
        'id': '#PAY-99210',
        'vehicleType': 'CAB',
        'vehicleColor': AppColors.cFFFFA629,
        'vehicleBgColor': AppColors.cFFFFF7DB,
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'driverName': 'Rahul Jaiswal',
        'driverDesc': 'Driver',
        'amount': '₹24,500.00',
        'paymentTransfer': 'UPI',
        'paymentIcon': Icons.account_balance_wallet_outlined,
        'status': 'SUCCESSFUL',
        'statusColor': AppColors.cFF00C46B,
        'statusBgColor': AppColors.cFFE8FDF2,
      },
      {
        'id': '#PAY-99211',
        'vehicleType': 'BIKE/SCOOTER',
        'vehicleColor': AppColors.cFF00A86B,
        'vehicleBgColor': AppColors.cFFE8FDF2,
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'driverName': 'Sam Yogi',
        'driverDesc': 'Driver',
        'amount': '₹24,500.00',
        'paymentTransfer': 'Bank',
        'paymentIcon': Icons.account_balance_outlined,
        'status': 'PENDING',
        'statusColor': AppColors.cFFD4A000,
        'statusBgColor': AppColors.cFFFFF7DB,
      },
      {
        'id': '#PAY-99212',
        'vehicleType': 'CAB',
        'vehicleColor': AppColors.cFFFFA629,
        'vehicleBgColor': AppColors.cFFFFF7DB,
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'driverName': 'Rahul Singh',
        'driverDesc': 'Driver',
        'amount': '₹24,500.00',
        'paymentTransfer': 'Bank',
        'paymentIcon': Icons.account_balance_outlined,
        'status': 'REJECTED',
        'statusColor': AppColors.cFFEA3546,
        'statusBgColor': AppColors.cFFFFECEE,
      },
      {
        'id': '#PAY-99213',
        'vehicleType': 'AUTO',
        'vehicleColor': AppColors.cFF2E5BFF,
        'vehicleBgColor': AppColors.cFFEAF0FF,
        'dateAndTime': '24 Feb 2026,\n08:45 PM',
        'driverName': 'Aruk Kumar',
        'driverDesc': 'Driver',
        'amount': '₹24,500.00',
        'paymentTransfer': 'UPI',
        'paymentIcon': Icons.account_balance_wallet_outlined,
        'status': 'SUCCESSFUL',
        'statusColor': AppColors.cFF00C46B,
        'statusBgColor': AppColors.cFFE8FDF2,
      },
    ];

    emit(
      state.copyWith(
        allTransactions: mockTransactions,
        filteredTransactions: mockTransactions,
        allPayouts: mockPayouts,
        filteredPayouts: mockPayouts,
      ),
    );
  }

  void changeStatIndex(int index) {
    emit(state.copyWith(selectedStatIndex: index));
    _applyFilters();
  }

  // Transactions Filtering
  void filterByPaymentMethod(String method) {
    emit(state.copyWith(paymentMethodFilter: method));
    _applyFilters();
  }

  void filterByStatus(String status) {
    emit(state.copyWith(statusFilter: status));
    _applyFilters();
  }

  void searchTransactions(String query) {
    emit(state.copyWith(searchQuery: query));
    _applyFilters();
  }

  // Payouts Filtering
  void filterPayoutByMethod(String method) {
    emit(state.copyWith(payoutMethodFilter: method));
    _applyPayoutFilters();
  }

  void filterPayoutByStatus(String status) {
    emit(state.copyWith(payoutStatusFilter: status));
    _applyPayoutFilters();
  }

  void filterPayoutByVehicle(String vehicle) {
    emit(state.copyWith(payoutVehicleFilter: vehicle));
    _applyPayoutFilters();
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(state.allTransactions);

    // Filter by Type (from Stat Cards)
    if (state.selectedStatIndex != 0) {
      String type = '';
      switch (state.selectedStatIndex) {
        case 1:
          type = 'Cab';
          break;
        case 2:
          type = 'Bike/Scooter';
          break;
        case 3:
          type = 'Auto';
          break;
      }
      filtered = filtered.where((txn) => txn['type'] == type).toList();
    }

    // Filter by Payment Method
    if (state.paymentMethodFilter != 'All Payment Methods') {
      filtered = filtered
          .where((txn) => txn['paymentMethod'] == state.paymentMethodFilter)
          .toList();
    }

    // Filter by Status
    if (state.statusFilter != 'All Status') {
      filtered = filtered
          .where((txn) => txn['status'] == state.statusFilter.toUpperCase())
          .toList();
    }

    // Search by ID or Rider/Driver
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((txn) {
        final id = txn['id'].toString().toLowerCase();
        final rider = txn['riderName'].toString().toLowerCase();
        final driver = txn['driverName'].toString().toLowerCase();
        return id.contains(query) ||
            rider.contains(query) ||
            driver.contains(query);
      }).toList();
    }

    emit(state.copyWith(filteredTransactions: filtered));
  }

  void _applyPayoutFilters() {
    List<Map<String, dynamic>> filtered = List.from(state.allPayouts);

    // Filter by Payment Method
    if (state.payoutMethodFilter != 'Payment Methods') {
      filtered = filtered
          .where(
            (payout) => payout['paymentTransfer'] == state.payoutMethodFilter,
          )
          .toList();
    }

    // Filter by Status
    if (state.payoutStatusFilter != 'All Status') {
      filtered = filtered
          .where(
            (payout) =>
                payout['status'] == state.payoutStatusFilter.toUpperCase(),
          )
          .toList();
    }

    // Filter by Vehicle
    if (state.payoutVehicleFilter != 'Vehicle') {
      filtered = filtered
          .where(
            (payout) =>
                payout['vehicleType'] ==
                state.payoutVehicleFilter.toUpperCase(),
          )
          .toList();
    }

    emit(state.copyWith(filteredPayouts: filtered));
  }
}



