import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final changeGeofenceStatusProvider =
    Provider<Future<void> Function({required String markerId})>(
  (ref) => ({required markerId}) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      await read(markerRepositoryImplProvider)
          .changeGeofenceStatus(markerId: markerId);
      ref.invalidate(fetchAllMarkersProvider);
      debugPrint('GeoFenceのステータスが変更されました');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('GeoFenceのステータス変更エラー: $e');
    }
  },
);
