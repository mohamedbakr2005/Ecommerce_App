# Forgot Password Screen

This directory contains the implementation of the forgot password screen for the e-commerce app.

## Structure

```
ForgotPassword/
├── cubit/
│   ├── Forgot_password_screen_cubit.dart    # Business logic and state management
│   ├── Forgot_password_screen_state.dart    # State class definition
│   ├── verification_code_cubit.dart         # Verification code business logic
│   ├── verification_code_state.dart         # Verification code state
│   ├── reset_password_cubit.dart            # Reset password business logic
│   └── reset_password_state.dart            # Reset password state
├── Widgets/
│   ├── forgot_password_form.dart           # Form widget component
│   ├── verification_code_form.dart         # Verification code form widget
│   └── reset_password_form.dart            # Reset password form widget
├── Forgot_password_screen.dart             # Main forgot password screen
├── verification_code_screen.dart           # Verification code screen
├── reset_password_screen.dart              # Reset password screen
├── password_reset_success_screen.dart      # Password reset success screen
└── README.md                              # This documentation
```

## Features

### Forgot Password Screen
- **Email Input**: Users can enter their email address for password recovery
- **Form Validation**: Basic email validation before sending code
- **Loading State**: Shows loading indicator during API call simulation
- **Success/Error Messages**: Displays appropriate feedback to users
- **Navigation**: Back button to return to previous screen

### Verification Code Screen
- **6-Digit Code Input**: Individual input fields for each digit
- **Auto-focus Navigation**: Automatically moves to next field when digit is entered
- **Resend Code**: Option to request a new verification code
- **Form Validation**: Ensures all 6 digits are entered before proceeding
- **Loading States**: Shows loading indicators during API calls
- **Email Display**: Shows the email address where the code was sent

### Reset Password Screen
- **Password Input**: Two password fields for new password and confirmation
- **Password Visibility Toggle**: Eye icons to show/hide password text
- **Form Validation**: Ensures passwords match and meet minimum requirements
- **Loading States**: Shows loading indicator during password reset
- **Error Handling**: Displays validation errors for mismatched passwords

### Password Reset Success Screen
- **Success Icon**: Large green checkmark icon
- **Success Message**: Confirms password has been changed
- **Login Button**: Direct navigation back to login screen
- **Clean Design**: Minimalist success screen design

## Usage

To navigate to this screen from the login screen, use:

```dart
Navigator.pushNamed(context, AppRoutes.forgotPassword);
```

## State Management

The screens use BLoC pattern with Cubit for state management:

### Forgot Password Screen
- **ForgotPasswordCubit**: Handles business logic and API calls
- **ForgotPasswordState**: Contains the current state (loading, email controller)

### Verification Code Screen
- **VerificationCodeCubit**: Handles code input logic and verification
- **VerificationCodeState**: Contains the current state (loading, code controllers, focus nodes, email)

### Reset Password Screen
- **ResetPasswordCubit**: Handles password validation and reset functionality
- **ResetPasswordState**: Contains the current state (loading, password controllers, visibility states)

## API Integration

Currently, the screen simulates an API call with a 2-second delay. To integrate with a real API:

1. Replace the `Future.delayed` in `sendCode` method with actual API call
2. Handle different response scenarios (success, error, invalid email)
3. Add proper error handling and retry mechanisms

## Customization

- Colors are defined in `lib/core/constants/app_colors.dart`
- Spacing utilities are in `lib/core/constants/app_spacing.dart`
- Form validation uses `lib/core/utils/validators.dart` 