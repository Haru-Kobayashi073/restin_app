import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/sign_in.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
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
    final obscurePassword = useToggle(true);
    final formKey = useFormStateKey();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ログイン',
                style: AppTextStyle.authPageTitle,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CommonTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(passwordFocusNode),
                      validator: Validator.email,
                      textInputAction: TextInputAction.next,
                      labelText: 'メールアドレス',
                    ),
                  ),
                  CommonTextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    validator: Validator.password,
                    obscureText: obscurePassword.value,
                    maxLines: 1,
                    labelText: 'パスワード',
                    suffixIcon: PasswordVisibilityIcon(
                      visibility: obscurePassword.value,
                      onPressed: obscurePassword.toggle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text(
                        'パスワードをお忘れの方',
                        style: AppTextStyle.underline,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          SendResetPasswordEmailPage.route(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CommonButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
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
                                  MainPage.route(isAuthenticated: true),
                                  (route) => false,
                                );
                              },
                            );
                      }
                    },
                    text: 'ログイン',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CommonButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          SignUpPage.route(),
                        );
                      },
                      color: ColorName.white,
                      text: '新規登録',
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   child: const Text('スキップ'),
              //   onPressed: () async {
              //     await Navigator.pushAndRemoveUntil(
              //       context,
              //       MainPage.route(),
              //       (route) => false,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
