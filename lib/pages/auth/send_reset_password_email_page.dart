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
      fullscreenDialog: true,
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
        backgroundColor: ColorName.white,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(Icons.close, size: 32),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'パスワードをリセット',
                  style: AppTextStyle.authPageTitle,
                ),
                const Text(
                  'パスワードをリセットするためのメールを送信します。送り先のメールアドレスを入力してください。',
                  style: AppTextStyle.greyText,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: CommonTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    labelText: 'メールアドレス',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CommonButton(
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
                text: '送信',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
