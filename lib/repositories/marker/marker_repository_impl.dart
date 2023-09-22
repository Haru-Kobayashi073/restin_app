import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  Future<void> createMarker({required Marker marker}) async {
    final uid = currentUser!.uid;
    final docId = returnUuidV4();
    final createdAtTimestamp = Timestamp.fromDate(DateTime.now());
    await _firestore.collection('markers').doc(docId).set(
          MarkerData(
            creatorId: uid,
            docId: docId,
            markerId: marker.markerId.value,
            createdAt: createdAtTimestamp,
            title: marker.infoWindow.title.toString(),
            description: marker.infoWindow.snippet,
            latitude: marker.position.latitude,
            longitude: marker.position.longitude,
          ).toJson(),
        );
  }

  @override
  Stream<List<Marker>> fetchAllMarkers() async* {
    final response = await _firestore.collection('markers').get();
    final list = <Marker>[];
    for (final document in response.docs) {
      final data = MarkerData.fromJson(document.data());
      list.add(
        Marker(
          markerId: MarkerId(data.markerId),
          position: LatLng(
            data.latitude,
            data.longitude,
          ),
          infoWindow: InfoWindow(
            title: data.title,
            snippet: data.description,
          ),
        ),
      );
    }

    yield list;
  }
}
