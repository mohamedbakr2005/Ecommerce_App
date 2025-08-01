# Filters Feature

This directory contains the implementation of the filters functionality for the e-commerce app.

## Overview

The filters feature allows users to:
- Sort products by relevance, price (low to high), or price (high to low)
- Filter products by price range using a slider
- Select product sizes
- Apply multiple filters simultaneously

## Files

### `filters_screen.dart`
The main filters screen that displays as a modal bottom sheet. It includes:
- Sort options (Relevance, Price: Low - High, Price: High - Low)
- Price range slider with customizable min/max values
- Size selector with dropdown functionality
- Apply filters button

### Integration with Home Screen

The filters are integrated with the Home screen through:
- `HomeCubit` - Manages filter state and applies filtering logic
- `HomeState` - Contains filter properties (sortBy, priceRange, selectedSize)
- `HomeScreen` - Shows the filters modal when the filter button is tapped

## Features

### Sorting
- **Relevance**: Maintains original product order
- **Price: Low - High**: Sorts products by price in ascending order
- **Price: High - Low**: Sorts products by price in descending order

### Price Filtering
- Uses a `RangeSlider` widget
- Price range: $0 - $5000
- Real-time price display above the slider
- Filters products within the selected price range

### Size Selection
- Dropdown-style size picker
- Available sizes: XS, S, M, L, XL, XXL
- Modal bottom sheet for size selection
- Visual feedback for selected size

### Filter Application
- Filters are applied immediately when "Apply Filters" is pressed
- Multiple filters can be applied simultaneously
- Filter state is maintained in the Home cubit
- Products are filtered and sorted based on all active filters

## Usage

1. Tap the filter button (tune icon) in the Home screen
2. Select sorting option from the horizontal buttons
3. Adjust price range using the slider
4. Tap size selector to choose a size
5. Press "Apply Filters" to apply all filters
6. Products will be filtered and sorted according to the selected criteria

## State Management

The filters use BLoC pattern with:
- **HomeCubit**: Manages filter state and business logic
- **HomeState**: Contains all filter-related properties
- **applyFilters()**: Method to update filter state
- **filteredProducts**: Getter that applies all filters and sorting

## Design

The filters screen follows the app's design system:
- Rounded corners and modern UI
- Consistent color scheme using `AppColors`
- Responsive design with `ScreenUtil`
- Smooth animations and transitions 