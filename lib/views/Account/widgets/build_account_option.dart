import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BuildAccountOption extends StatelessWidget {
  const BuildAccountOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? AppColors.red : AppColors.black),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? AppColors.red : AppColors.black,
            fontSize: 16,
          ),
        ),
        trailing: isLogout
            ? null
            : const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.gray,
                size: 16,
              ),
        onTap: onTap,
      ),
    );
  }
}
