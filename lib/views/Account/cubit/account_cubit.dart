import 'package:e_commerce/core/Api/Authentication/AuthRepository.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Account/cubit/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  final AuthRepository _authRepository = AuthRepository();

  void logout(BuildContext context) async {
    emit(AccountLoading());
    try {
      await _authRepository.logout();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
      emit(AccountLoaded());
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  void navigateToOrders(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myOrdersScreen);
  }

  void navigateToDetails(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.myDetailsScreen);
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
