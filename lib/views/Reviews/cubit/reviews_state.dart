import 'package:e_commerce/views/Reviews/models/review_model.dart';

class ReviewsState {
  final bool isLoading;
  final List<ReviewModel> reviews;
  final RatingBreakdown ratingBreakdown;
  final String selectedSortOption;
  final String errorMessage;
  final List<String> sortOptions;

  ReviewsState({
    required this.isLoading,
    required this.reviews,
    required this.ratingBreakdown,
    required this.selectedSortOption,
    required this.errorMessage,
    required this.sortOptions,
  });

  ReviewsState copyWith({
    bool? isLoading,
    List<ReviewModel>? reviews,
    RatingBreakdown? ratingBreakdown,
    String? selectedSortOption,
    String? errorMessage,
    List<String>? sortOptions,
  }) {
    return ReviewsState(
      isLoading: isLoading ?? this.isLoading,
      reviews: reviews ?? this.reviews,
      ratingBreakdown: ratingBreakdown ?? this.ratingBreakdown,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      errorMessage: errorMessage ?? this.errorMessage,
      sortOptions: sortOptions ?? this.sortOptions,
    );
  }
}
