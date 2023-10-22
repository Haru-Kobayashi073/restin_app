import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';

final emailVerificationTimerProvider = Provider.autoDispose<
    Future<void> Function({
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required onSuccess,
  }) async {
    final read = ref.read;
    try {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        final isEmailVerified =
            await ref.watch(checkEmailVerifiedProvider).call();
        if (isEmailVerified) {
          timer.cancel();
          onSuccess();
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      await read(authRepositoryImplProvider).currentUser?.reload();
      rethrow;
    }
  },
);
