import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final fetchUserMarkersProvider =
    FutureProvider.autoDispose.family<List<MarkerData>, String?>(
  (ref, uid) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    final list = <MarkerData>[];
    try {
      await read(userRepositoryImplProvider)
          .fetchUserMarkers(uid)
          .then((value) => value!.forEach(list.add));
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
