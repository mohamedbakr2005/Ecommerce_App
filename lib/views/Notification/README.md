# Notification Screen

This directory contains the notification screen implementation with Cubit state management.

## Structure

```
Notification/
├── cubit/
│   ├── notification_cubit.dart      # State management logic
│   └── notification_state.dart      # State definitions
├── models/
│   └── notification_model.dart      # Data models
├── widgets/
│   ├── notification_item.dart       # Individual notification item
│   └── notification_empty_state.dart # Empty state widget
├── notification_screen.dart         # Main screen
└── README.md                        # This file
```

## Features

- **Cubit State Management**: Uses flutter_bloc for state management
- **Organized by Date**: Notifications are grouped by date (Today, Yesterday, etc.)
- **Icons from Assets**: Uses SVG icons from `assets/icons/` folder
- **Empty State**: Shows a friendly message when no notifications exist
- **Loading State**: Shows loading indicator while fetching data
- **Error Handling**: Displays error messages if something goes wrong

## Usage

To navigate to the notification screen:

```dart
Navigator.pushNamed(context, AppRoutes.notifications);
```

## Icons Used

The notification screen uses the following icons from `assets/icons/`:
- `notification.svg` - Main notification icon
- `discount.svg` - Discount notifications
- `wallet.svg` - Wallet/e-wallet notifications
- `location.svg` - Location/tracking notifications
- `credit-card.svg` - Payment notifications
- `account.svg` - Account-related notifications

## States

- `NotificationInitial` - Initial state
- `NotificationLoading` - Loading state
- `NotificationLoaded` - Data loaded successfully
- `NotificationEmpty` - No notifications available
- `NotificationError` - Error occurred

## Mock Data

The screen currently uses mock data that includes:
- Today: 30% Special Discount notification
- Yesterday: E-wallet top-up and new service notifications
- June 7, 2023: Credit card connection and account setup notifications 