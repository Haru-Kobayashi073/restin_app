import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final fetchUserDataProvider =
    FutureProvider.autoDispose.family<UserData, String?>(
  (ref, uid) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response =
          await read(userRepositoryImplProvider).fetchUserData(uid);
      return response;
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('ユーザー情報取得エラー: $e');
      rethrow;
    }
  },
);
