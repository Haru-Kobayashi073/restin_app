import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
/// Firebase Auth を用いてサインアップをする [AsyncNotifierProvider]。
final createMarkerControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateMarkerController, void>(
  CreateMarkerController.new,
);

class CreateMarkerController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
    // Do nothing since the return type is void.
  }

  final createMarkerProvider = Provider.autoDispose<
      Future<void> Function({
        required Marker marker,
        required VoidCallback onSuccess,
      })>(
    (ref) => ({
      required marker,
      required onSuccess,
    }) async {
      final read = ref.read;
      final isNetworkCheck = await isNetworkConnected();
      try {
        read(overlayLoadingWidgetProvider.notifier).update((state) => true);
        await read(markerRepositoryImplProvider).createMarker(
          marker: marker,
        );
        onSuccess();
        debugPrint('マーカーを作成しました。');
      } on AppException catch (e) {
        if (!isNetworkCheck) {
          const exception = AppException(
            message: 'Maybe your network is disconnected. Please check yours.',
          );
          throw exception;
        }

        debugPrint('マーカー作成エラー: $e');
      } finally {
        read(overlayLoadingWidgetProvider.notifier).update((state) => false);
      }
    },
  );
}
