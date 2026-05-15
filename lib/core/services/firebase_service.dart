import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/property_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to populate Firestore with the dummy properties
  Future<void> uploadDummyData() async {
    try {
      final WriteBatch batch = _db.batch();
      
      for (var property in Property.dummyProperties) {
        DocumentReference docRef = _db.collection('properties').doc(property.id);
        batch.set(docRef, property.toMap()..addAll({'createdAt': FieldValue.serverTimestamp()}));
      }

      await batch.commit();
      debugPrint('Successfully populated Firestore with dummy properties.');
    } catch (e) {
      debugPrint('Error populating Firestore: $e');
      rethrow;
    }
  }

  /// Get real-time stream of properties
  Stream<List<Property>> getProperties() {
    return _db
        .collection('properties')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Property.fromFirestore(doc)).toList();
    });
  }

  /// Toggle Favorite status
  Future<void> toggleFavorite(String userId, String propertyId, bool isFavorite) async {
    final ref = _db.collection('users').doc(userId).collection('favorites').doc(propertyId);
    if (isFavorite) {
      await ref.delete();
    } else {
      await ref.set({
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Stream of favorite property IDs for a user
  Stream<List<String>> getFavoriteIds(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }
}
