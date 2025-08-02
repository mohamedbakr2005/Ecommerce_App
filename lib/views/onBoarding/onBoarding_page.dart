import 'package:e_commerce/core/components/bottom_sheet.dart';
import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onBoarding),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // Safe Area Content
          SafeArea(
            child: Column(
              children: [
                // Top spacer to account for status bar
                SizedBox(height: 20.h),

                // Main content area
                Expanded(child: Container()),
              ],
            ),
          ),

          // Responsive Bottom Sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ButtonSheet(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.signup,
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
