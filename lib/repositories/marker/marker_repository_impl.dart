// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/comment.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final markerRepositoryImplProvider =
    Provider<MarkerRepository>(MarkerRepositoryImpl.new);

class MarkerRepositoryImpl implements MarkerRepository {
  MarkerRepositoryImpl(ProviderRef<MarkerRepository> ref)
      : _auth = ref.read(authProvider),
        _firestore = ref.read(firestoreProvider),
        _dio = ref.read(dioProvider);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final Dio _dio;

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
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllMarkers() async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> userSnapshotStream;
    final uid = currentUser?.uid;
    final userSnapshot = await _firestore.collection('users').doc(uid).get();
    final blockedUids =
        userSnapshot.data()?['blockedUids'] as List<dynamic>? ?? [];
    if (blockedUids.isNotEmpty) {
      userSnapshotStream = _firestore
          .collection('markers')
          .where('creatorId', whereNotIn: blockedUids)
          .snapshots();
    } else {
      userSnapshotStream = _firestore.collection('markers').snapshots();
    }
    yield* userSnapshotStream;
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

  @override
  Future<void> changeGeofenceStatus({required String markerId}) async {
    final markerRef = _firestore.collection('markers').doc(markerId);
    final markerSnapshot = await markerRef.get();
    var isGeofenceActive = markerSnapshot.data()?['isGeofenceActive'] as bool?;

    if (isGeofenceActive == true) {
      isGeofenceActive = false;
    } else {
      isGeofenceActive = true;
    }

    await markerRef.update({
      'isGeofenceActive': isGeofenceActive,
    });
  }

  @override
  Future<bool> fetchGeofenceStatus({required String markerId}) async {
    final markerRef = _firestore.collection('markers').doc(markerId);
    final response = await markerRef.get();
    final isGeofenceActive =
        response.data()?['isGeofenceActive'] as bool? ?? false;
    return isGeofenceActive;
  }

  @override
  Future<String> fetchMarkerAddress({required LatLng latLng}) async {
    final response = await _dio.get<dynamic>(
      'https://maps.googleapis.com/maps/api/geocode/json',
      queryParameters: {
        'latlng': '${latLng.latitude},${latLng.longitude}',
        'key': dotenv.get('GOOGLE_MAPS_API_KEY_FOR_IOS'),
        'language': 'ja',
      },
    );
    final decoded = response.data;
    return decoded['results'][0]['formatted_address'].toString();
  }
}
