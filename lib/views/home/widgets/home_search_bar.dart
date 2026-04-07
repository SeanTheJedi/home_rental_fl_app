import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/color_constants.dart';


class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Ensure the search bar aligns with the rest of the screen's margins
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // 1. The Search Input Field
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.surface, // Typically white or a very light grey
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for home, apartment...',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                    size: 24.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // 2. The Filter Action Button
          GestureDetector(
            onTap: () {
              // Usually triggers a ModalBottomSheet to select price/bedrooms
            },
            child: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune_rounded, // The standard settings/slider icon
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}