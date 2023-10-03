import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:tuple/tuple.dart';

final searchMarkersProvider = FutureProvider.autoDispose
    .family<List<Marker>?, Tuple2<String, BuildContext>>(
  (ref, param) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final list = <Marker>[];
      await read(markerRepositoryImplProvider)
          .searchMarkers(query: param.item1)
          .then((value) {
        for (final document in value) {
          list.add(
            Marker(
              markerId: MarkerId(document.markerId),
              position: LatLng(
                document.latitude,
                document.longitude,
              ),
              infoWindow: InfoWindow(
                title: document.title,
                snippet: document.description,
              ),
              consumeTapEvents: true,
              onTap: () {
                ref.read(showModalProvider).call(
                      context: param.item2,
                      markerData: document,
                    );
              },
            ),
          );
        }
        return list;
      });
      debugPrint('全マーカーを取得しました。');
      return list;
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

final searchMarkerDataProvider = FutureProvider.autoDispose
    .family<List<MarkerData>?, Tuple2<String, BuildContext>>(
  (ref, param) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response = await read(markerRepositoryImplProvider)
          .searchMarkers(query: param.item1);
      debugPrint('全マーカーを取得しました。');
      return response;
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
