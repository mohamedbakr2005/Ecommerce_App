# Saved Items Module

This module handles the display and management of saved/favorited items in the e-commerce app.

## Structure

```
SavedItems/
├── cubit/
│   ├── saved_items_cubit.dart      # Business logic for saved items
│   └── saved_items_state.dart      # State management
├── models/
│   └── saved_item_model.dart       # Data model for saved items
├── widgets/
│   ├── saved_item_card.dart        # Individual saved item card widget
│   └── empty_saved_items.dart      # Empty state widget
├── Saved_items_screen.dart         # Main saved items screen
└── README.md                       # This file
```

## Features

- **Grid Layout**: Displays saved items in a 2-column grid
- **Empty State**: Shows a heart icon with message when no items are saved
- **Remove Items**: Tap the heart icon to remove items from saved list
- **Loading States**: Handles loading, error, and empty states
- **Responsive Design**: Uses ScreenUtil for responsive sizing

## Usage

To use this screen, wrap it with a BlocProvider:

```dart
BlocProvider(
  create: (context) => SavedItemsCubit(),
  child: const SavedItemsScreen(),
)
```

## State Management

The module uses BLoC pattern with Cubit for state management:

- **SavedItemsCubit**: Manages the business logic
- **SavedItemsState**: Represents the current state
- **SavedItemModel**: Data structure for saved items

## Assets Used

- `assets/icons/fav.svg`: Heart icon for favorite functionality
- `assets/images/home*.png`: Product images (mock data) 