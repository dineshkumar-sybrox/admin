import 'package:equatable/equatable.dart';

enum DocumentStatusFilter { all, newDocs, rejected, resend, verified }

class TotalDocumentsState extends Equatable {
  final List<Map<String, dynamic>> allDocuments;
  final List<Map<String, dynamic>> filteredDocuments;
  final DocumentStatusFilter statusFilter;
  final String searchQuery;
  final String categoryFilter;
  final bool isLoading;

  const TotalDocumentsState({
    required this.allDocuments,
    required this.filteredDocuments,
    this.statusFilter = DocumentStatusFilter.all,
    this.searchQuery = '',
    this.categoryFilter = 'All Categories',
    this.isLoading = false,
  });

  TotalDocumentsState copyWith({
    List<Map<String, dynamic>>? allDocuments,
    List<Map<String, dynamic>>? filteredDocuments,
    DocumentStatusFilter? statusFilter,
    String? searchQuery,
    String? categoryFilter,
    bool? isLoading,
  }) {
    return TotalDocumentsState(
      allDocuments: allDocuments ?? this.allDocuments,
      filteredDocuments: filteredDocuments ?? this.filteredDocuments,
      statusFilter: statusFilter ?? this.statusFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    allDocuments,
    filteredDocuments,
    statusFilter,
    searchQuery,
    categoryFilter,
    isLoading,
  ];
}
