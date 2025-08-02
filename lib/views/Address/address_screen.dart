import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/Address/cubit/address_cubit.dart';
import 'package:e_commerce/views/Address/cubit/address_state.dart';
import 'package:e_commerce/views/Address/widgets/address_card.dart';
import 'package:e_commerce/views/Address/widgets/add_address_button.dart';
import 'package:e_commerce/views/Address/widgets/apply_button.dart';
import 'package:e_commerce/views/Address/widgets/add_address_form.dart';
import 'package:e_commerce/views/Address/widgets/success_dialog.dart';
import 'package:e_commerce/views/Address/models/address_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.red,
                ),
              );
            }

            if (state is AddressAddedSuccess) {
              // Close the modal first
              Navigator.pop(context);
              // Then show success dialog with a small delay to prevent gesture conflicts
              Future.delayed(const Duration(milliseconds: 300), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SuccessDialog(
                      title: 'Congratulations!',
                      message: 'Your new address has been added.',
                      onButtonPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                    ),
                  );
                }
              });
            }

            if (state is AddressUpdatedSuccess) {
              // Close the modal first
              Navigator.pop(context);
              // Then show success dialog with a small delay to prevent gesture conflicts
              Future.delayed(const Duration(milliseconds: 300), () {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => SuccessDialog(
                      title: 'Success!',
                      message: 'Address updated successfully.',
                      onButtonPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                    ),
                  );
                }
              });
            }

            if (state is AddressDeletedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(context),

                  // Content
                  Expanded(child: _buildContent(context, state)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray.withOpacity(0.2),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24.sp,
              color: AppColors.black,
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                "Address",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ),

          // Notification Icon
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            child: Icon(
              Icons.notifications_outlined,
              size: 24.sp,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, AddressState state) {
    if (state is AddressLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is AddressError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: AppColors.red),
            verticalSpace(16),
            Text(
              "Error loading addresses",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            verticalSpace(8),
            Text(
              state.message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            ElevatedButton(
              onPressed: () {
                context.read<AddressCubit>().loadAddresses();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }

    if (state is AddressLoaded) {
      return Column(
        children: [
          // Saved Addresses Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Title
                  Text(
                    'Saved Address',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Address List
                  ...state.addresses
                      .map(
                        (address) => AddressCard(
                          address: address,
                          onTap: () {
                            context.read<AddressCubit>().selectAddress(
                              address.id,
                            );
                          },
                          onEdit: () {
                            _showEditAddressForm(context, address);
                          },
                          onDelete: () {
                            _showDeleteConfirmation(context, address);
                          },
                        ),
                      )
                      .toList(),

                  SizedBox(height: 16.h),

                  // Add New Address Button
                  AddAddressButton(
                    onTap: () {
                      _showAddAddressForm(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Apply Button
          ApplyButton(
            isEnabled: state.selectedAddress != null,
            onTap: () {
              // Return selected address to previous screen
              Navigator.pop(context, state.selectedAddress);
            },
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  void _showAddAddressForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddAddressForm(
          onSubmit: (formData) {
            context.read<AddressCubit>().addAddress(formData);
            // Don't close modal immediately, let success state handle it
          },
        ),
      ),
    );
  }

  void _showEditAddressForm(BuildContext context, Address address) {
    final formData = AddressFormData(
      nickname: address.nickname,
      fullAddress: address.fullAddress,
      isDefault: address.isDefault,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddAddressForm(
          initialData: formData,
          onSubmit: (formData) {
            context.read<AddressCubit>().updateAddress(address.id, formData);
            // Don't close modal immediately, let success state handle it
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Address address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${address.nickname}" address?',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.gray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.gray,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AddressCubit>().deleteAddress(address.id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
