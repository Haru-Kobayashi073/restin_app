import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/models/comment.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class CommentCard extends HookConsumerWidget {
  const CommentCard({
    super.key,
    required this.index,
    required this.comment,
  });
  final int index;
  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: index == 0
              ? const BorderSide(color: ColorName.mediumGrey)
              : BorderSide.none,
          bottom: const BorderSide(color: ColorName.mediumGrey),
        ),
      ),
      child: ref.watch(fetchUserDataProvider(comment.creatorId)).when(
            data: (user) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          user.imageUrl != null
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    user.imageUrl!,
                                  ),
                                  radius: 14,
                                )
                              : CircleAvatar(
                                  radius: 14,
                                  child: SvgPicture.asset(
                                    Assets.icons.person,
                                  ),
                                ),
                          const SizedBox(width: 16),
                          Text(
                            user.userName ?? '名前が設定されていません',
                            style: AppTextStyle.commentUserName,
                          ),
                        ],
                      ),
                      Text(
                        formatTimeAgo(comment.createdAt),
                        style: AppTextStyle.commentCreatedAt,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorName.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(comment.comment),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => ErrorPage(
              error: error,
              onTapReload: () =>
                  ref.invalidate(fetchUserDataProvider(comment.creatorId)),
            ),
            loading: () => const Loading(),
          ),
    );
  }
}
