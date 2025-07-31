import 'package:e_commerce/views/SignUp/cubit/SignUp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit()
    : super(
        SignUpState(
          isPasswordVisible: false,
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

  @override
  Future<void> close() {
    state.fullNameController.dispose();
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
