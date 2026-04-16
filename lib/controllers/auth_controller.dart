import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  AuthController() {
    _auth.authStateChanges().listen((firebase_auth.User? firebaseUser) async {
      if (firebaseUser == null) {
        _currentUser = null;
      } else {
        await _fetchUserData(firebaseUser.uid);
      }
      notifyListeners();
    });
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = User(
          id: uid,
          fullname: doc.data()?['fullname'] ?? '',
          email: doc.data()?['email'] ?? '',
          role: UserRole.values.firstWhere(
            (e) => e.name == doc.data()?['role'],
            orElse: () => UserRole.tenant,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<User?> loginWithRole(
    String email,
    String password,
    UserRole expectedRole,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _db.collection('users').doc(credential.user!.uid).get();
      
      if (!doc.exists) {
        await _auth.signOut();
        throw Exception('User record not found in database.');
      }

      final roleString = doc.data()?['role'];
      if (roleString != expectedRole.name) {
        await _auth.signOut();
        throw Exception('Access denied. This account is registered as a $roleString.');
      }

      _currentUser = User(
        id: credential.user!.uid,
        fullname: doc.data()?['fullname'] ?? '',
        email: email,
        role: expectedRole,
      );

      return _currentUser;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> register({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection('users').doc(credential.user!.uid).set({
        'fullname': fullName,
        'email': email,
        'role': role.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _currentUser = User(
        id: credential.user!.uid,
        fullname: fullName,
        email: email,
        role: role,
      );

      return _currentUser;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      _currentUser = null;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getInitialRoute() {
    if (_currentUser == null) return '/auth';
    return _currentUser!.role == UserRole.landlord
        ? '/landlord/dashboard'
        : '/home';
  }
}
