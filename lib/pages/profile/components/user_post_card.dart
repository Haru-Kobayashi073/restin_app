import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/pages/comment/comment_page.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class UserPostCard extends HookConsumerWidget {
  const UserPostCard({super.key, required this.markerData});
  final MarkerData markerData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(isSavedProvider(markerData));

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorName.white,
        boxShadow: const [
          BoxShadow(
            color: ColorName.mediumGrey,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  markerData.title,
                  style: AppTextStyle.markerListTiltle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                formatTimeAgo(markerData.createdAt),
                style: AppTextStyle.markerListDescription,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    markerData.description,
                    style: AppTextStyle.markerListDescription,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: markerData.imageUrl != ''
                ? CachedNetworkImage(
                    imageUrl: markerData.imageUrl!,
                    imageBuilder: (_, imageProvider) => Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: context.deviceHeight * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (_, url, downloadProgress) =>
                        CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  )
                : const ImageNotFound(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    context: context,
                    backgroundColor: ColorName.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return CommentPage(markerId: markerData.markerId);
                    },
                  );
                },
                icon: const Icon(FontAwesome.commenting_o),
              ),
              IconButton(
                onPressed: () async {
                  await switchBookMark(
                    markerId: markerData.markerId,
                    ref: ref,
                  );
                  ref
                    ..invalidate(fetchUserMarkersProvider)
                    ..invalidate(fetchBookMarkMarkersProvider);
                },
                icon: isSaved
                    ? const Icon(
                        Icons.bookmark_outlined,
                        weight: 0.2,
                        color: ColorName.amber,
                      )
                    : const Icon(Icons.bookmark_outline),
              ),
              IconButton(
                onPressed: () {
                  final read = ref.read;
                  read(
                    tappedMarkerPositionProvider.notifier,
                  ).state = LatLng(
                    markerData.latitude,
                    markerData.longitude,
                  );
                  read(tabTypeProvider.notifier).state = TabType.home;
                  final mapController = read(mapControllerProvider);
                  mapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target:
                            read(tappedMarkerPositionProvider.notifier).state!,
                        zoom: 18,
                      ),
                    ),
                  );
                  mapController
                      ?.showMarkerInfoWindow(MarkerId(markerData.markerId));

                  read(showModalProvider).call(markerData: markerData);
                },
                icon: const Icon(Icons.pin_drop_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> switchBookMark({
    required String markerId,
    required WidgetRef ref,
  }) async {
    await ref.read(switchBookMarkProvider).call(markerId: markerId);
  }
}
