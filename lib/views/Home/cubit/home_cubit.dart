import 'package:e_commerce/views/Home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
    : super(
        HomeState(
          isLoading: false,
          searchController: TextEditingController(),
          selectedCategory: 'Tshirts',
          categories: ['All', 'Tshirts', 'Jeans', 'Shoes', 'Hats', 'Bags'],
          products: [
            {
              'id': '1',
              'name': 'Regular Fit Slogan',
              'price': 1190,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home1.png',
              'category': 'Tshirts',
            },
            {
              'id': '2',
              'name': 'Regular Fit Polo',
              'price': 1100,
              'originalPrice': 2292,
              'discount': 52,
              'image': 'assets/images/home2.png',
              'category': 'Tshirts',
            },
            {
              'id': '3',
              'name': 'Regular Fit Black',
              'price': 1690,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home3.png',
              'category': 'Tshirts',
            },
            {
              'id': '4',
              'name': 'Regular Fit V-Neck',
              'price': 1290,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home4.png',
              'category': 'Tshirts',
            },
            {
              'id': '5',
              'name': 'Classic Blue Jeans',
              'price': 2500,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home1.png',
              'category': 'Jeans',
            },
            {
              'id': '6',
              'name': 'Slim Fit Jeans',
              'price': 1800,
              'originalPrice': 2200,
              'discount': 18,
              'image': 'assets/images/home2.png',
              'category': 'Jeans',
            },
            {
              'id': '7',
              'name': 'Running Shoes',
              'price': 3500,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home3.png',
              'category': 'Shoes',
            },
            {
              'id': '8',
              'name': 'Casual Sneakers',
              'price': 2800,
              'originalPrice': 3200,
              'discount': 12,
              'image': 'assets/images/home4.png',
              'category': 'Shoes',
            },
            {
              'id': '9',
              'name': 'Baseball Cap',
              'price': 800,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home1.png',
              'category': 'Hats',
            },
            {
              'id': '10',
              'name': 'Leather Bag',
              'price': 4200,
              'originalPrice': null,
              'discount': null,
              'image': 'assets/images/home2.png',
              'category': 'Bags',
            },
          ],
          favoriteProducts: [],
          sortBy: 'Relevance',
          priceRange: const RangeValues(0, 5000),
          selectedSize: 'L',
        ),
      );

  void onSearchChanged(String value) {
    emit(state.copyWith());
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void toggleFavorite(String productId) {
    List<String> newFavorites = List.from(state.favoriteProducts);

    if (newFavorites.contains(productId)) {
      newFavorites.remove(productId);
    } else {
      newFavorites.add(productId);
    }

    emit(state.copyWith(favoriteProducts: newFavorites));
  }

  bool isFavorite(String productId) {
    return state.favoriteProducts.contains(productId);
  }

  void applyFilters(Map<String, dynamic> filters) {
    emit(
      state.copyWith(
        sortBy: filters['sortBy'] ?? state.sortBy,
        priceRange: filters['priceRange'] ?? state.priceRange,
        selectedSize: filters['size'] ?? state.selectedSize,
      ),
    );
  }

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = state.products;

    // Filter by category
    if (state.selectedCategory != 'All') {
      filtered = filtered
          .where((product) => product['category'] == state.selectedCategory)
          .toList();
    }

    // Filter by price range
    filtered = filtered.where((product) {
      double price = (product['price'] as num).toDouble();
      return price >= state.priceRange.start && price <= state.priceRange.end;
    }).toList();

    // Sort products
    switch (state.sortBy) {
      case 'Price: Low - High':
        filtered.sort(
          (a, b) => (a['price'] as num).compareTo(b['price'] as num),
        );
        break;
      case 'Price: High - Low':
        filtered.sort(
          (a, b) => (b['price'] as num).compareTo(a['price'] as num),
        );
        break;
      case 'Relevance':
      default:
        // Keep original order
        break;
    }

    return filtered;
  }

  void clearSearch() {
    state.searchController.clear();
    emit(state.copyWith());
  }

  @override
  Future<void> close() {
    state.searchController.dispose();
    return super.close();
  }
}
