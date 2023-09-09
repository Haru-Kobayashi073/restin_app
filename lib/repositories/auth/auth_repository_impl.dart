import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository.dart';

final authProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final authRepositoryImplProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(authProvider),
    ref.watch(firestoreProvider),
  ),
);

final authUserProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryImplProvider).authStateChanges(),
);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._firestore);
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Future<String?> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firestore.collection('users').doc(userCredential.user?.uid).set({
      'userName': userName,
      'email': email,
      'createAt': Timestamp.now(),
    });

    return userCredential.user?.uid;
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
