import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

const flagForm =
    'https://docs.google.com/forms/d/e/1FAIpQLSeegBSG5747DtxHiv8-zUOXIOYhPhhfHwQUMfiMQREly-jMeg/viewform';

final submitFragFormProvider = Provider<Future<void> Function()>(
  (ref) => () async {
    final isNetworkCheck = await isNetworkConnected();
    try {
      await launchUrl(Uri.parse(flagForm));
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('報告ページエラー: $e');
    }
  },
);
