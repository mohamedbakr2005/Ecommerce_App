import 'package:e_commerce/core/Api/Authentication/AuthRepository.dart';
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
    emit(state.copyWith(isLoading: true));
    try {
      bool success = await AuthRepository().signin(
        state.emailController.text,
        state.passwordController.text,
      );

      if (success) {
        emit(state.copyWith(isLoading: false));
        print("Login Success");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      } else {
        emit(state.copyWith(isLoading: false));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed, please try again")),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Login error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
