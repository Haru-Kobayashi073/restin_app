import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/pages/map/marker_detail_modal.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final showModalProvider = StateProvider.autoDispose<
    Future<void> Function({
      required MarkerData markerData,
    })>(
  (ref) => ({
    required markerData,
  }) async {
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: ref.read(navigatorKeyProvider).currentContext!,
      elevation: 0,
      builder: (_) {
        return MarkerDetailModal(
          markerData: markerData,
        );
      },
    );
  },
);

final fetchAllMarkersProvider = StreamProvider.autoDispose<List<Marker>>(
  (ref) async* {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response = read(markerRepositoryImplProvider).fetchAllMarkers();
      // final list = <Marker>[];
      late List<bg.Geofence> geofences;
      await for (final marker in response) {
        final markerList = marker.docs.map((doc) {
          final data = MarkerData.fromJson(doc.data());
          return Marker(
            markerId: MarkerId(data.markerId),
            position: LatLng(
              data.latitude,
              data.longitude,
            ),
            infoWindow: InfoWindow(
              title: data.title,
              snippet: data.description,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              data.isGeofenceActive != null && data.isGeofenceActive!
                  ? BitmapDescriptor.hueRed
                  : BitmapDescriptor.hueGreen,
            ),
            consumeTapEvents: true,
            onTap: () => read(showModalProvider).call(markerData: data),
          );
        }).toList();
        geofences = markerList.map((marker) {
          return bg.Geofence(
            identifier: marker.markerId.value,
            radius: markerCircleRadius,
            latitude: marker.position.latitude,
            longitude: marker.position.longitude,
            notifyOnEntry: true,
            notifyOnExit: true,
          );
        }).toList();
        yield markerList;
      }
      await read(flutterBackgroundGeolocationServiceProvider)
          .addGeofences(geofences);
      debugPrint('全マーカーを取得しました。');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      debugPrint('全マーカーの取得エラー: $e');
      rethrow;
    }
  },
);

final fetchAllCirclesProvider =
    StreamProvider.family<List<Circle>, List<Marker>>(
  (ref, markers) async* {
    final isNetworkCheck = await isNetworkConnected();
    try {
      final list = <Circle>[];
      for (final marker in markers) {
        list.add(
          Circle(
            circleId: CircleId(marker.markerId.value),
            center: marker.position,
            strokeColor: ColorName.amber.withOpacity(0.8),
            fillColor: ColorName.amber.withOpacity(0.2),
            strokeWidth: 2,
            radius: markerCircleRadius,
          ),
        );
      }
      debugPrint('全サークルを取得しました。');
      yield list;
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      debugPrint('全サークルの取得エラー: $e');
      rethrow;
    }
  },
);

final fetchAllMarkerDataProvider = StreamProvider.autoDispose<List<MarkerData>>(
  (ref) async* {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response = read(markerRepositoryImplProvider).fetchAllMarkers();
      await for (final marker in response) {
        final list = <MarkerData>[];
        for (final document in marker.docs) {
          final data = MarkerData.fromJson(document.data());
          list.add(data);
        }
        yield list;
      }
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      debugPrint('全マーカーの取得エラー: $e');
      rethrow;
    }
  },
);
