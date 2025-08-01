import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/init/cubit/bottom_nav_cubit.dart';
import 'package:e_commerce/views/init/cubit/bottom_nav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    context,
                    index: 0,
                    icon: "assets/icons/home.svg",
                    activeIcon: "assets/icons/home.svg",
                    label: 'Home',
                    isActive: state.currentIndex == 0,
                  ),
                  _buildNavItem(
                    context,
                    index: 1,
                    icon: "assets/icons/search.svg",
                    activeIcon: "assets/icons/search.svg",
                    label: 'Search',
                    isActive: state.currentIndex == 1,
                  ),
                  _buildNavItem(
                    context,
                    index: 2,
                    icon: "assets/icons/fav.svg",
                    activeIcon: "assets/icons/fav.svg",
                    label: 'Saved',
                    isActive: state.currentIndex == 2,
                  ),
                  _buildNavItem(
                    context,
                    index: 3,
                    icon: "assets/icons/cart.svg",
                    activeIcon: "assets/icons/cart.svg",
                    label: 'Cart',
                    isActive: state.currentIndex == 3,
                  ),
                  _buildNavItem(
                    context,
                    index: 4,
                    icon: "assets/icons/profile.svg",
                    activeIcon: "assets/icons/profile.svg",
                    label: 'Account',
                    isActive: state.currentIndex == 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String icon,
    required String activeIcon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => context.read<BottomNavCubit>().changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isActive ? activeIcon : icon,
            width: 24.w,
            height: 24.h,
            color: isActive ? AppColors.black : AppColors.gray,
          ),

          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isActive ? AppColors.black : AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
