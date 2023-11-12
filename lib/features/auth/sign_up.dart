import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

final signUpProvider = Provider.autoDispose<
    Future<void> Function({
      required String email,
      required String password,
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required email,
    required password,
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      read(overlayLoadingWidgetProvider.notifier).update((state) => true);
      final response = await read(authRepositoryImplProvider).signUp(
        email: email,
        password: password,
      );
      await read(sharedPreferencesServiceProvider)
          .setAuthCredentials(uid: response.toString());
      ref
        ..invalidate(isAuthenticatedProvider)
        ..invalidate(isSavedProvider);
      onSuccess();
      debugPrint('送信しました');
      read(scaffoldMessengerServiceProvider).showSuccessSnackBar('送信しました');
    } on FirebaseAuthException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }

      if (email.isEmpty || password.isEmpty) {
        const exception = AppException(
          message: 'Please input your user name, email, and password.',
        );
        throw exception;
      }
      debugPrint('新規登録エラー: $e');
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar('新規登録に失敗しました');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
