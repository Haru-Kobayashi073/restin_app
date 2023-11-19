import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
import 'package:search_roof_top_app/utils/utils.dart';

/// 各認証ページの情報を定義したenum
enum AuthContent {
  signUp(
    authContentText: '新規登録',
    checkIsDone: [false, false, false],
  ),
  emailVerification(
    authContentText: 'メール送信',
    checkIsDone: [true, false, false],
  ),
  entryInformation(
    authContentText: '情報入力',
    checkIsDone: [true, true, false],
  ),
  resetPassword(
    authContentText: 'パスワードをリセット',
    checkIsDone: [false, false, false],
  );

  const AuthContent({
    required this.authContentText,
    required this.checkIsDone,
  });

  final String authContentText;
  final List<bool> checkIsDone;
}

class AuthPageWrapper extends HookConsumerWidget {
  const AuthPageWrapper({
    super.key,
    this.canPop = true,
    this.hasTitle = true,
    this.formKey,
    required this.authContent,
    required this.children,
  });

  final bool canPop;
  final bool hasTitle;
  final Key? formKey;
  final AuthContent authContent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: SvgPicture.asset(
                    Assets.icons.restin,
                    width: 80,
                    height: 80,
                  ),
                ),
                authContent == AuthContent.resetPassword
                    ? const SizedBox()
                    : SizedBox(
                        width: context.deviceWidth * 0.65,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: List.generate(
                                  authContent.checkIsDone.length,
                                  (index) => AuthContentsStatus(
                                    index: index + 1,
                                    isDone: authContent.checkIsDone[index],
                                    currentContent: authContent ==
                                        AuthContent.values[index],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                authContent.checkIsDone.length,
                                (index) => Text(
                                  AuthContent.values[index].authContentText,
                                  style:
                                      authContent == AuthContent.values[index]
                                          ? null
                                          : AppTextStyle.greyText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 16),
                hasTitle
                    ? Row(
                        children: [
                          canPop
                              ? Material(
                                  color: ColorName.white,
                                  child: InkWell(
                                    splashColor: ColorName.mediumGrey,
                                    onTap: () => Navigator.pop(context),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child:
                                          SvgPicture.asset(Assets.icons.back),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Text(
                            authContent == AuthContent.emailVerification
                                ? 'メールを送信しました'
                                : authContent.authContentText,
                            style: AppTextStyle.authPageTitle,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Column(
                  children: children,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
