import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/repositories/user/user_repository_impl.dart';

final isSavedProvider =
    StateProvider.family<bool, MarkerData>((ref, markerData) {
  final uid = ref.watch(userRepositoryImplProvider).currentUser!.uid;
  final isSaved = markerData.bookMarkedUserIds?.contains(uid) ?? false;
  return isSaved;
});
