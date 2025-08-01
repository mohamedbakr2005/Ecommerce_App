import 'package:e_commerce/views/Search/cubit/search_state.dart';
import 'package:e_commerce/views/Search/models/search_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
    : super(
        SearchState(
          isLoading: false,
          searchController: TextEditingController(),
          recentSearches: [
            'Jeans',
            'Casual clothes',
            'Hoodie',
            'Nike shoes black',
            'V-neck tshirt',
            'Winter clothes',
          ],
          searchResults: [],
          hasSearched: false,
          currentQuery: '',
        ),
      );

  // Mock products data
  final List<SearchProductModel> _allProducts = [
    SearchProductModel(
      id: '1',
      name: 'Regular Fit Slogan',
      price: 1190,
      image: 'assets/images/home1.png',
      category: 'Tshirts',
    ),
    SearchProductModel(
      id: '2',
      name: 'Regular Fit Polo',
      price: 1100,
      originalPrice: 2292,
      discount: 52,
      image: 'assets/images/home2.png',
      category: 'Tshirts',
    ),
    SearchProductModel(
      id: '3',
      name: 'Regular Fit Black',
      price: 1690,
      image: 'assets/images/home3.png',
      category: 'Tshirts',
    ),
    SearchProductModel(
      id: '4',
      name: 'Regular Fit V-Neck',
      price: 1290,
      image: 'assets/images/home4.png',
      category: 'Tshirts',
    ),
  ];

  void onSearchChanged(String value) {
    emit(state.copyWith(currentQuery: value));

    if (value.isEmpty) {
      emit(state.copyWith(searchResults: [], hasSearched: false));
      return;
    }

    // Simulate search delay
    emit(state.copyWith(isLoading: true));

    Timer(const Duration(milliseconds: 500), () {
      final results = _allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();

      emit(
        state.copyWith(
          searchResults: results,
          hasSearched: true,
          isLoading: false,
        ),
      );
    });
  }

  void performSearch(String query) {
    if (query.trim().isEmpty) return;

    // Add to recent searches if not already present
    final trimmedQuery = query.trim();
    if (!state.recentSearches.contains(trimmedQuery)) {
      final updatedRecentSearches = [trimmedQuery, ...state.recentSearches];
      if (updatedRecentSearches.length > 10) {
        updatedRecentSearches.removeLast();
      }
      emit(state.copyWith(recentSearches: updatedRecentSearches));
    }

    emit(state.copyWith(isLoading: true, currentQuery: trimmedQuery));
    state.searchController.text = trimmedQuery;

    // Simulate search delay
    Timer(const Duration(milliseconds: 800), () {
      final results = _allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(trimmedQuery.toLowerCase()),
          )
          .toList();

      emit(
        state.copyWith(
          searchResults: results,
          hasSearched: true,
          isLoading: false,
        ),
      );
    });
  }

  void removeRecentSearch(String search) {
    final updatedRecentSearches = List<String>.from(state.recentSearches);
    updatedRecentSearches.remove(search);
    emit(state.copyWith(recentSearches: updatedRecentSearches));
  }

  void clearAllRecentSearches() {
    emit(state.copyWith(recentSearches: []));
  }

  void clearSearch() {
    state.searchController.clear();
    emit(
      state.copyWith(searchResults: [], hasSearched: false, currentQuery: ''),
    );
  }

  void onRecentSearchTap(String search) {
    performSearch(search);
  }

  @override
  Future<void> close() {
    state.searchController.dispose();
    return super.close();
  }
}
