import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_roof_top_app/models/marker_data.dart';

abstract class MarkerRepository {
  User? get currentUser;

  Future<void> createMarker({
    required Marker marker,
    required String? imageUrl,
  });

  Stream<List<MarkerData>> fetchAllMarkers();

  Future<List<MarkerData>> searchMarkers({required String query});
}
