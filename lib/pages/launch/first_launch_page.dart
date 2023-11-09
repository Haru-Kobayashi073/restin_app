import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/setting/setting.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class FirstLaunchPage extends HookConsumerWidget {
  const FirstLaunchPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const FirstLaunchPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstLaunch =
        ref.watch(sharedPreferencesServiceProvider).getIsFirstLaunch();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: context.deviceHeight * 0.01),
            Column(
              children: [
                SvgPicture.asset(Assets.icons.restin),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Restin',
                    style: AppTextStyle.largePoppinFont,
                  ),
                ),
                Text(
                  '手軽に休憩場所を探そう',
                  style: AppTextStyle.mPlusFont,
                ),
              ],
            ),
            Column(
              children: [
                CommonButton(
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (_) => CommonDialog(
                        title: 'Restinの利用規約とプライバシーポリシーに同意して次に進む',
                        cancelText: '同意しない',
                        okText: '同意する',
                        onPressed: () {
                          if (isFirstLaunch) {
                            ref
                                .read(sharedPreferencesServiceProvider)
                                .setIsFirstLaunch(isFirstLaunch: false);
                          }
                          Navigator.pop(context);
                          Navigator.push(context, SignInPage.route());
                        },
                      ),
                    );
                  },
                  text: 'ログイン',
                ),
                CommonButton(
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (_) => CommonDialog(
                        title: 'Restinの利用規約とプライバシーポリシーに同意して次に進む',
                        cancelText: '同意しない',
                        okText: '同意する',
                        onPressed: () {
                          if (isFirstLaunch) {
                            ref
                                .read(sharedPreferencesServiceProvider)
                                .setIsFirstLaunch(isFirstLaunch: false);
                          }
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MainPage.route(),
                            (route) => false,
                          );
                        },
                      ),
                    );
                  },
                  color: ColorName.white,
                  text: 'スキップ',
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Restinの利用には、',
                      style: TextStyle(fontSize: 10),
                    ),
                    TextButton(
                      onPressed: () async =>
                          ref.read(termsSiteLaunchProvider).call(),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '利用規約',
                        style: TextStyle(
                          fontSize: 10,
                          color: ColorName.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      'と',
                      style: TextStyle(fontSize: 10),
                    ),
                    TextButton(
                      onPressed: () async =>
                          ref.read(privacySiteLaunchProvider).call(),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'プライバシーポリシー',
                        style: TextStyle(
                          fontSize: 10,
                          color: ColorName.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      'が適用されます',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
