import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/file/file_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final deleteFileProvider = Provider.autoDispose<
    Future<void> Function({
      required VoidCallback onSuccess,
    })>(
  (ref) => ({
    required onSuccess,
  }) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      await read(fileRepositoryImplProvider).deleteFile();
      debugPrint('画像を削除しました。');
      onSuccess();
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('画像の削除エラー: $e');
      rethrow;
    }
  },
);
