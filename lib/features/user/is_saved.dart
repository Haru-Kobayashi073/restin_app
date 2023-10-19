import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';

final isSavedProvider =
    StateProvider.family<bool, MarkerData>((ref, markerData) {
  final isAuthenticated = ref.read(isAuthenticatedProvider);
  try {
    if (!isAuthenticated) {
      return false;
    }
    final uid = ref.watch(userRepositoryImplProvider).currentUser!.uid;
    final isSaved = markerData.bookMarkedUserIds?.contains(uid) ?? false;
    return isSaved;
  } on Exception catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
});
