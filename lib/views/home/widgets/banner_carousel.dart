import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_constants.dart';


class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  // Tracks which banner is currently visible
  int _currentIndex = 0;

  // Dummy promotional banners
  final List<String> _banners = [
    'assets/images/ads/ad1.jpg', // Replace with your actual assets or network URLs
    'assets/images/ads/ad2.jpg',
    'assets/images/ads/ad3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. The Image Slider
        CarouselSlider(
          options: CarouselOptions(
            height: 160.h,
            viewportFraction: 0.9, // Shows a tiny peek of the next/previous image
            enlargeCenterPage: true, // Makes the center image slightly larger
            autoPlay: true, // Automatically slides
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _banners.map((bannerUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    // Assuming these are local assets for the ads
                    image: DecorationImage(
                      image: AssetImage(bannerUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        SizedBox(height: 12.h),

        // 2. The Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == entry.key ? 24.w : 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: _currentIndex == entry.key
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}