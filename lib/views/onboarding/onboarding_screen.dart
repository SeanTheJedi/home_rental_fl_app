import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/core/constants/color_constants.dart';
import 'package:home_rental_application/views/onboarding/widgets/onboarding_page.dart';

import '../../core/services/storage_service.dart';
import '../../models/onboarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
        image: "assets/images/onboarding/onboarding1.png",
        title: "Find Perfect Home",
        description: "Find the perfect home for you and your family with our extensive listings.",
    ),
    OnboardingContent(
      image: "assets/images/onboarding/onboarding2.png",
      title: "Easy Booking",
      description: "Book your home with ease and manage all your rentals in one place.",
    ),
    OnboardingContent(
      image: "assets/images/onboarding/onboarding1.png",
      title: "Move In Quickly",
      description: "Quick and hassle-free move-in process with verified properties.",
    ),
  ];

  void _onNextPressed() async {
    if (_currentPage == _contents.length - 1) {
      await StorageService.setFirstTimeUser(false);
      if (mounted) {
        context.go('/auth');
      }
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
            PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    content: _contents[index],
                  );
                }
            ),

            Positioned(
                bottom: 60.h,
                left: 0,
                right: 0,
                child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              _contents.length,
                                  (index) => _buildDot(index),
                          )
                      ),

                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  await StorageService.setFirstTimeUser(false);
                                  if (mounted) {
                                    context.go('/auth');
                                  }
                                },
                                child: Text(
                                    'Skip',
                                    style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 16.sp)
                                ),
                            ),

                            SizedBox(
                              width: 140.w,
                              child: ElevatedButton(
                                  onPressed: _onNextPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                  ),
                                  child: Text(
                                    _currentPage == _contents.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                              ),
                            )
                          ]
                        )
                      )
                    ]
                )
            ),
          ]
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
