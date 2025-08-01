import 'package:flutter/material.dart';

class ResetPasswordState {
  final bool isLoading;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;

  ResetPasswordState({
    required this.isLoading,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.isNewPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  bool get isFormValid =>
      newPasswordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty &&
      newPasswordController.text == confirmPasswordController.text &&
      newPasswordController.text.length >= 8;

  ResetPasswordState copyWith({
    bool? isLoading,
    TextEditingController? newPasswordController,
    TextEditingController? confirmPasswordController,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      newPasswordController:
          newPasswordController ?? this.newPasswordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}
