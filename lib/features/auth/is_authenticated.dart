import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  final read = ref.read;
  try {
    final authCredentials =
        read(sharedPreferencesServiceProvider).getAuthCredentials();
    return authCredentials.isNotEmpty;
  } on Exception catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
});
