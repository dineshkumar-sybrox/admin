import 'package:equatable/equatable.dart';

enum TicketStatusFilter { all, open, closed, refund }

class TotalTicketsState extends Equatable {
  final List<Map<String, dynamic>> allTickets;
  final List<Map<String, dynamic>> filteredTickets;
  final TicketStatusFilter statusFilter;
  final String searchQuery;
  final String categoryFilter;
  final bool isLoading;

  TotalTicketsState({
    required this.allTickets,
    required this.filteredTickets,
    this.statusFilter = TicketStatusFilter.all,
    this.searchQuery = '',
    this.categoryFilter = 'All Categories',
    this.isLoading = false,
  });

  TotalTicketsState copyWith({
    List<Map<String, dynamic>>? allTickets,
    List<Map<String, dynamic>>? filteredTickets,
    TicketStatusFilter? statusFilter,
    String? searchQuery,
    String? categoryFilter,
    bool? isLoading,
  }) {
    return TotalTicketsState(
      allTickets: allTickets ?? this.allTickets,
      filteredTickets: filteredTickets ?? this.filteredTickets,
      statusFilter: statusFilter ?? this.statusFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    allTickets,
    filteredTickets,
    statusFilter,
    searchQuery,
    categoryFilter,
    isLoading,
  ];
}

