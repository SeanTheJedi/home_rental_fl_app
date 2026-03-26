 import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  // simulate firebase login
  Future<User ?> loginWithRole(String email, String password, UserRole expectedRole) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 2));

      _currentUser = User.dummyUsers.firstWhere(
        (user) => user.email == email && user.role == expectedRole,
        orElse: () => throw Exception('Invalid credentials or role.'),
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
      // simulate API call
      await Future.delayed(Duration(seconds: 2));

      // create new user (replace withFirebase auth)
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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
      await Future.delayed(Duration(seconds: 2));
      _currentUser = null;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // simulate API call
      await Future.delayed(Duration(seconds: 2));
      // replace with firebase auth
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // helper method to determine initial route
  String getInitialRoute() {
    if (_currentUser != null) return '/auth';
    return _currentUser!.role == UserRole.landlord
        ? '/landlord/dashboard'
        : '/home';

  }

}