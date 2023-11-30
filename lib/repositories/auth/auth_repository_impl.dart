import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final authRepositoryImplProvider =
    Provider<AuthRepository>(AuthRepositoryImpl.new);

final authUserProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryImplProvider).authStateChanges(),
);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(ProviderRef<AuthRepository> ref)
      : _auth = ref.read(authProvider);

  final FirebaseAuth _auth;

  @override
  User? get currentUser => _auth.currentUser;
  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Future<bool> checkEmailVerified() async {
    await _auth.currentUser?.reload();
    if (_auth.currentUser == null) {
      return false;
    } else {
      return _auth.currentUser!.emailVerified;
    }
  }

  @override
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.sendEmailVerification();

    return userCredential.user?.uid;
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!.uid;
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
