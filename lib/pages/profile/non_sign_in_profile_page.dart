import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/profile/components/profile_components.dart';
import 'package:search_roof_top_app/pages/settings/settings_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class NonSignInProfilePage extends HookConsumerWidget {
  const NonSignInProfilePage({super.key, this.userId});
  final String? userId;

  static Route<dynamic> route(String? userId) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => NonSignInProfilePage(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tabs = ['投稿', '保存'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.white,
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: SvgPicture.asset(Assets.icons.setting, width: 66),
              onPressed: () => Navigator.push(
                context,
                SettingsPage.route(),
              ),
            ),
          ),
        ],
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            '新規登録/ログインをしよう！',
            style: AppTextStyle.profilePageUserName,
          ),
        ),
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileImageAvator(imageUrl: null),
                          Column(
                            children: [
                              Text(
                                '-',
                                style: AppTextStyle.profilePageUserValue,
                              ),
                              Text(
                                '投稿',
                                style: AppTextStyle.profilePageUserKey,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '----年--月--日',
                                style: AppTextStyle.profilePageUserValue,
                              ),
                              Text(
                                '登録した日',
                                style: AppTextStyle.profilePageUserKey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  TabBar(
                    tabs: tabs
                        .map((String name) => Tab(height: 50, text: name))
                        .toList(),
                    labelColor: Colors.black,
                    unselectedLabelColor: ColorName.black,
                    indicatorColor: ColorName.amber,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: CommonButton(
                    onPressed: () => Navigator.push(
                      context,
                      SignInPage.route(),
                    ),
                    text: 'ログインはこちら',
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: CommonButton(
                    onPressed: () => Navigator.push(
                      context,
                      SignInPage.route(),
                    ),
                    text: 'ログインはこちら',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
