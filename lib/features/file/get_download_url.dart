import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/file/file_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final getDownloadUrlProvider = Provider.autoDispose<Future<Image>>(
  (ref) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response = await read(fileRepositoryImplProvider).getDownloadUrl();
      debugPrint('画像URL取得が完了しました');
      return response;
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('画像URL取得エラー: $e');
      rethrow;
    }
  },
);
