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
        // Create a reference with the specific ID from the dummy data
        DocumentReference docRef = _db.collection('properties').doc(property.id);
        
        // Map property object to Map<String, dynamic>
        batch.set(docRef, property.toMap()..addAll({'createdAt': FieldValue.serverTimestamp()}));
      }

      // Commit all operations at once
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
}
