import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/Address/models/address_model.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: address.isSelected
                ? AppColors.black
                : AppColors.gray.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            // Location Icon
            Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: AppColors.gray,
            ),
            SizedBox(width: 12.w),

            // Address Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address.nickname,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      if (address.isDefault) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gray.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    address.fullAddress,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Action Buttons
            if (onEdit != null || onDelete != null) ...[
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.gray),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onEdit?.call();
                      break;
                    case 'delete':
                      onDelete?.call();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (onEdit != null)
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 16.sp),
                          SizedBox(width: 8.w),
                          Text('Edit'),
                        ],
                      ),
                    ),
                  if (onDelete != null)
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 16.sp,
                            color: AppColors.red,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Delete',
                            style: TextStyle(color: AppColors.red),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(width: 8.w),
            ],

            // Selection Radio Button
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: address.isSelected
                      ? AppColors.black
                      : AppColors.gray.withOpacity(0.3),
                  width: 2.w,
                ),
                color: address.isSelected ? AppColors.black : AppColors.white,
              ),
              child: address.isSelected
                  ? Icon(Icons.check, size: 12.sp, color: AppColors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
