import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isFirstLaunch =
          ref.watch(sharedPreferencesServiceProvider).getIsFirstLaunch();
      if (isFirstLaunch) {
        ref
            .read(sharedPreferencesServiceProvider)
            .setIsFirstLaunch(isFirstLaunch: false);
      }
    });

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
                  onPressed: () => Navigator.push(context, SignInPage.route()),
                  text: 'ログイン',
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CommonButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MainPage.route(),
                        (route) => false,
                      );
                    },
                    color: ColorName.white,
                    text: 'スキップ',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
