import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_application/views/home/widgets/home_search_bar.dart';
import '../../models/property_model.dart';
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
        child: CustomScrollView(
          slivers: [
            // The top portion of the screen (App Bar, Search, Carousel)
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

            // The Grid of Properties
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final property = Property.dummyProperties[index];
                    return PropertyCard(
                      property: property,
                      onTap: () {
                        // Navigate to Property Details Screen
                      },
                    );
                  },
                  childCount: Property.dummyProperties.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.65, // Adjusts height vs width of cards
                ),
              ),
            ),

            // Bottom padding so the last row isn't hidden behind the nav bar
            SliverPadding(padding: EdgeInsets.only(bottom: 24.h)),
          ],
        ),
      ),
    );
  }
}