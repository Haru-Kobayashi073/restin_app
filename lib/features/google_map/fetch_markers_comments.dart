import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/comment.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final fetchMarkersCommentsProvider =
    FutureProvider.autoDispose.family<List<Comment>, String>(
  (ref, markerId) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    final list = <Comment>[];
    try {
      await read(markerRepositoryImplProvider)
          .fetchMarkersComments(markerId: markerId)
          .then((value) => value.forEach(list.add));
      debugPrint('マーカーのコメントを取得しました。');
      return list;
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      debugPrint('マーカーのコメント取得エラー: $e');
      rethrow;
    }
  },
);
