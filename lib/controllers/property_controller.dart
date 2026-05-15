import 'dart:async';
import 'package:flutter/material.dart';
import '../core/services/firebase_service.dart';
import '../models/property_model.dart';

class PropertyController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  
  List<Property> _properties = [];
  List<String> _favoriteIds = [];
  String? _userId;
  bool _isLoading = true;
  String? _error;
  StreamSubscription? _propertiesSub;
  StreamSubscription? _favoritesSub;

  List<Property> get properties => _properties;
  List<String> get favoriteIds => _favoriteIds;
  bool get isLoading => _isLoading;
  String? get error => _error;

  PropertyController() {
    _initProperties();
  }

  void _initProperties() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _propertiesSub = _firebaseService.getProperties().listen(
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

  // Synchronizes the favorites stream when the user logs in/out
  void updateUserId(String? newUserId) {
    if (_userId == newUserId) return;
    _userId = newUserId;
    
    _favoritesSub?.cancel();
    _favoriteIds = [];
    
    if (newUserId != null) {
      _favoritesSub = _firebaseService.getFavoriteIds(newUserId).listen((ids) {
        _favoriteIds = ids;
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  /// Explicitly initialize favorites for a user
  void initFavorites(String userId) {
    updateUserId(userId);
  }

  Future<void> toggleFavorite(String propertyId) async {
    if (_userId == null) return;

    try {
      final isFav = _favoriteIds.contains(propertyId);
      
      // OPTIMISTIC UPDATE: Update UI immediately
      if (isFav) {
        _favoriteIds.remove(propertyId);
      } else {
        _favoriteIds.add(propertyId);
      }
      notifyListeners();

      // Perform backend update
      await _firebaseService.toggleFavorite(_userId!, propertyId, isFav);
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
      // Revert locally on error if necessary
    }
  }

  bool isFavorite(String propertyId) {
    return _favoriteIds.contains(propertyId);
  }

  List<Property> get favoriteProperties {
    return _properties.where((p) => _favoriteIds.contains(p.id)).toList();
  }

  @override
  void dispose() {
    _propertiesSub?.cancel();
    _favoritesSub?.cancel();
    super.dispose();
  }
}
