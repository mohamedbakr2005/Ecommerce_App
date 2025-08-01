import 'package:e_commerce/views/SavedItems/models/saved_item_model.dart';

class SavedItemsState {
  final bool isLoading;
  final List<SavedItemModel> savedItems;
  final String? error;

  SavedItemsState({
    required this.isLoading,
    required this.savedItems,
    this.error,
  });

  SavedItemsState copyWith({
    bool? isLoading,
    List<SavedItemModel>? savedItems,
    String? error,
  }) {
    return SavedItemsState(
      isLoading: isLoading ?? this.isLoading,
      savedItems: savedItems ?? this.savedItems,
      error: error ?? this.error,
    );
  }

  bool get isEmpty => savedItems.isEmpty;
  int get itemCount => savedItems.length;
}
