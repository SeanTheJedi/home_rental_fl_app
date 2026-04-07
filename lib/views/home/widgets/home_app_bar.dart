import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/color_constants.dart';


class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'San Francisco, CA',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 12.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: CachedNetworkImage(
                // Use a valid profile image URL here
                imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80',
                height: 48.h,
                width: 48.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerEffect(),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surface,
                  child: const Icon(Icons.person_outline),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
      ),
    );
  }
}