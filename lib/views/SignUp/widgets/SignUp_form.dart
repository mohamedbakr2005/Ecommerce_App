import 'dart:convert';

import 'package:e_commerce/core/Api/ApiService/api_service.dart';
import 'package:e_commerce/core/components/app_button.dart';
import 'package:e_commerce/core/components/app_text_form_field.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/SignUp/cubit/SignUp_cubit.dart';
import 'package:e_commerce/views/SignUp/cubit/SignUp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key, required this.state});
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   clientId:
  //       "999410073682-0i7678133vgauq8e275jnmeces6put3k.apps.googleusercontent.com",
  //   scopes: ['email', 'profile', 'openid'],
  // );

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final account = await _googleSignIn.signIn();
  //     if (account == null) return; // المستخدم لغى العملية

  //     final authentication = await account.authentication;

  //     final idToken = authentication.idToken; // ده اللي هنبعته للـ API

  //     print(idToken);
  //     // ابعته للسيرفر بتاعك
  //     final response = await http.post(
  //       Uri.parse('${ApiService.baseUrl}/auth/google-login'),
  //       body: jsonEncode({'idToken': idToken}),
  //       headers: {'Content-Type': 'application/json'},
  //     );

  //     if (response.statusCode == 200) {
  //       print('تم تسجيل الدخول بنجاح!');
  //     } else {
  //       print('فشل تسجيل الدخول: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  final SignUpState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Full Name
          Text(
            "Full Name",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          verticalSpace(5),
          AppTextFormField(
            controller: state.fullNameController,
            hintText: "Enter your full name",
            validator: ValidationBuilder().minLength(5).maxLength(50).build(),
          ),
          verticalSpace(20),

          /// Email
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
            hintText: "Enter your email",
            validator: ValidationBuilder()
                .required("Email is required")
                .email("Enter a valid email")
                .maxLength(50, "Email can’t be longer than 50 chars")
                .build(),
          ),
          verticalSpace(20),

          /// Password
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
                context.read<SignUpCubit>().togglePasswordVisibility();
              },
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
          verticalSpace(10),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "By signing up, you agree to our ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black.withOpacity(0.7),
                  ),
                ),
                TextSpan(
                  text: "Terms",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withOpacity(0.9),
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ", Privacy Policy,",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withOpacity(0.9),
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: " and ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black.withOpacity(0.7),
                  ),
                ),
                TextSpan(
                  text: "Cookies Use",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withOpacity(0.9),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),
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
                        "Creating account...",
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
                      context.read<SignUpCubit>().signUp(context);
                    }
                  },
                  text: "Create an account",
                  backgroundColor: state.isFormValid
                      ? AppColors.primary
                      : AppColors.gray,
                ),
          verticalSpace(20),

          /// Divider
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

          /// Google Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
                side: BorderSide(color: AppColors.gray),
              ),
            ),
            onPressed: () {
              // signInWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.google, width: 20.w, height: 20.h),
                horizontalSpace(10),
                Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),

          /// Facebook Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.facebook,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.w),
                side: BorderSide(color: AppColors.gray),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.facebook, width: 20.w, height: 20.h),
                horizontalSpace(10),
                Text(
                  "Continue with Facebook",
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

          /// Login Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
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
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
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
