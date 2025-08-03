import 'package:e_commerce/views/SavedItems/cubit/saved_items_state.dart';
import 'package:e_commerce/views/SavedItems/models/saved_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedItemsCubit extends Cubit<SavedItemsState> {
  SavedItemsCubit() : super(SavedItemsState(isLoading: false, savedItems: []));

  // Mock data for saved items
  final List<SavedItemModel> _mockSavedItems = [
    SavedItemModel(
      id: '1',
      name: 'Regular Fit Slogan',
      price: 1190,
      image: 'assets/images/home1.png',
      category: 'Tshirts',
      
    ),
    SavedItemModel(
      id: '2',
      name: 'Regular Fit Polo',
      price: 1190,
      image: 'assets/images/home2.png',
      category: 'Tshirts',
    ),
    SavedItemModel(
      id: '3',
      name: 'Regular Fit Black',
      price: 1190,
      image: 'assets/images/home3.png',
      category: 'Tshirts',
    ),
    SavedItemModel(
      id: '4',
      name: 'Regular Fit V-Neck',
      price: 1190,
      image: 'assets/images/home4.png',
      category: 'Tshirts',
    ),
    SavedItemModel(
      id: '5',
      name: 'Regular Fit Slogan',
      price: 1190,
      image: 'assets/images/home1.png',
      category: 'Tshirts',
    ),
    SavedItemModel(
      id: '6',
      name: 'Regular Fit Slogan',
      price: 1190,
      image: 'assets/images/home2.png',
      category: 'Tshirts',
    ),
  ];

  Future<void> loadSavedItems() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, you would fetch from API or local storage
      // For now, we'll use mock data
      emit(state.copyWith(isLoading: false, savedItems: _mockSavedItems));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: 'Failed to load saved items'),
      );
    }
  }

  void removeFromSaved(String itemId) {
    final updatedItems = state.savedItems
        .where((item) => item.id != itemId)
        .toList();
    emit(state.copyWith(savedItems: updatedItems));
  }

  void clearAllSavedItems() {
    emit(state.copyWith(savedItems: []));
  }

  bool isItemSaved(String itemId) {
    return state.savedItems.any((item) => item.id == itemId);
  }

  void toggleSavedItem(SavedItemModel item) {
    if (isItemSaved(item.id)) {
      removeFromSaved(item.id);
    } else {
      final updatedItems = List<SavedItemModel>.from(state.savedItems)
        ..add(item);
      emit(state.copyWith(savedItems: updatedItems));
    }
  }
}
