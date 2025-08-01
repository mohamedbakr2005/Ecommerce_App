import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit()
    : super(
        ResetPasswordState(
          isLoading: false,
          newPasswordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          isNewPasswordVisible: false,
          isConfirmPasswordVisible: false,
        ),
      );

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void onNewPasswordChanged(String value) {
    emit(state.copyWith());
  }

  void onConfirmPasswordChanged(String value) {
    emit(state.copyWith());
  }

  Future<void> resetPassword(BuildContext context) async {
    // Validate passwords
    if (!state.isFormValid) {
      if (state.newPasswordController.text.isEmpty ||
          state.confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (state.newPasswordController.text !=
          state.confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (state.newPasswordController.text.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password must be at least 8 characters long'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      return;
    }

    // Start loading
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Stop loading
      emit(state.copyWith(isLoading: false));

      // Navigate to success screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/passwordResetSuccess',
        (route) => false,
      );
    } catch (e) {
      // Stop loading
      emit(state.copyWith(isLoading: false));

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    state.newPasswordController.dispose();
    state.confirmPasswordController.dispose();
    return super.close();
  }
}
