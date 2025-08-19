import 'package:e_commerce/core/Api/ResetPassword/ResetPasswordRepo.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/verification_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class VerificationCodeCubit extends Cubit<VerificationCodeState> {
  VerificationCodeCubit({required String email})
    : super(
        VerificationCodeState(
          isLoading: false,
          codeControllers: List.generate(6, (_) => TextEditingController()),
          focusNodes: List.generate(6, (_) => FocusNode()),
          email: email,
        ),
      );

  void onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      // Move to next field
      state.focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field on backspace
      state.focusNodes[index - 1].requestFocus();
    }

    emit(state.copyWith());
  }

  void resendCode(BuildContext context) {
    // Start loading
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    Future.delayed(const Duration(seconds: 2))
        .then((_) {
          // Stop loading
          emit(state.copyWith(isLoading: false));

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('New verification code sent to your email'),
              backgroundColor: Colors.green,
            ),
          );
        })
        .catchError((error) {
          // Stop loading
          emit(state.copyWith(isLoading: false));

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        });
  }

  Future<void> verifyCode(BuildContext context) async {
    // Validate code
    if (!state.isCodeComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 6-digit code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final code = state.codeControllers.map((c) => c.text).join().trim();

    print(code);
    // Start loading
    emit(state.copyWith(isLoading: true));

    try {
      await Resetpasswordrepo().verifyResetCode(state.email, code);

      // Stop loading
      emit(state.copyWith(isLoading: false));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Code verified successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to password reset screen
      Navigator.pushNamed(
        context,
        AppRoutes.passwordReset,
        arguments: {"email": state.email, "code": code},
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
    // Dispose controllers and focus nodes
    for (var controller in state.codeControllers) {
      controller.dispose();
    }
    for (var focusNode in state.focusNodes) {
      focusNode.dispose();
    }
    return super.close();
  }
}
