import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class CommentForm extends HookConsumerWidget {
  const CommentForm({super.key, required this.markerId});
  final String markerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final formKey = useFormStateKey();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 8, 24),
                    child: CommonTextField(
                      controller: commentController,
                      keyboardType: TextInputType.multiline,
                      labelText: 'コメントを投稿する',
                      autofocus: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'コメントを入力してください。';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    } else {
                      await createMarkerComment(
                        markerId: markerId,
                        comment: commentController.text,
                        context: context,
                        ref: ref,
                      );
                      commentController.clear();
                    }
                  },
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(right: 8, top: 32),
                  icon: const Icon(Icons.send, color: ColorName.amber),
                ),
              ],
            ),
          ),
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
            Navigator.pop(context);
            ref
                .read(scaffoldMessengerServiceProvider)
                .showSuccessSnackBar('コメントを投稿しました');
            ref.invalidate(fetchMarkersCommentsProvider(markerId));
          },
        );
  }
}
