import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/controllers/booking_controller.dart';
import 'package:home_rental_application/controllers/property_controller.dart';
import 'package:home_rental_application/views/home/widgets/home_search_bar.dart';
import 'package:provider/provider.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/property_card.dart';
import 'widgets/section_title.dart';
import '../../core/constants/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer2<PropertyController, BookingController>(
          builder: (context, propertyController, bookingController, child) {
            return CustomScrollView(
              slivers: [
                // 1. App Bar, Search, and Banners
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: const HomeAppBar(),
                        ),
                        SizedBox(height: 24.h),
                        const HomeSearchBar(),
                        SizedBox(height: 24.h),
                        const BannerCarousel(),
                        SizedBox(height: 24.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SectionTitle(
                            title: 'Popular Properties',
                            actionText: 'See All',
                            onActionPressed: () {},
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

                // 2. Loading State
                if (propertyController.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                
                // 3. Error State
                else if (propertyController.error != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'Error: ${propertyController.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )

                // 4. Empty State
                else if (propertyController.properties.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_outlined, size: 64.sp, color: Colors.grey),
                          SizedBox(height: 16.h),
                          Text(
                            'No properties available.',
                            style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )

                // 5. Data State (The Grid)
                else
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final property = propertyController.properties[index];
                          // Check if this property is already booked by the user
                          final isBooked = bookingController.isPropertyBooked(property.id);
                          
                          return PropertyCard(
                            property: property,
                            isBooked: isBooked,
                            onTap: () {
                              context.pushNamed('property-details', extra: property);
                            },
                          );
                        },
                        childCount: propertyController.properties.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 0.65,
                      ),
                    ),
                  ),

                SliverPadding(padding: EdgeInsets.only(bottom: 24.h)),
              ],
            );
          },
        ),
      ),
    );
  }
}
