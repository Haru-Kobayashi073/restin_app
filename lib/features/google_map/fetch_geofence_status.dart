import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final fetchGeofenceStatusProvider =
    Provider<Future<bool> Function({required String markerId})>(
  (ref) => ({required markerId}) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final isGeofenceActive = await read(markerRepositoryImplProvider)
          .fetchGeofenceStatus(markerId: markerId);
      debugPrint('GeoFenceのステータスを取得しました');
      return isGeofenceActive;
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('GeoFenceのステータス取得エラー: $e');
      rethrow;
    }
  },
);
