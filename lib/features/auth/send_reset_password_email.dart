import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

final sendResetPasswordEmailProvider = Provider.autoDispose<
    Future<void> Function({
      required String email,
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required email,
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      read(overlayLoadingWidgetProvider.notifier).update((state) => true);
      await read(authRepositoryImplProvider).sendPasswordResetEmail(
        email: email,
      );
      onSuccess();
      debugPrint('メールを送信しました');
      read(scaffoldMessengerServiceProvider).showSuccessSnackBar('メールが送信されました');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      if (email.isEmpty) {
        const exception = AppException(
          message: 'Please input your email.',
        );
        throw exception;
      }
      debugPrint('パスワードリセットエラー: $e');
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar('メールの送信に失敗しました');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
