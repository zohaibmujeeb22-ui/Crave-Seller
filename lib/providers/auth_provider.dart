import 'package:crave_seller/core/auth_service.dart/auth_service.dart';
import 'package:crave_seller/core/auth_service.dart/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



enum AuthStatus { unauthenticated, authenticating, authenticated, error }

class CraveAuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final DatabaseService _dbService;

  CraveAuthProvider({
    required AuthService authService,
    required DatabaseService dbService,
  })  : _authService = authService,
        _dbService = dbService;

  AuthStatus _status = AuthStatus.unauthenticated;
  String? _errorMessage;
  bool _hasRestaurantProfile = false;

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get hasRestaurantProfile => _hasRestaurantProfile;
  User? get currentUser => _authService.currentUser;

  /// Authenticate with Email & Password
  Future<bool> loginWithEmail(String email, String password) async {
    return _authenticate(() => _authService.signInWithEmailPassword(email, password));
  }

  /// Authenticate with Google (Web Popup)
  Future<bool> loginWithGoogle() async {
    return _authenticate(() => _authService.signInWithGoogle());
  }

  /// Shared flow to verify profile registration upon successful auth
  Future<bool> _authenticate(Future<UserCredential> Function() authMethod) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await authMethod();
      if (credential.user != null) {
        // Query Supabase to determine if the owner already finished onboarding
        final restaurant = await _dbService.getRestaurantByOwnerId(credential.user!.uid);
        _hasRestaurantProfile = restaurant != null;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Authentication failed.';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _status = AuthStatus.unauthenticated;
    _hasRestaurantProfile = false;
    notifyListeners();
  }
}