import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/views/Address/models/address_model.dart';

class AddAddressForm extends StatefulWidget {
  final AddressFormData? initialData;
  final Function(AddressFormData) onSubmit;

  const AddAddressForm({super.key, this.initialData, required this.onSubmit});

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nicknameFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  String? _selectedNickname;
  bool _isDefault = false;
  bool _isLoading = false;

  final List<String> _nicknameOptions = [
    'Home',
    'Office',
    'Apartment',
    'Parent\'s House',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _nicknameController.text = widget.initialData!.nickname;
      _addressController.text = widget.initialData!.fullAddress;
      _selectedNickname = widget.initialData!.nickname;
      _isDefault = widget.initialData!.isDefault;
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _addressController.dispose();
    _nicknameFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _selectedNickname != null &&
        _selectedNickname!.isNotEmpty &&
        _addressController.text.trim().isNotEmpty;
  }

  void _showNicknameDropdown() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.gray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Address Nickname',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ...(_nicknameOptions
                      .map(
                        (nickname) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedNickname = nickname;
                              _nicknameController.text = nickname;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.gray.withOpacity(0.2),
                                  width: 1.w,
                                ),
                              ),
                            ),
                            child: Text(
                              nickname,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_isFormValid) return;

    setState(() {
      _isLoading = true;
    });

    final formData = AddressFormData(
      nickname: _selectedNickname!,
      fullAddress: _addressController.text.trim(),
      isDefault: _isDefault,
    );

    // Call the onSubmit callback
    widget.onSubmit(formData);

    // Keep loading state true until modal is closed
    // The loading state will be reset when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: AppColors.black),
                ),
              ],
            ),
          ),

          // Divider
          Container(height: 1.h, color: AppColors.gray.withOpacity(0.2)),

          // Form Content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Nickname
                Text(
                  'Address Nickname',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: _showNicknameDropdown,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.gray.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedNickname ?? 'Choose one',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: _selectedNickname != null
                                  ? AppColors.black
                                  : AppColors.placeholder,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.sp,
                          color: AppColors.gray,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Full Address
                Text(
                  'Full Address',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _addressController,
                  focusNode: _addressFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter your full address...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.placeholder,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.gray.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.gray.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.black,
                        width: 1.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  maxLines: 3,
                ),

                SizedBox(height: 20.h),

                // Default Address Checkbox
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDefault = !_isDefault;
                        });
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: _isDefault ? AppColors.black : AppColors.white,
                          border: Border.all(
                            color: AppColors.gray.withOpacity(0.3),
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: _isDefault
                            ? Icon(
                                Icons.check,
                                size: 14.sp,
                                color: AppColors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Make this as a default address',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isFormValid && !_isLoading ? _submitForm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? AppColors.black
                          : AppColors.gray.withOpacity(0.3),
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
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
