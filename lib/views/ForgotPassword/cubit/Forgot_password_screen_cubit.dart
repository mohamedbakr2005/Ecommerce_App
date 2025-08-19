import 'package:e_commerce/core/Api/ResetPassword/ResetPasswordRepo.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
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

    emit(state.copyWith(isLoading: true));

    try {
      await Resetpasswordrepo().sendResetCode(state.emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code sent to your email'),
          backgroundColor: Colors.green,
        ),
      );
      emit(state.copyWith(isLoading: false));
      Navigator.pushNamed(
        context,
        AppRoutes.verification,
        arguments: state.emailController.text,
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
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
