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
    await Future.delayed(const Duration(seconds: 5));

    // Stop loading
    emit(state.copyWith(isLoading: false));

    // Navigate to next screen (you can change this to your desired route)
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home', // Replace with your actual route
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
