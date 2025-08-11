import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Account/cubit/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  void logout() {
    emit(AccountLoading());
    try {
      // TODO: Implement logout logic
      // Clear user data, tokens, etc.
      emit(AccountLoaded());
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  void navigateToOrders(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myOrdersScreen);
  }

  void navigateToDetails() {
    // TODO: Navigate to details screen
  }

  void navigateToAddressBook() {
    // TODO: Navigate to address book screen
  }

  void navigateToPaymentMethods() {
    // TODO: Navigate to payment methods screen
  }

  void navigateToNotifications() {
    // TODO: Navigate to notifications screen
  }

  void navigateToFAQs() {
    // TODO: Navigate to FAQs screen
  }

  void navigateToHelpCenter() {
    // TODO: Navigate to help center screen
  }
}
