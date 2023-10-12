import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final commentController = useTextEditingController();

    return SizedBox(
      height: context.deviceHeight - context.deviceHeight * 0.1,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 8, 32),
                  child: CommonTextField(
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    labelText: 'コメントを投稿する',
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await createMarkerComment(
                    markerId: markerId,
                    comment: commentController.text,
                    context: context,
                    ref: ref,
                  );
                  commentController.clear();
                },
                padding: const EdgeInsets.only(right: 8),
                icon: const Icon(Icons.send),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> createMarkerComment({
    required String markerId,
    required String comment,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    await ref.read(createMarkerCommentProvider).call(
          markerId: markerId,
          comment: comment,
          onSuccess: () {
            ScaffoldMessengerService.showSuccessSnackBar(
              context,
              'コメントを投稿しました',
            );
            ref.invalidate(fetchMarkersCommentsProvider(markerId));
            
          },
        );
  }
}
