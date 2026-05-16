import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_rental_application/models/property_model.dart';

enum BookingStatus { upcoming, ongoing, completed, cancelled }

class Booking {
  final String id;
  final String userId;
  final Property property;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.userId,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.status,
    DateTime? bookingDate,
  }) : bookingDate = bookingDate ?? DateTime.now();

  /// A booking can only be cancelled if it is in the "upcoming" state
  bool get isCancellable => status == BookingStatus.upcoming;

  // Convert Firestore Document to Booking object
  factory Booking.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      userId: data['userId'] ?? '',
      property: Property.fromMap(data['property'] as Map<String, dynamic>),
      checkIn: (data['checkIn'] as Timestamp).toDate(),
      checkOut: (data['checkOut'] as Timestamp).toDate(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => BookingStatus.upcoming,
      ),
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
    );
  }

  // Convert Booking object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'property': property.toMap()..addAll({'id': property.id}),
      'checkIn': Timestamp.fromDate(checkIn),
      'checkOut': Timestamp.fromDate(checkOut),
      'totalPrice': totalPrice,
      'status': status.name,
      'bookingDate': Timestamp.fromDate(bookingDate),
    };
  }

  // Fully Populated Dummy Data for testing
  static List<Booking> dummyBookings = [
    Booking(
      id: 'b1',
      userId: '1',
      property: Property.dummyProperties[0],
      checkIn: DateTime.now().add(const Duration(days: 5)),
      checkOut: DateTime.now().add(const Duration(days: 10)),
      totalPrice: 6000,
      status: BookingStatus.upcoming,
    ),
    Booking(
      id: 'b2',
      userId: '1',
      property: Property.dummyProperties[1],
      checkIn: DateTime.now().subtract(const Duration(days: 20)),
      checkOut: DateTime.now().subtract(const Duration(days: 15)),
      totalPrice: 4250,
      status: BookingStatus.completed,
    ),
  ];
}
