import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

final signOutProvider = Provider.autoDispose<
    Future<void> Function({
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      read(overlayLoadingWidgetProvider.notifier).update((state) => true);
      await read(authRepositoryImplProvider).signOut();
      await read(sharedPreferencesServiceProvider).deleteAuthCredentials();
      ref
        ..invalidate(isAuthenticatedProvider)
        ..invalidate(isSavedProvider);
      onSuccess();
      debugPrint('ログアウトしました');
      read(scaffoldMessengerServiceProvider).showSuccessSnackBar('ログアウトしました');
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('ログアウトエラー: $e');
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar('ログアウトに失敗しました');
    } finally {
      read(overlayLoadingWidgetProvider.notifier).update((state) => false);
    }
  },
);
