import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/constants/app_spacing.dart';
import 'package:e_commerce/views/Home/cubit/home_cubit.dart';

class FiltersScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;
  final Map<String, dynamic> currentFilters;
  final HomeCubit homeCubit;

  const FiltersScreen({
    Key? key,
    required this.onApplyFilters,
    required this.currentFilters,
    required this.homeCubit,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late String selectedSortBy;
  late RangeValues priceRange;
  late String selectedSize;

  final List<String> sortOptions = [
    'Relevance',
    'Price: Low - High',
    'Price: High - Low',
  ];

  final List<String> sizeOptions = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    selectedSortBy = widget.currentFilters['sortBy'] ?? 'Relevance';
    priceRange =
        widget.currentFilters['priceRange'] ?? const RangeValues(0, 5000);
    selectedSize = widget.currentFilters['size'] ?? 'L';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp, color: AppColors.black),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort By Section
                  _buildSectionTitle('Sort By'),
                  verticalSpace(12),
                  _buildSortByOptions(),
                  verticalSpace(30),

                  // Price Section
                  _buildSectionTitle('Price'),
                  verticalSpace(12),
                  _buildPriceRangeSlider(),
                  verticalSpace(30),

                  // Size Section
                  _buildSectionTitle('Size'),
                  verticalSpace(12),
                  _buildSizeSelector(),
                  verticalSpace(30),
                ],
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  final filters = {
                    'sortBy': selectedSortBy,
                    'priceRange': priceRange,
                    'size': selectedSize,
                  };
                  widget.onApplyFilters(filters);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildSortByOptions() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sortOptions.length,
        itemBuilder: (context, index) {
          final option = sortOptions[index];
          final isSelected = selectedSortBy == option;

          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSortBy = option;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8.w),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.black
                        : AppColors.gray.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${priceRange.start.round()} - \$${priceRange.end.round()}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        verticalSpace(8),
        RangeSlider(
          values: priceRange,
          min: 0,
          max: 5000,
          divisions: 100,
          activeColor: AppColors.black,
          inactiveColor: AppColors.gray.withOpacity(0.3),
          onChanged: (RangeValues values) {
            setState(() {
              priceRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return GestureDetector(
      onTap: () {
        _showSizePicker(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(color: AppColors.gray.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedSize,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _showSizePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Size',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            verticalSpace(20),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: sizeOptions.map((size) {
                final isSelected = selectedSize == size;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSize = size;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.black : Colors.white,
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.gray.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
