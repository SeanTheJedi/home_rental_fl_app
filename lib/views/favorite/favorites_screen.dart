import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/controllers/booking_controller.dart';
import 'package:provider/provider.dart';
import '../../controllers/property_controller.dart';
import '../../core/common/widgets/page_layout.dart';
import '../../core/constants/color_constants.dart';
import '../home/widgets/property_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Favorites',
      body: Consumer2<PropertyController, BookingController>(
        builder: (context, propertyController, bookingController, child) {
          final favorites = propertyController.favoriteProperties;

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 64.sp,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Properties you like will appear here',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.65,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final property = favorites[index];
                final isBooked = bookingController.isPropertyBooked(property.id);
                
                return PropertyCard(
                  property: property,
                  isBooked: isBooked,
                  onTap: () {
                    context.pushNamed('property-details', extra: property);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
