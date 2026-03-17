import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'total_tickets_state.dart';

class TotalTicketsCubit extends Cubit<TotalTicketsState> {
  TotalTicketsCubit()
    : super(TotalTicketsState(allTickets: [], filteredTickets: [])) {
    _initializeTickets();
  }

  void _initializeTickets() {
    // Mock data based on the original UI
    final mockTickets = [
      {
        'id': '#TK-8842',
        'personName': 'Vikram Seth',
        'personType': 'Driver',
        'category': 'BILLING ISSUE',
        'status': 'IN-PROGRESS',
        'dateTime': '04 Nov 2025 01:30 PM',
        'statusColor': AppColors.cFFF2C94C,
      },
      {
        'id': '#TK-8839',
        'personName': 'Anita Mehra',
        'personType': 'Customer',
        'category': 'SAFETY',
        'status': 'OPEN',
        'dateTime': '04 Nov 2025 01:30 PM',
        'statusColor': AppColors.cFF2F80ED,
      },
      {
        'id': '#TK-8835',
        'personName': 'Sam Yogi',
        'personType': 'Driver',
        'category': 'APP GLITCH',
        'status': 'CLOSED',
        'dateTime': '04 Nov 2025 01:30 PM',
        'statusColor': AppColors.cFF00A86B,
      },
      {
        'id': '#TK-8831',
        'personName': 'Kabir Singh',
        'personType': 'Customer',
        'category': 'PAYMENT ERROR',
        'status': 'OPEN',
        'dateTime': '04 Nov 2025 01:30 PM',
        'statusColor': AppColors.cFF2F80ED,
      },
      {
        'id': '#TK-8845',
        'personName': 'Sam Wilson',
        'personType': 'Customer',
        'category': 'REFUND',
        'status': 'REFUNDED',
        'dateTime': '04 Nov 2025 01:30 PM',
        'statusColor': AppColors.cFFEF4444,
      },
    ];

    emit(state.copyWith(allTickets: mockTickets, filteredTickets: mockTickets));
  }

  void filterByStatus(TicketStatusFilter filter) {
    emit(state.copyWith(statusFilter: filter));
    _applyFilters();
  }

  void searchTickets(String query) {
    emit(state.copyWith(searchQuery: query));
    _applyFilters();
  }

  void filterByCategory(String category) {
    emit(state.copyWith(categoryFilter: category));
    _applyFilters();
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(state.allTickets);

    // Filter by Status
    if (state.statusFilter != TicketStatusFilter.all) {
      filtered = filtered.where((ticket) {
        final status = ticket['status'].toString().toUpperCase();
        switch (state.statusFilter) {
          case TicketStatusFilter.open:
            return status == 'OPEN' || status == 'IN-PROGRESS';
          case TicketStatusFilter.closed:
            return status == 'CLOSED';
          case TicketStatusFilter.refund:
            return status == 'REFUNDED';
          default:
            return true;
        }
      }).toList();
    }

    // Filter by Category
    if (state.categoryFilter != 'All Categories') {
      filtered = filtered.where((ticket) {
        return ticket['category'].toString().toUpperCase() ==
            state.categoryFilter.toUpperCase();
      }).toList();
    }

    // Search by ID or Name
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((ticket) {
        final id = ticket['id'].toString().toLowerCase();
        final name = ticket['personName'].toString().toLowerCase();
        return id.contains(query) || name.contains(query);
      }).toList();
    }

    emit(state.copyWith(filteredTickets: filtered));
  }
}



