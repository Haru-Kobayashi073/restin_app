import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<bool> checkEmailVerified();

  Future<String?> signUp({
    required String email,
    required String password,
  });

  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();
}
