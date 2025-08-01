import 'package:flutter/material.dart';

class ForgotPasswordState {
  final bool isLoading;
  final TextEditingController emailController;

  ForgotPasswordState({required this.isLoading, required this.emailController});

  bool get isFormValid => emailController.text.isNotEmpty;

  ForgotPasswordState copyWith({
    bool? isLoading,
    TextEditingController? emailController,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      emailController: emailController ?? this.emailController,
    );
  }
}
