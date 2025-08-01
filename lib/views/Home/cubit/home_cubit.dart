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
          ],
          favoriteProducts: [],
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

  List<Map<String, dynamic>> get filteredProducts {
    if (state.selectedCategory == 'All') {
      return state.products;
    }
    return state.products
        .where((product) => product['category'] == state.selectedCategory)
        .toList();
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
