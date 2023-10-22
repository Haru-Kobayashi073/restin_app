import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

final createUserDataProvider = Provider.autoDispose<
    Future<void> Function({
      String? userName,
      Tuple2<String, File>? imgInfo,
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    userName,
    imgInfo,
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      read(overlayLoadingWidgetProvider.notifier).update((state) => true);
      await read(userRepositoryImplProvider).createUserData(
        userName,
        imgInfo,
      );
      onSuccess();
      debugPrint('ユーザー作成が完了しました');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('ユーザー作成エラー: $e');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
