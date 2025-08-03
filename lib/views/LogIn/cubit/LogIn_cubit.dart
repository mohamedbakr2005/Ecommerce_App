import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/LogIn/cubit/Login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
    : super(
        LoginState(
          isPasswordVisible: false,
          isLoading: false,
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        ),
      );

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith());
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith());
  }

  Future<void> login(BuildContext context) async {
    // Start loading
    emit(state.copyWith(isLoading: true));

    // Wait for 5 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Stop loading
    emit(state.copyWith(isLoading: false));

    // Navigate to main app with bottom navigation
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
