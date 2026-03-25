import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/core/constants/app_constants.dart';
import 'package:home_rental_application/core/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    try {
      // wait for animation to complete
      await Future.delayed(AppConstants.splashDuration);

      if (!mounted) return;
      final isFirstTime = await StorageService.isFirstTimeUser();

      if (!mounted) return;

      if (isFirstTime){
        // await StorageService.setFirstTimeUser(false);

        if(!mounted) return;

        if (context.mounted){
          context.pushReplacement('/onboarding');
        }
      } else {
        if (context.mounted) {
          context.pushReplacement('/auth');
        }
      }
    } catch(e) {
        debugPrint('Navigation error: $e');
        if (mounted) {
          context.pushReplacement('/onboarding');
        }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Setting a clean background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The App Logo Container
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.home_work_rounded, // Home Rental Icon
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            // App Name Text
            const Text(
              "HomeRent",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 50),
            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
