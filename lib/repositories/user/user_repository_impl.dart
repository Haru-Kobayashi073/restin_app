import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:tuple/tuple.dart';

final userRepositoryImplProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    ref.watch(authProvider),
    ref.watch(firestoreProvider),
    ref.watch(storageProvider),
  ),
);

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._auth,
    this._firestore,
    this._storage,
  );
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<UserData?> fetchUserData() async {
    final uid = currentUser!.uid;
    final response = await _firestore.collection('users').doc(uid).get();
    return UserData.fromJson(response.data()!);
  }

  @override
  Future<void> updateUserData({required Tuple2<String, File> imgInfo}) async {
    final uid = currentUser!.uid;
    final reference =
        _storage.ref().child('users').child(uid).child(imgInfo.item1);
    await reference.putFile(imgInfo.item2);
    final imageUrl = await reference.getDownloadURL();
    await _firestore.collection('users').doc(uid).update({
      'imageUrl': imageUrl,
    });
  }

  @override
  Future<List<MarkerData>?> fetchUserMarkers() async {
    final uid = currentUser!.uid;
    final list = <MarkerData>[];
    final response = await _firestore
        .collection('markers')
        .where('creatorId', isEqualTo: uid)
        .get();
    for (final document in response.docs) {
      list.add(MarkerData.fromJson(document.data()));
    }
    return list;
  }
}
