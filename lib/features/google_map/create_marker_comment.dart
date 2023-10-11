import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

final createMarkerCommentProvider = Provider.autoDispose<
    Future<void> Function({
      required String markerId,
      required String comment,
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required markerId,
    required comment,
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      read(overlayLoadingWidgetProvider.notifier).update((state) => true);
      await read(markerRepositoryImplProvider)
          .createMarkerComment(markerId: markerId, comment: comment);
      onSuccess();
      debugPrint('コメントを作成しました。');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      debugPrint('コメント作成エラー: $e');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
