import 'dart:ffi';

import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class ResetPasswordForm extends StatelessWidget {
  final ResetPasswordState state;
  final String email;
  final String code;

  const ResetPasswordForm({
    super.key,
    required this.state,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // New Password field
        Text(
          "Password",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        verticalSpace(12),

        AppTextFormField(
          controller: state.newPasswordController,
          obscureText: !state.isNewPasswordVisible,
          hintText: "Enter your new password",
          onChanged: (value) =>
              context.read<ResetPasswordCubit>().onNewPasswordChanged(value),
          validator: ValidationBuilder()
              .required("Password is required")
              .minLength(8, "Password must be at least 8 characters")
              .regExp(
                RegExp(r'[A-Z]'),
                "Password must contain at least one uppercase letter",
              )
              .regExp(
                RegExp(r'[0-9]'),
                "Password must contain at least one number",
              )
              .build(),

          suffixIcon: IconButton(
            onPressed: () => context
                .read<ResetPasswordCubit>()
                .toggleNewPasswordVisibility(),
            icon: Icon(
              state.isNewPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.gray,
            ),
          ),
        ),

        verticalSpace(20),

        // Confirm Password field
        Text(
          "Confirm Password",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: state.confirmPasswordController,
          obscureText: !state.isNewPasswordVisible,
          hintText: "Enter your new password",
          onChanged: (value) => context
              .read<ResetPasswordCubit>()
              .onConfirmPasswordChanged(value),
          validator: ValidationBuilder()
              .required("Password is required")
              .minLength(8, "Password must be at least 8 characters")
              .regExp(
                RegExp(r'[A-Z]'),
                "Password must contain at least one uppercase letter",
              )
              .regExp(
                RegExp(r'[0-9]'),
                "Password must contain at least one number",
              )
              .build(),

          suffixIcon: IconButton(
            onPressed: () => context
                .read<ResetPasswordCubit>()
                .toggleNewPasswordVisibility(),
            icon: Icon(
              state.isNewPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.gray,
            ),
          ),
        ),
        verticalSpace(40),

        // Continue button
        AppButton(
          onPressed: state.isLoading || !state.isFormValid
              ? null
              : () => context.read<ResetPasswordCubit>().resetPassword(context),
          text: "Continue",
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
