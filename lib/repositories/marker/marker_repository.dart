import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_roof_top_app/models/comment.dart';
import 'package:search_roof_top_app/models/marker_data.dart';

abstract class MarkerRepository {
  User? get currentUser;

  Future<void> createMarker({
    required Marker marker,
    required String? imageUrl,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllMarkers();

  Future<List<MarkerData>> searchMarkers({required String query});

  Future<void> createMarkerComment({
    required String markerId,
    required String comment,
  });

  Future<List<Comment>> fetchMarkersComments({required String markerId});

  Future<void> changeGeofenceStatus({required String markerId});

  Future<bool> fetchGeofenceStatus({required String markerId});

  Future<String> fetchMarkerAddress({required LatLng latLng});
}
