import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
import 'package:search_roof_top_app/pages/auth/entry_user_information_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class IsEmailVerifiedPage extends HookConsumerWidget {
  const IsEmailVerifiedPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const IsEmailVerifiedPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmailVerified = useState(false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(emailVerificationTimerProvider).call(
        onSuccess: () {
          isEmailVerified.value = true;
        },
      );
    });
    return isEmailVerified.value
        ? AuthPageWrapper(
            canPop: false,
            hasTitle: false,
            authContent: AuthContent.emailVerification,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: SvgPicture.asset(
                  Assets.icons.checkCircle,
                  width: context.deviceWidth * 0.2,
                ),
              ),
              const Text(
                '新規登録が完了しました',
                style: AppTextStyle.authPageTitle,
              ),
              const SizedBox(height: 32),
              CommonButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  EntryUserInformationPage.route(),
                  (_) => false,
                ),
                text: '情報入力画面へ',
              ),
            ],
          )
        : AuthPageWrapper(
            authContent: AuthContent.emailVerification,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'メールの確認が完了するとページが移動します!',
                      style: AppTextStyle.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'ご入力いただいたメールアドレスに確認メールをお送りしましたので、ご確認ください。',
                      style: AppTextStyle.greyText,
                    ),
                  ),
                  const Text(
                    '※ メールが届かない場合は',
                    style: AppTextStyle.greyText,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: precautionsForEmailVerified
                          .map(
                            (text) => ItemizedTextRow(text: text),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.deviceHeight * 0.1),
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            ],
          );
  }
}
