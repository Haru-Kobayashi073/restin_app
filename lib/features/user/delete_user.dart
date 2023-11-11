import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';


final deleteUserProvider = Provider<
    Future<void> Function({
      required void Function() onSuccess,
    })>(
  (ref) => ({
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      await read(userRepositoryImplProvider).deleteUser();
      onSuccess();
      debugPrint('ユーザーを削除しました');
      read(scaffoldMessengerServiceProvider)
          .showSuccessSnackBar('ユーザー削除が完了しました');
    } on FirebaseAuthException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar('ユーザー削除に失敗しました');
      debugPrint('ユーザー削除エラー: $e');
    }
  },
);
