import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_application/core/common/widgets/bottom_navigation.dart';

class LandlordLayout extends StatefulWidget {
  final Widget child;
  final String? location;

  const LandlordLayout({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  State<LandlordLayout> createState() => _LandlordLayoutState();
}

class _LandlordLayoutState extends State<LandlordLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _getIndexFromLocation(widget.location);
  }

  @override
  void didUpdateWidget(LandlordLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      setState(() {
        _currentIndex = _getIndexFromLocation(widget.location);
      });
    }
  }

  int _getIndexFromLocation(String? location) {
    if (location == null) return 0;
    if (location.startsWith('/landlord/properties')) return 1;
    if (location.startsWith('/landlord/bookings')) return 2;
    if (location.startsWith('/landlord/messages')) return 3;
    if (location.startsWith('/landlord/profile')) return 4;
    return 0; // default to dashboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/landlord/dashboard');
              break;
            case 1:
              context.go('/landlord/properties');
              break;
            case 2:
              context.go('/landlord/bookings');
              break;
            case 3:
              context.go('/landlord/messages');
              break;
            case 4:
              context.go('/landlord/profile');
              break;
          }
        },
      ),
    );
  }
}
