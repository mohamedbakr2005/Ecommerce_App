import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_cubit.dart';
import 'package:e_commerce/views/ForgotPassword/cubit/reset_password_state.dart';
import 'package:e_commerce/views/ForgotPassword/Widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            body: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back button
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                              size: 24.sp,
                            ),
                          ),
                          verticalSpace(20),

                          // Title
                          Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          verticalSpace(16),

                          // Description text
                          Text(
                            "Set the new password for your account so you can login and access all the features.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray,
                            ),
                          ),
                          verticalSpace(40),

                          // Reset Password Form
                          ResetPasswordForm(state: state),

                          verticalSpace(20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
