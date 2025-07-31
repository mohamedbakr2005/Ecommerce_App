import 'package:flutter/material.dart';

class LoginState {
  final bool isPasswordVisible;
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginState({
    required this.isPasswordVisible,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
  });

  bool get isFormValid =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  LoginState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
