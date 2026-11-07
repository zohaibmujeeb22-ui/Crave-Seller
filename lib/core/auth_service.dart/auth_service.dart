import 'package:firebase_auth/firebase_auth.dart';

/// Service class encapsulating Firebase Authentication logic.
class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  /// Google Sign-In optimized for Flutter Web using a browser popup
  Future<UserCredential> signInWithGoogle() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('email');
    return await _auth.signInWithPopup(googleProvider);
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
