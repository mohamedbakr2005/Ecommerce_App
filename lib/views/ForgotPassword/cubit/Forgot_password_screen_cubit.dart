import 'package:e_commerce/views/ForgotPassword/cubit/Forgot_password_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit()
    : super(
        ForgotPasswordState(
          isLoading: false,
          emailController: TextEditingController(),
        ),
      );

  void onEmailChanged(String value) {
    emit(state.copyWith());
  }

  Future<void> sendCode(BuildContext context) async {
    // Validate email
    if (!state.isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Start loading
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Stop loading
      emit(state.copyWith(isLoading: false));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code sent to your email'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to verification screen
      Navigator.pushNamed(
        context,
        '/verification',
        arguments: state.emailController.text,
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
    state.emailController.dispose();
    return super.close();
  }
}
