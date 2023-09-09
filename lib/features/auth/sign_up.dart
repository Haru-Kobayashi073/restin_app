import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

import '../../repositories/auth/auth_repository_impl.dart';

/// Firebase Auth を用いてサインアップをする [AsyncNotifierProvider]。
final signUpControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignUpController, void>(
  SignUpController.new,
);

class SignUpController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
    // Do nothing since the return type is void.
  }

  final signUpProvider = Provider.autoDispose<
      Future<void> Function({
        required String userName,
        required String email,
        required String password,
        required VoidCallback onSuccess,
      })>(
    (ref) => ({
      required userName,
      required email,
      required password,
      required onSuccess,
    }) async {
      final read = ref.read;
      final isNetworkCheck = await isNetworkConnected();
      try {
        read(overlayLoadingWidgetProvider.notifier).update((state) => true);
        await read(authRepositoryImplProvider).signUp(
          userName: userName,
          email: email,
          password: password,
        );
        onSuccess();
        debugPrint('新規登録しました');
      } on FirebaseAuthException catch (e) {
        if (!isNetworkCheck) {
          const exception = AppException(
            message: 'Maybe your network is disconnected. Please check yours.',
          );
          throw exception;
        }

        if (userName.isEmpty || email.isEmpty || password.isEmpty) {
          const exception = AppException(
            message: 'Please input your user name, email, and password.',
          );
          throw exception;
        }
        debugPrint('新規登録エラー: $e');
      } finally {
        read(overlayLoadingWidgetProvider.notifier).update((state) => false);
      }
    },
  );
}
