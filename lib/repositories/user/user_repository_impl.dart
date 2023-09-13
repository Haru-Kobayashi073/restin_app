import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository.dart';

final authProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

final userRepositoryImplProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    ref.watch(authProvider),
    ref.watch(firestoreProvider),
  ),
);

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._auth, this._firestore);
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<UserData?> fetchUserData() async {
    final uid = currentUser!.uid;
    final response = await _firestore.collection('users').doc(uid).get();
    return UserData.fromJson(response.data()!);
  }
}
