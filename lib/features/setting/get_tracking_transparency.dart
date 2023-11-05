import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final getTrackingTransparencyProvider = Provider<Future<void> Function()>(
  (ref) => () async {
    final isNetworkCheck = await isNetworkConnected();
    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
      debugPrint('トラッキングトランスペアレンシーの許可状況: $status');
    } on Exception catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('トラッキングトランスペアレンシーの許可エラー: $e');
    }
  },
);
