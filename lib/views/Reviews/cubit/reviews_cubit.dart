import 'package:e_commerce/views/Reviews/cubit/reviews_state.dart';
import 'package:e_commerce/views/Reviews/models/review_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit()
    : super(
        ReviewsState(
          isLoading: false,
          reviews: [],
          ratingBreakdown: RatingBreakdown(
            fiveStar: 0,
            fourStar: 0,
            threeStar: 0,
            twoStar: 0,
            oneStar: 0,
          ),
          selectedSortOption: 'Most Relevant',
          errorMessage: '',
          sortOptions: [
            'Most Relevant',
            'Most Recent',
            'Highest Rated',
            'Lowest Rated',
          ],
        ),
      ) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock data based on the image
      final mockReviews = [
        ReviewModel(
          id: '1',
          reviewerName: 'Wade Warren',
          rating: 4.0,
          comment:
              'The item is very good, my son likes it very much and plays every day.',
          timeAgo: '6 days ago',
        ),
        ReviewModel(
          id: '2',
          reviewerName: 'Guy Hawkins',
          rating: 4.0,
          comment:
              'The seller is very fast in sending packet, I just bought it and the item arrived in just 1 day!',
          timeAgo: '1 week ago',
        ),
        ReviewModel(
          id: '3',
          reviewerName: 'Robert Fox',
          rating: 4.0,
          comment:
              'I just bought it and the stuff is really good! I highly recommend it!',
          timeAgo: '2 weeks ago',
        ),
        ReviewModel(
          id: '4',
          reviewerName: 'Sarah Johnson',
          rating: 5.0,
          comment:
              'Excellent quality and fast delivery. Will definitely buy again!',
          timeAgo: '3 weeks ago',
        ),
        ReviewModel(
          id: '5',
          reviewerName: 'Mike Chen',
          rating: 4.0,
          comment: 'Good product, meets expectations. Delivery was on time.',
          timeAgo: '1 month ago',
        ),
        ReviewModel(
          id: '6',
          reviewerName: 'Emily Davis',
          rating: 3.0,
          comment:
              'Product is okay, but could be better quality for the price.',
          timeAgo: '1 month ago',
        ),
        ReviewModel(
          id: '7',
          reviewerName: 'David Wilson',
          rating: 5.0,
          comment: 'Amazing product! Exceeded my expectations completely.',
          timeAgo: '2 months ago',
        ),
        ReviewModel(
          id: '8',
          reviewerName: 'Lisa Brown',
          rating: 4.0,
          comment: 'Very satisfied with the purchase. Good value for money.',
          timeAgo: '2 months ago',
        ),
      ];

      // Mock rating breakdown based on the image (1034 total ratings)
      final mockRatingBreakdown = RatingBreakdown(
        fiveStar: 620, // ~60% of 1034
        fourStar: 310, // ~30% of 1034
        threeStar: 72, // ~7% of 1034
        twoStar: 21, // ~2% of 1034
        oneStar: 11, // ~1% of 1034
      );

      emit(
        state.copyWith(
          isLoading: false,
          reviews: mockReviews,
          ratingBreakdown: mockRatingBreakdown,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load reviews: ${e.toString()}',
        ),
      );
    }
  }

  void changeSortOption(String sortOption) {
    if (sortOption == state.selectedSortOption) return;

    emit(state.copyWith(selectedSortOption: sortOption));
    _sortReviews(sortOption);
  }

  void _sortReviews(String sortOption) {
    List<ReviewModel> sortedReviews = List.from(state.reviews);

    switch (sortOption) {
      case 'Most Recent':
        // Sort by time (assuming newer reviews have smaller time values)
        sortedReviews.sort(
          (a, b) =>
              _parseTimeAgo(a.timeAgo).compareTo(_parseTimeAgo(b.timeAgo)),
        );
        break;
      case 'Highest Rated':
        sortedReviews.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Lowest Rated':
        sortedReviews.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case 'Most Relevant':
      default:
        // Keep original order (most relevant)
        break;
    }

    emit(state.copyWith(reviews: sortedReviews));
  }

  int _parseTimeAgo(String timeAgo) {
    if (timeAgo.contains('days ago')) {
      return int.tryParse(timeAgo.split(' ')[0]) ?? 0;
    } else if (timeAgo.contains('week ago')) {
      return 7;
    } else if (timeAgo.contains('weeks ago')) {
      return int.tryParse(timeAgo.split(' ')[0]) ?? 0 * 7;
    } else if (timeAgo.contains('month ago')) {
      return 30;
    } else if (timeAgo.contains('months ago')) {
      return int.tryParse(timeAgo.split(' ')[0]) ?? 0 * 30;
    }
    return 0;
  }
}
