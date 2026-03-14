import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'total_documents_state.dart';

class TotalDocumentsCubit extends Cubit<TotalDocumentsState> {
  TotalDocumentsCubit()
    : super(
        const TotalDocumentsState(allDocuments: [], filteredDocuments: []),
      ) {
    _initializeDocuments();
  }

  void _initializeDocuments() {
    // Mock data based on the original UI
    final mockDocuments = [
      {
        'id': '#DOC-8801',
        'driverName': 'Vikram Seth',
        'documents': 'DRIVING LICENSE',
        'category': 'RESEND',
        'categoryColor': const Color(0xFFFFF7ED),
        'categoryTextColor': const Color(0xFFC2410C),
        'status': 'Pending',
        'statusColor': const Color(0xFFF97316),
        'dateTime': '04 Nov 2025\n05:20 PM',
      },
      {
        'id': '#DOC-8798',
        'driverName': 'Anita Mehra',
        'documents': 'ALL DOCUMENTS',
        'category': 'NEW DRIVER',
        'categoryColor': const Color(0xFFEFF6FF),
        'categoryTextColor': const Color(0xFF1D4ED8),
        'status': 'Pending',
        'statusColor': const Color(0xFFF97316),
        'dateTime': '04 Nov 2025\n04:15 PM',
      },
      {
        'id': '#DOC-8797',
        'driverName': 'Vikram Seth',
        'documents': 'BANK DETAILS',
        'category': 'NEW DRIVER',
        'categoryColor': const Color(0xFFEFF6FF),
        'categoryTextColor': const Color(0xFF1D4ED8),
        'status': 'Pending',
        'statusColor': const Color(0xFFF97316),
        'dateTime': '04 Nov 2025\n03:55 PM',
      },
      {
        'id': '#DOC-8796',
        'driverName': 'Vikram Seth',
        'documents': 'IDENTITY VERIFICATION',
        'category': 'NEW DRIVER',
        'categoryColor': const Color(0xFFEFF6FF),
        'categoryTextColor': const Color(0xFF1D4ED8),
        'status': 'Pending',
        'statusColor': const Color(0xFFF97316),
        'dateTime': '04 Nov 2025\n03:50 PM',
      },
      {
        'id': '#DOC-8795',
        'driverName': 'Sam Yogi',
        'documents': 'VEHICLE RC',
        'category': 'REJECTED',
        'categoryColor': const Color(0xFFFEF2F2),
        'categoryTextColor': const Color(0xFFB91C1C),
        'status': 'Rejected',
        'statusColor': const Color(0xFFEF4444),
        'dateTime': '04 Nov 2025\n03:45 PM',
      },
      {
        'id': '#DOC-8792',
        'driverName': 'Kabir Singh',
        'documents': 'ALL DOCUMENTS',
        'category': 'VERIFIED',
        'categoryColor': const Color(0xFFF0FDF4),
        'categoryTextColor': const Color(0xFF15803D),
        'status': 'Approved',
        'statusColor': const Color(0xFF22C55E),
        'dateTime': '04 Nov 2025\n02:10 PM',
      },
      {
        'id': '#DOC-8789',
        'driverName': 'Zara Khan',
        'documents': 'ALL DOCUMENTS',
        'category': 'VERIFIED',
        'categoryColor': const Color(0xFFF0FDF4),
        'categoryTextColor': const Color(0xFF15803D),
        'status': 'Approved',
        'statusColor': const Color(0xFF22C55E),
        'dateTime': '04 Nov 2025\n01:30 PM',
      },
    ];

    emit(
      state.copyWith(
        allDocuments: mockDocuments,
        filteredDocuments: mockDocuments,
      ),
    );
  }

  void filterByStatus(DocumentStatusFilter filter) {
    if (state.statusFilter == filter) {
      emit(state.copyWith(statusFilter: DocumentStatusFilter.all));
    } else {
      emit(state.copyWith(statusFilter: filter));
    }
    _applyFilters();
  }

  void searchDocuments(String query) {
    emit(state.copyWith(searchQuery: query));
    _applyFilters();
  }

  void filterByCategory(String category) {
    emit(state.copyWith(categoryFilter: category));
    _applyFilters();
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(state.allDocuments);

    // Filter by Status (Stat Cards)
    if (state.statusFilter != DocumentStatusFilter.all) {
      filtered = filtered.where((doc) {
        final category = doc['category'].toString().toUpperCase();
        switch (state.statusFilter) {
          case DocumentStatusFilter.newDocs:
            return category == 'NEW DRIVER';
          case DocumentStatusFilter.rejected:
            return category == 'REJECTED';
          case DocumentStatusFilter.resend:
            return category == 'RESEND';
          case DocumentStatusFilter.verified:
            return category == 'VERIFIED';
          default:
            return true;
        }
      }).toList();
    }

    // Filter by Dropdown Category
    if (state.categoryFilter != 'All Categories') {
      filtered = filtered.where((doc) {
        return doc['documents'].toString().toUpperCase().contains(
          state.categoryFilter.toUpperCase(),
        );
      }).toList();
    }

    // Search by ID or Name
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((doc) {
        final id = doc['id'].toString().toLowerCase();
        final name = doc['driverName'].toString().toLowerCase();
        return id.contains(query) || name.contains(query);
      }).toList();
    }

    emit(state.copyWith(filteredDocuments: filtered));
  }
}
