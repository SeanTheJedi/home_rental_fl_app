import 'dart:async';
import 'package:flutter/material.dart';
import '../core/services/firebase_service.dart';
import '../models/property_model.dart';

class PropertyController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  
  List<Property> _properties = [];
  bool _isLoading = true;
  String? _error;
  StreamSubscription? _subscription;

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  String? get error => _error;

  PropertyController() {
    _initProperties();
  }

  void _initProperties() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _subscription = _firebaseService.getProperties().listen(
      (data) {
        _properties = data;
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
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
