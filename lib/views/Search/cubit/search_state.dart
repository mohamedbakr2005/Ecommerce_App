import 'package:flutter/material.dart';
import 'package:e_commerce/views/Search/models/search_product_model.dart';

class SearchState {
  final bool isLoading;
  final TextEditingController searchController;
  final List<String> recentSearches;
  final List<SearchProductModel> searchResults;
  final bool hasSearched;
  final String currentQuery;

  SearchState({
    required this.isLoading,
    required this.searchController,
    required this.recentSearches,
    required this.searchResults,
    required this.hasSearched,
    required this.currentQuery,
  });

  SearchState copyWith({
    bool? isLoading,
    TextEditingController? searchController,
    List<String>? recentSearches,
    List<SearchProductModel>? searchResults,
    bool? hasSearched,
    String? currentQuery,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchController: searchController ?? this.searchController,
      recentSearches: recentSearches ?? this.recentSearches,
      searchResults: searchResults ?? this.searchResults,
      hasSearched: hasSearched ?? this.hasSearched,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}
