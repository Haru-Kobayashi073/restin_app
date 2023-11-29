import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/comment/components/comment_components.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class CommentButton extends HookConsumerWidget {
  const CommentButton({super.key, required this.markerId});
  final String markerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> openCommentModalBottomSheet() async {
      final isAuthenticated = ref.read(isAuthenticatedProvider);
      if (isAuthenticated) {
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (BuildContext context) {
            return CommentForm(markerId: markerId);
          },
        );
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
                Navigator.push(context, SignInPage.route());
              },
            );
          },
        );
      }
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
              onPressed: () async => openCommentModalBottomSheet(),
              child: const Text(
                'コメントを投稿する',
                style: AppTextStyle.createMarkerTextFieldLabel,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () async => openCommentModalBottomSheet(),
          icon: const Icon(Icons.send, color: ColorName.amber),
          padding: const EdgeInsets.only(right: 16),
        ),
      ],
    );
  }
}
