import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final searchMarkersProvider =
    FutureProvider.autoDispose.family<List<Marker>?, String>(
  (ref, query) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response =
          read(markerRepositoryImplProvider).searchMarkers(query: query);
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
