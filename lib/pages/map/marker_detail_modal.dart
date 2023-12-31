import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/features/setting/setting.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/comment/comment_page.dart';
import 'package:search_roof_top_app/pages/map/components/map_components.dart';
import 'package:search_roof_top_app/pages/profile/profile_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class MarkerDetailModal extends HookConsumerWidget {
  const MarkerDetailModal({
    super.key,
    required this.markerData,
  });
  final MarkerData markerData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(isSavedProvider(markerData));
    final isAuthenticated = ref.read(isAuthenticatedProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 160),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorName.mediumGrey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        markerData.title,
                        style: AppTextStyle.markerListTiltle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              ProfilePage.route(
                                markerData.creatorId,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ref
                                .watch(
                                  fetchUserDataProvider(markerData.creatorId),
                                )
                                .when(
                                  data: (user) => user.imageUrl != ''
                                      ? CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            user.imageUrl.toString(),
                                          ),
                                          radius: 16,
                                        )
                                      : CircleAvatar(
                                          radius: 16,
                                          child: SvgPicture.asset(
                                            Assets.icons.person,
                                          ),
                                        ),
                                  error: (error, stackTrace) => ErrorPage(
                                    error: error,
                                    onTapReload: () => ref.invalidate(
                                      fetchUserDataProvider(
                                        markerData.creatorId,
                                      ),
                                    ),
                                  ),
                                  loading: () => const Loading(),
                                ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: ColorName.mediumGrey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.clear_rounded),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          markerData.description,
                          style: AppTextStyle.markerListDescription,
                          softWrap: true,
                        ),
                      ),
                      Text(
                        formatTimeAgo(markerData.createdAt),
                        style: AppTextStyle.markerListDescription,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                                return CommentPage(
                                  markerId: markerData.markerId,
                                );
                              },
                            );
                          },
                          icon: const Icon(FontAwesome.commenting_o),
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          constraints: const BoxConstraints(),
                          onPressed: () async {
                            if (isAuthenticated) {
                              await ref
                                  .read(switchBookMarkProvider)
                                  .call(markerId: markerData.markerId);
                              ref
                                ..invalidate(fetchAllMarkersProvider)
                                ..invalidate(fetchBookMarkMarkersProvider);
                              if (!context.mounted) {
                                return;
                              }
                              Navigator.pop(context);
                            } else {
                              await showDialog<void>(
                                context: context,
                                builder: (_) {
                                  return CommonDialog(
                                    title: 'ログインが必要です。ログイン画面に遷移しますか？',
                                    cancelText: 'キャンセル',
                                    okText: 'はい',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        SignInPage.route(),
                                      );
                                    },
                                  );
                                },
                              );
                            }
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
                          onPressed: () async {
                            await showDialog<void>(
                              context: context,
                              builder: (_) {
                                return CommonDialog(
                                  title: 'この投稿を報告しますか？',
                                  cancelText: 'いいえ',
                                  okText: 'はい',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ref.read(submitFragFormProvider).call();
                                  },
                                );
                              },
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.flag_outlined),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (_) => const GeofenceActiveDialog(),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: markerData.isGeofenceActive == true
                              ? ColorName.amber
                              : ColorName.mediumGrey,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.info_outline_rounded),
                            ),
                            Text(
                              markerData.isGeofenceActive == true
                                  ? '現在、使用されています'
                                  : '現在、使用されていません',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
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
                          progressIndicatorBuilder:
                              (_, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        )
                      : const ImageNotFound(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
