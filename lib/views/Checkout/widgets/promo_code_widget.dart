import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';

class PromoCodeWidget extends StatefulWidget {
  final String? currentPromoCode;
  final bool isPromoCodeApplied;
  final Function(String) onApplyPromoCode;
  final VoidCallback onRemovePromoCode;

  const PromoCodeWidget({
    super.key,
    this.currentPromoCode,
    required this.isPromoCodeApplied,
    required this.onApplyPromoCode,
    required this.onRemovePromoCode,
  });

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  final TextEditingController _promoCodeController = TextEditingController();
  final FocusNode _promoCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.currentPromoCode != null) {
      _promoCodeController.text = widget.currentPromoCode!;
    }
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    _promoCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray.withOpacity(0.2),
            width: 1.w,
          ),
        ),
      ),
      child: Column(
        children: [
          // Promo Code Input Row
          Row(
            children: [
              // Promo Code Input Field
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textInputBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.gray.withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        size: 20.sp,
                        color: AppColors.gray,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextField(
                          controller: _promoCodeController,
                          focusNode: _promoCodeFocusNode,
                          enabled: !widget.isPromoCodeApplied,
                          decoration: InputDecoration(
                            hintText: 'Enter promo code',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.placeholder,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Add/Remove Button
              GestureDetector(
                onTap: () {
                  if (widget.isPromoCodeApplied) {
                    widget.onRemovePromoCode();
                    _promoCodeController.clear();
                  } else {
                    final promoCode = _promoCodeController.text.trim();
                    if (promoCode.isNotEmpty) {
                      widget.onApplyPromoCode(promoCode);
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isPromoCodeApplied
                        ? AppColors.red
                        : AppColors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    widget.isPromoCodeApplied ? 'Remove' : 'Add',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Promo Code Applied Message
          if (widget.isPromoCodeApplied && widget.currentPromoCode != null)
            Container(
              margin: EdgeInsets.only(top: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.coloredBackground,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Promo code "${widget.currentPromoCode}" applied successfully!',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
