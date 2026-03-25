import 'package:go_router/go_router.dart';
import 'package:home_rental_application/views/auth/login_screen.dart';
import 'package:home_rental_application/views/onboarding/onboarding_screen.dart';

import '../../views/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
          path: '/auth',
          name: 'auth',
          builder: (context, state) => const LoginScreen(),
      ),

  ]
);