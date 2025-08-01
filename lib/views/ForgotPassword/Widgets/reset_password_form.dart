import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  final ResetPasswordState state;

  const ResetPasswordForm({super.key, required this.state});

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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },

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
          "Password",
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },

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
