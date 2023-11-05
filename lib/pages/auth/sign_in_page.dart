import 'package:app_tracking_transparency/app_tracking_transparency.dart';
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
  const SignInPage({super.key, this.canPop});
  final bool? canPop;

  static Route<dynamic> route({bool? canPop}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => SignInPage(canPop: canPop),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future<void> initPlugin() async {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPlugin();
    });

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();
    final signIn = ref.read(signInControllerProvider.notifier).signInProvider;
    final obscurePassword = useToggle(true);
    final formKey = useFormStateKey();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: SvgPicture.asset(
                    Assets.icons.restin,
                    width: 80,
                    height: 80,
                  ),
                ),
                Row(
                  children: [
                    canPop ?? true
                        ? Material(
                            color: ColorName.white,
                            child: InkWell(
                              splashColor: ColorName.mediumGrey,
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(Assets.icons.back),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const Text(
                      'ログイン',
                      style: AppTextStyle.authPageTitle,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
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
                const SizedBox(
                  height: 16,
                ),
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
                CommonButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      SignUpPage.route(),
                    );
                  },
                  color: ColorName.white,
                  text: '新規登録',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
