# Search Module

This module implements a comprehensive search functionality for the e-commerce app with the following features:

## Features

1. **Search Interface**: Clean and intuitive search interface with real-time search suggestions
2. **Recent Searches**: Displays and manages recent search terms
3. **Search Results**: Shows filtered product results based on search query
4. **No Results State**: Handles cases when no products match the search criteria
5. **State Management**: Uses BLoC pattern with Cubit for state management

## File Structure

```
lib/views/Search/
├── cubit/
│   ├── search_cubit.dart      # Search business logic and state management
│   └── search_state.dart      # Search state definition
├── models/
│   └── search_product_model.dart  # Product model for search results
├── widgets/
│   ├── no_results_widget.dart     # Widget for no results state
│   ├── recent_search_item.dart    # Individual recent search item
│   └── search_result_item.dart    # Individual search result item
├── search_screen.dart             # Main search screen
└── README.md                      # This documentation
```

## Components

### SearchCubit
- Manages search state and business logic
- Handles real-time search with debouncing
- Manages recent searches (add, remove, clear all)
- Filters products based on search query

### SearchState
- Contains all search-related state data:
  - `isLoading`: Loading state indicator
  - `searchController`: Text editing controller
  - `recentSearches`: List of recent search terms
  - `searchResults`: Filtered product results
  - `hasSearched`: Whether a search has been performed
  - `currentQuery`: Current search query

### SearchProductModel
- Represents a product in search results
- Contains product details: id, name, price, discount, image, category

## Usage

To navigate to the search screen:

```dart
Navigator.pushNamed(context, AppRoutes.search);
```

## Search Functionality

1. **Real-time Search**: As user types, results are filtered automatically
2. **Recent Searches**: Click on recent search to perform that search again
3. **Remove Recent Search**: Tap the X button to remove individual recent searches
4. **Clear All**: Clear all recent searches with the "Clear all" button
5. **Voice Search**: Microphone icon for voice search (UI only, not implemented)

## States

1. **Initial State**: Shows recent searches
2. **Loading State**: Shows loading indicator while searching
3. **Results State**: Shows filtered product results
4. **No Results State**: Shows "No Results Found!" message with suggestions

## Mock Data

The search functionality uses mock product data for demonstration:
- Regular Fit Slogan ($1,190)
- Regular Fit Polo ($1,100, -52% discount)
- Regular Fit Black ($1,690)
- Regular Fit V-Neck ($1,290)

## Integration

The search screen integrates with:
- Navigation system (back button, notifications)
- Product details page (tapping on search results)
- App theme and styling system
- Responsive design with ScreenUtil 