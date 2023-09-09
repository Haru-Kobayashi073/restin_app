import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

import '../../repositories/auth/auth_repository_impl.dart';

/// Firebase Auth を用いてサインアウトをする [AsyncNotifierProvider]。
final signOutControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignOutController, void>(
  SignOutController.new,
);

class SignOutController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
    // Do nothing since the return type is void.
  }

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
        onSuccess();
        debugPrint('ログアウトしました');
      } on AppException catch (e) {
        if (!isNetworkCheck) {
          const exception = AppException(
            message: 'Maybe your network is disconnected. Please check yours.',
          );
          throw exception;
        }
        debugPrint('ログアウトエラー: $e');
      } finally {
        read(overlayLoadingWidgetProvider.notifier).update((state) => false);
      }
    },
  );
}
