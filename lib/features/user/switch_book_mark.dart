import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final switchBookMarkProvider = Provider<
    Future<void> Function({
      required String markerId,
    })>(
  (ref) => ({
    required markerId,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      await read(userRepositoryImplProvider).switchBookMark(markerId: markerId);
      debugPrint('保存しました/削除しました。');
    } on FirebaseAuthException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('保存エラー: $e');
    }
  },
);
