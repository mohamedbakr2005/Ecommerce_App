import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/Forgot_password_screen_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/Forgot_password_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForm extends StatelessWidget {
  final ForgotPasswordState state;

  const ForgotPasswordForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email input section
        Text(
          "Email",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        verticalSpace(12),

        // Email text field
        AppTextFormField(
          controller: state.emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!value.contains('@')) {
              return 'Invalid email address';
            }
            return null;
          },
          onChanged: (value) =>
              context.read<ForgotPasswordCubit>().onEmailChanged(value),
        ),
        verticalSpace(40),

        // Send Code button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
            onPressed: state.isLoading
                ? null
                : () => context.read<ForgotPasswordCubit>().sendCode(context),
            child: state.isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white,
                      ),
                    ),
                  )
                : Text(
                    "Send Code",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
