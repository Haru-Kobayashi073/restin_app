import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/comment.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final markerRepositoryImplProvider = Provider<MarkerRepository>(
  (ref) => MarkerRepositoryImpl(
    ref.watch(authProvider),
    ref.watch(firestoreProvider),
  ),
);

class MarkerRepositoryImpl implements MarkerRepository {
  MarkerRepositoryImpl(
    this._auth,
    this._firestore,
  );
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> createMarker({
    required Marker marker,
    required String? imageUrl,
  }) async {
    final uid = currentUser!.uid;
    final createdAtTimestamp = Timestamp.fromDate(DateTime.now());
    await _firestore.collection('markers').doc(marker.markerId.value).set(
          MarkerData(
            creatorId: uid,
            markerId: marker.markerId.value,
            createdAt: createdAtTimestamp,
            title: marker.infoWindow.title.toString(),
            description: marker.infoWindow.snippet!,
            imageUrl: imageUrl ?? '',
            latitude: marker.position.latitude,
            longitude: marker.position.longitude,
          ).toJson(),
        );
    await _firestore.collection('users').doc(uid).update({
      'markersCounts': FieldValue.increment(1),
    });
  }

  @override
  Stream<List<MarkerData>> fetchAllMarkers() async* {
    QuerySnapshot<Map<String, dynamic>> response;
    final uid = currentUser?.uid;
    final userSnapshot = await _firestore.collection('users').doc(uid).get();
    final blockedUids =
        userSnapshot.data()?['blockedUids'] as List<dynamic>? ?? [];
    if (blockedUids.isNotEmpty) {
      response = await _firestore
          .collection('markers')
          .where('creatorId', whereNotIn: blockedUids)
          .get();
    } else {
      response = await _firestore.collection('markers').get();
    }
    final list = <MarkerData>[];
    for (final document in response.docs) {
      final data = MarkerData.fromJson(document.data());
      list.add(data);
    }

    yield list;
  }

  @override
  Future<List<MarkerData>> searchMarkers({required String query}) async {
    final snapshot = await _firestore
        .collection('markers')
        .where('title', isEqualTo: query)
        .get();
    final list = <MarkerData>[];
    for (final document in snapshot.docs) {
      final data = MarkerData.fromJson(document.data());
      list.add(data);
    }
    return list;
  }

  @override
  Future<void> createMarkerComment({
    required String markerId,
    required String comment,
  }) async {
    final uid = currentUser!.uid;
    final createdAtTimestamp = Timestamp.fromDate(DateTime.now());
    final commentId = returnUuidV4();
    final commentRef = _firestore
        .collection('markers')
        .doc(markerId)
        .collection('comments')
        .doc(commentId);
    await commentRef.set(
      Comment(
        commentId: commentId,
        creatorId: uid,
        comment: comment,
        createdAt: createdAtTimestamp,
      ).toJson(),
    );
  }

  @override
  Future<List<Comment>> fetchMarkersComments({required String markerId}) async {
    final snapshot = await _firestore
        .collection('markers')
        .doc(markerId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();
    final list = <Comment>[];
    for (final document in snapshot.docs) {
      final data = Comment.fromJson(document.data());
      list.add(data);
    }
    return list;
  }
}
