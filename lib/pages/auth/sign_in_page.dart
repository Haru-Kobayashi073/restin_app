import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/sign_in.dart';
import 'package:search_roof_top_app/pages/auth/send_reset_password_email_page.dart';
import 'package:search_roof_top_app/pages/auth/sign_up_page.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SignInPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final signIn = ref.read(signInControllerProvider.notifier).signInProvider;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
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
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
              textInputAction: TextInputAction.next,
              labelText: 'メールアドレス',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CommonTextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              labelText: 'パスワード',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(signIn).call(
                    email: emailController.text,
                    password: passwordController.text,
                    onSuccess: () async {
                      ScaffoldMessengerService.showSuccessSnackBar(
                        context,
                        'ログインしました!',
                      );
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MainPage.route(),
                        (route) => false,
                      );
                    },
                  );
            },
            child: const Text('ログイン'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                SignUpPage.route(),
              );
            },
            child: const Text('新規登録'),
          ),
          ElevatedButton(
            child: const Text('パスワードリセット'),
            onPressed: () async {
              await Navigator.push(
                context,
                SendResetPasswordEmailPage.route(),
              );
            },
          ),
        ],
      ),
    );
  }
}
