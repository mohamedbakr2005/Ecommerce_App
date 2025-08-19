import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/LogIn/cubit/LogIn_cubit.dart';
import 'package:e_commerce/views/LogIn/cubit/Login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key, required this.state});

  final LoginState state;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.emailController,
            hintText: "Enter your email address",
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder()
                .required("Email is required")
                .email("Enter a valid email")
                .maxLength(50, "Email can’t be longer than 50 chars")
                .build(),
          ),
          verticalSpace(20),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.passwordController,
            hintText: "Enter your password",
            obscureText: !state.isPasswordVisible,
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
              onPressed: () {
                context.read<LoginCubit>().togglePasswordVisibility();
              },
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Forgot your password? ",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPassword);
                },
                child: Text(
                  "Reset your password",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(30),
          state.isLoading
              ? Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Text(
                        "Logging in...",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : AppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(context);
                    }
                  },
                  text: "Login",
                  backgroundColor: state.isFormValid
                      ? AppColors.primary
                      : AppColors.gray,
                ),
          verticalSpace(30),
          Row(
            children: [
              const Expanded(child: Divider()),
              horizontalSpace(10),
              Text(
                "Or",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray,
                ),
              ),
              horizontalSpace(10),
              const Expanded(child: Divider()),
            ],
          ),
          verticalSpace(20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
                side: BorderSide(color: AppColors.gray),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.google, width: 20.w, height: 20.h),
                horizontalSpace(10),
                Text(
                  "Login with Google",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.facebook,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.facebook, width: 20.w, height: 20.h),
                horizontalSpace(10),
                Text(
                  "Login with Facebook",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.signup,
                    (route) => false,
                  );
                },
                child: Text(
                  "Join",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
