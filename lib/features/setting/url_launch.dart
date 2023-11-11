import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

const termsUrl =
    'https://general-epoxy-a08.notion.site/bd8f223ae8d642f68648f4f2ae688f3f';
const privacyPolicyUrl =
    'https://general-epoxy-a08.notion.site/0d69396de49c4b78b58ca0ae3f57e8aa';

final termsSiteLaunchProvider = Provider<Future<void> Function()>(
  (ref) => () async {
    final isNetworkCheck = await isNetworkConnected();
    try {
      await launchUrl(Uri.parse(termsUrl));
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('利用規約ページエラー: $e');
    }
  },
);

final privacySiteLaunchProvider = Provider<Future<void> Function()>(
  (ref) => () async {
    final isNetworkCheck = await isNetworkConnected();
    try {
      await launchUrl(Uri.parse(privacyPolicyUrl));
    } on AppException catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      debugPrint('プライバシーポリシーページエラー: $e');
    }
  },
);
