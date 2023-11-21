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
      required BuildContext context,
      required MarkerData markerData,
    })>(
  (ref) => ({
    required context,
    required markerData,
  }) async {
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      elevation: 0,
      builder: (context) {
        return MarkerDetailModal(
          markerData: markerData,
        );
      },
    );
  },
);

final fetchAllMarkersProvider =
    StreamProvider.family<List<Marker>, BuildContext>(
  (ref, context) async* {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response =
          read(markerRepositoryImplProvider).fetchAllMarkers().map((markers) {
        final list = <Marker>[];
        final geofences = <bg.Geofence>[];
        for (final marker in markers) {
          list.add(
            Marker(
              markerId: MarkerId(marker.markerId),
              position: LatLng(
                marker.latitude,
                marker.longitude,
              ),
              infoWindow: InfoWindow(
                title: marker.title,
                snippet: marker.description,
              ),
              consumeTapEvents: true,
              onTap: () {
                ref.read(showModalProvider).call(
                      context: context,
                      markerData: marker,
                    );
              },
            ),
          );
          geofences.add(
            bg.Geofence(
              identifier: marker.markerId,
              radius: markerCircleRadius,
              latitude: marker.latitude,
              longitude: marker.longitude,
              notifyOnEntry: true,
              notifyOnExit: true,
            ),
          );
        }
        // read(flutterBackgroundGeolocationServiceProvider)
        //     .addGeofences(geofences);
        return list;
      });
      debugPrint('全マーカーを取得しました。');
      yield* response.asBroadcastStream();
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
      final response =
          read(markerRepositoryImplProvider).fetchAllMarkers().map((event) {
        final list = <MarkerData>[];
        event.forEach(list.add);
        return list;
      });
      debugPrint('全マーカーを取得しました。');
      yield* response.asBroadcastStream();
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
