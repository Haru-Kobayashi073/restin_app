import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
import 'package:search_roof_top_app/pages/auth/is_email_verified_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
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
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final signUp = ref.read(signUpControllerProvider.notifier).signUpProvider;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '新規登録',
                    style: AppTextStyle.authPageTitle,
                  ),
                  const Text(
                    '新規登録のために確認メールをお送りします。\nご確認ください。',
                    style: AppTextStyle.greyText,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CommonTextField(
                      controller: emailController,
                      keyboardType: TextInputType.name,
                      focusNode: emailFocusNode,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CommonButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(signUp).call(
                            email: emailController.text,
                            password: passwordController.text,
                            onSuccess: () async {
                              await Navigator.push(
                                context,
                                IsEmailVerifiedPage.route(),
                              );
                            },
                          );
                    }
                  },
                  text: '新規登録',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
