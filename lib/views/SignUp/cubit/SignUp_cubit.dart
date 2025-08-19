import 'package:e_commerce/core/Api/Authentication/AuthRepository.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/SignUp/cubit/SignUp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit()
    : super(
        SignUpState(
          isPasswordVisible: false,
          isLoading: false,
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        ),
      );

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void onFullNameChanged(String value) {
    emit(state.copyWith());
  }

  void onEmailChanged(String value) {
    emit(state.copyWith());
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith());
  }

  Future<void> signUp(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await AuthRepository().signup(
        state.fullNameController.text,
        state.emailController.text,
        state.passwordController.text,
      );

      emit(state.copyWith(isLoading: false));
      print("Sign Up Success: $response");

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login, // أو AppRoutes.home
        (route) => false,
      );
        } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Signup error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Future<void> close() {
    state.fullNameController.dispose();
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
