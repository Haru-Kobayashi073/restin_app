import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/comment/components/comment_components.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CommentButton extends HookConsumerWidget {
  const CommentButton({super.key, required this.markerId});
  final String markerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void openCommentModalBottomSheet() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CommentForm(markerId: markerId);
        },
      );
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  side: BorderSide(
                    color: ColorName.mediumGrey,
                  ),
                ),
                padding: const EdgeInsets.all(12),
              ),
              onPressed: openCommentModalBottomSheet,
              child: const Text(
                'コメントを投稿する',
                style: AppTextStyle.createMarkerTextFieldLabel,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: openCommentModalBottomSheet,
          icon: const Icon(Icons.send, color: ColorName.amber),
          padding: const EdgeInsets.only(right: 16),
        ),
      ],
    );
  }
}
