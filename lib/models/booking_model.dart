import 'package:home_rental_application/models/property_model.dart';

enum BookingStatus { upcoming, ongoing, completed, cancelled }

class Booking {
  final String id;
  final Property property;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.status,
    DateTime? bookingDate,
  }) : bookingDate = bookingDate ?? DateTime.now();

  // Fully Populated Dummy Data
  static List<Booking> dummyBookings = [
    Booking(
      id: 'b1',
      property: Property.dummyProperties[0], // Modern Blue Apartment
      checkIn: DateTime.now().add(const Duration(days: 5)),
      checkOut: DateTime.now().add(const Duration(days: 10)),
      totalPrice: 1200 * 5,
      status: BookingStatus.upcoming,
    ),
    Booking(
      id: 'b2',
      property: Property.dummyProperties[1], // Cozy Wood Cabin
      checkIn: DateTime.now().subtract(const Duration(days: 20)),
      checkOut: DateTime.now().subtract(const Duration(days: 15)),
      totalPrice: 850 * 5,
      status: BookingStatus.completed,
    ),
    Booking(
      id: 'b3',
      property: Property.dummyProperties[2], // Luxury Villa
      checkIn: DateTime.now().add(const Duration(days: 12)),
      checkOut: DateTime.now().add(const Duration(days: 14)),
      totalPrice: 4500 * 2,
      status: BookingStatus.cancelled,
    ),
  ];
}