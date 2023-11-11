import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

final updateUserDataProvider = Provider.autoDispose<
    Future<void> Function({
      String? userName,
      Tuple2<String?, File?>? imgInfo,
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
      await read(userRepositoryImplProvider).updateUserData(
        userName: userName,
        imgInfo: imgInfo,
      );
      onSuccess();
      debugPrint('情報の更新が完了しました');
      read(scaffoldMessengerServiceProvider)
          .showSuccessSnackBar('情報の更新が完了しました');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      } else if (imgInfo == null && userName.isNull) {
        ref
            .read(scaffoldMessengerServiceProvider)
            .showExceptionSnackBar('データが足りません');
      }
      debugPrint('更新エラー: $e');
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar('情報の更新に失敗しました');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
