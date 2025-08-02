import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/routes/app_routes.dart';
import 'package:e_commerce/views/SavedItems/cubit/saved_items_cubit.dart';
import 'package:e_commerce/views/SavedItems/cubit/saved_items_state.dart';
import 'package:e_commerce/views/SavedItems/widgets/empty_saved_items.dart';
import 'package:e_commerce/views/SavedItems/widgets/saved_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  @override
  void initState() {
    super.initState();
    // Load saved items when screen initializes
    context.read<SavedItemsCubit>().loadSavedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: _buildAppBar(),
      body: BlocBuilder<SavedItemsCubit, SavedItemsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.black),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error!,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.red),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SavedItemsCubit>().loadSavedItems();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.isEmpty) {
            return const EmptySavedItems();
          }

          return _buildSavedItemsGrid(state);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        ),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
      ),
      title: Text(
        'Saved Items',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notifications);
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.black,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildSavedItemsGrid(SavedItemsState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
          mainAxisExtent: 225.h,
        ),
        itemCount: state.savedItems.length,
        itemBuilder: (context, index) {
          final item = state.savedItems[index];
          return SavedItemCard(item: item);
        },
      ),
    );
  }
}
