import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final blockUserProvider = Provider<
    Future<void> Function({
      required String blockedUid,
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required blockedUid,
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      await read(userRepositoryImplProvider).blockUser(blockedUid: blockedUid);
      debugPrint('$blockedUidをブロックしました');
      onSuccess();
    } on Exception catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('ブロックエラー: $e');
    }
  },
);
