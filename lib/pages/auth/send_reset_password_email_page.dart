import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
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
    final formKey = useFormStateKey();

    return AuthPageWrapper(
      formKey: formKey,
      authContent: AuthContent.resetPassword,
      children: [
        const Text(
          'パスワードをリセットするためのメールを送信します。送り先のメールアドレスを入力してください。',
          style: AppTextStyle.greyText,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: CommonTextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: Validator.email,
            textInputAction: TextInputAction.done,
            labelText: 'メールアドレス',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CommonButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await ref.read(sendResetPasswordEmailProvider).call(
                      email: emailController.text,
                      onSuccess: () async {
                        await Navigator.pushAndRemoveUntil(
                          context,
                          SignInPage.route(),
                          (route) => false,
                        );
                      },
                    );
              }
            },
            text: '送信',
          ),
        ),
      ],
    );
  }
}
