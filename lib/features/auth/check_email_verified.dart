import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';

final checkEmailVerifiedProvider =
    Provider.autoDispose<Future<bool> Function()>(
  (ref) => () async {
    final read = ref.read;
    try {
      await read(authRepositoryImplProvider).currentUser?.reload();
      final isEmailVerified =
          await read(authRepositoryImplProvider).checkEmailVerified();
      return isEmailVerified;
    } on Exception catch (e) {
      debugPrint(e.toString());
      await read(authRepositoryImplProvider).currentUser?.reload();
      rethrow;
    }
  },
);
