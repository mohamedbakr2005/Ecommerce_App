import 'package:flutter/material.dart';

class SignUpState {
  final bool isPasswordVisible;
  final bool isLoading;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;


  SignUpState({
    required this.isPasswordVisible,
    required this.isLoading,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  });

  bool get isFormValid =>
      fullNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty;

  SignUpState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    TextEditingController? fullNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return SignUpState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      fullNameController: fullNameController ?? this.fullNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
