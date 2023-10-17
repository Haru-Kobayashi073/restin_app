import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/pages/comment/components/comment_components.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class CommentPage extends HookConsumerWidget {
  const CommentPage({super.key, required this.markerId});
  final String markerId;

  static Route<dynamic> route({required String markerId}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => CommentPage(
        markerId: markerId,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.deviceHeight - context.deviceHeight * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
          ref.watch(fetchMarkersCommentsProvider(markerId)).when(
                data: (comments) {
                  return comments.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return CommentCard(
                                index: index,
                                comment: comments[index],
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('コメントがありません'),
                        );
                },
                error: (error, stackTrace) => ErrorPage(
                  error: error,
                  onTapReload: () =>
                      ref.invalidate(fetchMarkersCommentsProvider(markerId)),
                ),
                loading: () => const Loading(),
              ),
          CommentButton(markerId: markerId),
        ],
      ),
    );
  }
}
