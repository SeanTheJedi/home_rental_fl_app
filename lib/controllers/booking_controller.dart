import 'dart:async';
import 'package:flutter/material.dart';
import '../core/services/firebase_service.dart';
import '../models/booking_model.dart';

class BookingController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  
  List<Booking> _userBookings = [];
  String? _userId;
  bool _isLoading = false;
  String? _error;
  StreamSubscription? _bookingsSub;

  List<Booking> get userBookings => _userBookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void updateUserId(String? newUserId) {
    if (_userId == newUserId) return;
    _userId = newUserId;
    
    _bookingsSub?.cancel();
    _userBookings = [];
    
    if (newUserId != null) {
      _isLoading = true;
      notifyListeners();
      
      _bookingsSub = _firebaseService.getUserBookings(newUserId).listen(
        (data) {
          _userBookings = data;
          _isLoading = false;
          _error = null;
          notifyListeners();
        },
        onError: (e) {
          _error = e.toString();
          _isLoading = false;
          notifyListeners();
        },
      );
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Checks if there is an active (upcoming or ongoing) booking for a specific property
  Booking? getActiveBookingForProperty(String propertyId) {
    try {
      return _userBookings.firstWhere(
        (booking) => 
            booking.property.id == propertyId && 
            (booking.status == BookingStatus.upcoming || booking.status == BookingStatus.ongoing),
      );
    } catch (_) {
      return null;
    }
  }

  /// Helper to check if a property is already booked by the user
  bool isPropertyBooked(String propertyId) {
    return getActiveBookingForProperty(propertyId) != null;
  }

  Future<void> createBooking(Booking booking) async {
    // Prevent double booking
    if (isPropertyBooked(booking.property.id)) {
      throw Exception('You already have an active booking for this property.');
    }

    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseService.createBooking(booking);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Cancels an upcoming booking
  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseService.cancelBooking(bookingId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _bookingsSub?.cancel();
    super.dispose();
  }
}
