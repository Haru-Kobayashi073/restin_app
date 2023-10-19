import 'package:flutter/material.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({super.key, this.isTwicePop = false});
  final bool isTwicePop;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ログインが必要です'),
      content: const Text('ログイン画面に遷移しますか？'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (isTwicePop) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
              context,
              SignInPage.route(),
              (_) => false,
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
