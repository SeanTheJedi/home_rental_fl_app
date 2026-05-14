import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_application/core/constants/color_constants.dart';
import 'package:home_rental_application/models/property_model.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. Image Header
              SliverAppBar(
                expandedHeight: 400.h,
                pinned: true,
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'property-image-${property.id}',
                    child: CachedNetworkImage(
                      imageUrl: property.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // 2. Property Info
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              property.title,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20.sp),
                              SizedBox(width: 4.w),
                              Text(
                                property.averageRating.toString(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.primary, size: 18.sp),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              property.location,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Facilities/Amenities - Fixed overflow using Expanded
                      Row(
                        children: [
                          Expanded(child: _buildFacilityItem(Icons.king_bed_outlined, '${property.bedrooms} Bed')),
                          SizedBox(width: 8.w),
                          Expanded(child: _buildFacilityItem(Icons.bathtub_outlined, '${property.bathrooms} Bath')),
                          SizedBox(width: 8.w),
                          Expanded(child: _buildFacilityItem(Icons.square_foot_outlined, '1.2k sqft')),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        property.description.isEmpty 
                          ? 'This property offers a perfect blend of comfort and style. Located in a prime neighborhood, it features modern amenities and spacious interiors ideal for families or individuals looking for a high-quality living experience.'
                          : property.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 120.h), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. Bottom Booking Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                        ),
                        Text(
                          '\$${property.price}/mo',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.sp, color: AppColors.primary),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
