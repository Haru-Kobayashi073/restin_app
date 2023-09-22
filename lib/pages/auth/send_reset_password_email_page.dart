import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class SendResetPasswordEmailPage extends HookConsumerWidget {
  const SendResetPasswordEmailPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SendResetPasswordEmailPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final sendResetPasswordEmail = ref
        .read(sendPasswordResetEmailControllerProvider.notifier)
        .sendResetPasswordEmailProvider;

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワードリセット'),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CommonTextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              labelText: 'メールアドレス',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(sendResetPasswordEmail).call(
                    email: emailController.text,
                    onSuccess: () async {
                      ScaffoldMessengerService.showSuccessSnackBar(
                        context,
                        'メールが送信されました!',
                      );
                      await Navigator.pushAndRemoveUntil(
                        context,
                        SignInPage.route(),
                        (route) => false,
                      );
                    },
                  );
            },
            child: const Text('送信'),
          ),
        ],
      ),
    );
  }
}
