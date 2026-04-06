import 'package:go_router/go_router.dart';
import 'package:home_rental_application/views/auth/login_screen.dart';
import 'package:home_rental_application/views/booking/bookings_list/bookings_list_screen.dart';
import 'package:home_rental_application/views/chat/messages_screen.dart';
import 'package:home_rental_application/views/favorite/favorites_screen.dart';
import 'package:home_rental_application/views/home/home_screen.dart';
import 'package:home_rental_application/views/landlord/landlord_dashboard/landlord_dashboard_screen.dart';
import 'package:home_rental_application/views/onboarding/onboarding_screen.dart';
import 'package:home_rental_application/views/profile/profile_screen.dart';

import '../../views/auth/register_screen.dart';
import '../../views/landlord/landlord_bookings/landlord_booking_screen.dart';
import '../../views/landlord/landlord_profile/landlord_profile_screen.dart';
import '../../views/landlord/landlord_properties/landlord_properties.dart';
import '../../views/landlord_layout.dart';
import '../../views/main_layout.dart';
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
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
        builder: (context, state, child) => MainLayout(
          location: state.uri.toString(),
          child: child,
        ), // MainLayout
        routes: [
          GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen()
          ), // GoRoute
          GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesScreen()
          ), // GoRoute
          GoRoute(
              path: '/bookings',
              builder: (context, state) => const BookingsListScreen()
          ), // GoRoute
          GoRoute(
              path: '/messages',
              builder: (context, state) => const MessagesScreen()
          ), // GoRoute
          GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen()
          ), // GoRoute

        ]
    ), // ShellRoute

    // landlord routes
    ShellRoute(
        builder: (context, state, child) => LandlordLayout(
          location: state.uri.toString(),
          child: child,
        ), // LandlordLayout
        routes: [
          GoRoute(
              path: '/landlord/dashboard',
              builder: (context, state) => const LandlordDashboardScreen()
          ), // GoRoute
          GoRoute(
              path: '/landlord/properties',
              builder: (context, state) => const LandlordPropertiesScreen()
          ),
          GoRoute(
              path: '/landlord/bookings',
              builder: (context, state) => const LandlordBookingsScreen()
          ),
          GoRoute(
              path: '/landlord/messages',
              builder: (context, state) => const MessagesScreen()
          ),
          GoRoute(
              path: '/landlord/profile',
              builder: (context, state) => const LandlordProfileScreen()
          ),

        ]
    ) // ShellRoute
  ]
);