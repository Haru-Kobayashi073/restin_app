import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MarkerRepository {
  User? get currentUser;

  Future<void> createMarker({required Marker marker});

  Stream<List<Marker>> fetchAllMarkers();
}
