import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SignUpPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final signUp = ref.read(signUpControllerProvider.notifier).signUpProvider;

    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CommonTextField(
              controller: userNameController,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(emailFocusNode),
              textInputAction: TextInputAction.next,
              labelText: 'ユーザーネーム',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CommonTextField(
              controller: emailController,
              focusNode: emailFocusNode,
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
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              labelText: 'パスワード',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(signUp).call(
                    userName: userNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    onSuccess: () async {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MainPage.route(),
                        (route) => false,
                      );
                    },
                  );
            },
            child: const Text('新規登録'),
          ),
        ],
      ),
    );
  }
}
