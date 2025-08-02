# Reviews Module

This module implements a comprehensive reviews screen for the e-commerce application with Cubit state management.

## Structure

```
lib/views/Reviews/
├── cubit/
│   ├── reviews_cubit.dart      # Business logic and state management
│   └── reviews_state.dart      # State class definition
├── models/
│   └── review_model.dart       # Data models for reviews and rating breakdown
├── widgets/
│   ├── rating_breakdown.dart   # Rating distribution widget
│   ├── review_item.dart        # Individual review item widget
│   └── star_rating.dart        # Reusable star rating widget
├── Reviews_screen.dart         # Main reviews screen
└── README.md                   # This documentation
```

## Features

### 1. Overall Rating Display
- Shows average rating with large, prominent display
- Displays star rating visualization
- Shows total number of ratings

### 2. Rating Breakdown
- Visual breakdown of ratings from 1-5 stars
- Progress bars showing the distribution
- Count of ratings for each star level

### 3. Individual Reviews
- List of individual customer reviews
- Star rating for each review
- Reviewer name and time posted
- Review comments

### 4. Sorting Options
- Most Relevant (default)
- Most Recent
- Highest Rated
- Lowest Rated

### 5. State Management
- Loading states with progress indicators
- Error handling with retry functionality
- Responsive UI updates

## Models

### ReviewModel
```dart
class ReviewModel {
  final String id;
  final String reviewerName;
  final double rating;
  final String comment;
  final String timeAgo;
  final String? reviewerImage;
}
```

### RatingBreakdown
```dart
class RatingBreakdown {
  final int fiveStar;
  final int fourStar;
  final int threeStar;
  final int twoStar;
  final int oneStar;
  
  // Computed properties
  int get totalRatings;
  double get averageRating;
  double getPercentage(int starCount);
}
```

## Cubit Methods

### ReviewsCubit
- `loadReviews()`: Loads review data (currently mocked)
- `changeSortOption(String sortOption)`: Changes the sorting of reviews
- `_sortReviews(String sortOption)`: Internal method for sorting logic

## Widgets

### StarRating
Reusable widget for displaying star ratings with customizable:
- Rating value
- Star size
- Filled and unfilled colors
- Support for half-star ratings

### RatingBreakdownWidget
Displays the distribution of ratings with:
- Star indicators
- Progress bars
- Count displays

### ReviewItem
Individual review display with:
- Star rating
- Comment text
- Reviewer name
- Time posted

## Usage

To use the Reviews screen, simply navigate to it:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ReviewsScreen()),
);
```

## Mock Data

The current implementation includes mock data that matches the design:
- 8 sample reviews with realistic content
- Rating breakdown with 1034 total ratings
- Average rating of 4.0 stars
- Various time formats (days ago, weeks ago, months ago)

## Future Enhancements

1. **API Integration**: Replace mock data with real API calls
2. **Pagination**: Add pagination for large review lists
3. **Review Filtering**: Add filters by rating, date, etc.
4. **Review Submission**: Allow users to submit their own reviews
5. **Image Support**: Display reviewer profile images
6. **Review Helpfulness**: Add helpful/not helpful voting
7. **Review Replies**: Allow sellers to reply to reviews 