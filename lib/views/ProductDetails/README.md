# Product Details Module

This module handles the display and interaction with individual product details in the e-commerce app.

## Structure

```
ProductDetails/
├── cubit/
│   ├── product_details_cubit.dart      # Business logic for product details
│   └── product_details_state.dart      # State management
├── models/
│   └── product_details_model.dart      # Data model for product details
├── widgets/
│   ├── size_selector.dart              # Size selection widget
│   ├── color_selector.dart             # Color selection widget
│   └── add_to_cart_button.dart         # Add to cart button widget
├── Product_details_Screen.dart         # Main product details screen
└── README.md                           # This file
```

## Features

- **Product Image Display**: Large product image with favorite button
- **Product Information**: Name, rating, reviews, and description
- **Size Selection**: Interactive size buttons (S, M, L)
- **Color Selection**: Color circles with selection indicators
- **Add to Cart**: Bottom button with price display
- **Favorite Toggle**: Heart icon in header and image overlay
- **Loading States**: Handles loading, error, and empty states
- **Responsive Design**: Uses ScreenUtil for responsive sizing

## Usage

To use this screen, wrap it with a BlocProvider and pass a product ID:

```dart
BlocProvider(
  create: (context) => ProductDetailsCubit(),
  child: ProductDetailsScreen(productId: 'product_id'),
)
```

Or navigate to it:

```dart
Navigator.pushNamed(
  context,
  AppRoutes.productDetails,
  arguments: 'product_id',
);
```

## State Management

The module uses BLoC pattern with Cubit for state management:

- **ProductDetailsCubit**: Manages the business logic
- **ProductDetailsState**: Represents the current state
- **ProductDetailsModel**: Data structure for product details
- **ColorOption**: Data structure for color options

## Key Features

- **Size Selection**: Users can select from available sizes
- **Color Selection**: Users can select from available colors with visual indicators
- **Add to Cart**: Button is enabled only when both size and color are selected
- **Favorite Toggle**: Users can add/remove products from favorites
- **Navigation**: Integrated with the app's navigation system

## Assets Used

- `assets/images/home*.png`: Product images (mock data)
- Material Icons: For various UI elements 