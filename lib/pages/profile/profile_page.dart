import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/pages/profile/components/profile_components.dart';
import 'package:search_roof_top_app/pages/profile/edit_profile_page.dart';
import 'package:search_roof_top_app/pages/profile/user_post_page.dart';
import 'package:search_roof_top_app/pages/settings/settings_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key, this.userId});
  final String? userId;

  static Route<dynamic> route(String? userId) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => ProfilePage(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(fetchUserDataProvider(userId));
    const tabs = ['投稿', '保存'];
    final myUid =
        ref.watch(sharedPreferencesServiceProvider).getAuthCredentials();

    return user.when(
      data: (data) {
        final createdDate = parseTimestampToDateTime(data.createdAt);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorName.white,
            centerTitle: false,
            actions: [
              userId.isNull || myUid == userId
                  ? Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: IconButton(
                        icon: SvgPicture.asset(Assets.icons.setting, width: 66),
                        onPressed: () => Navigator.push(
                          context,
                          SettingsPage.route(),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                data.userName ?? '名前を設定しましょう',
                style: AppTextStyle.profilePageUserName,
              ),
            ),
          ),
          body: DefaultTabController(
            length: tabs.length,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileImageAvator(
                                imageUrl: data.imageUrl,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data.markersCounts.toString(),
                                    style: AppTextStyle.profilePageUserValue,
                                  ),
                                  const Text(
                                    '投稿',
                                    style: AppTextStyle.profilePageUserKey,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    DateFormat('yyyy年M月d日')
                                        .format(createdDate!),
                                    style: AppTextStyle.profilePageUserValue,
                                  ),
                                  const Text(
                                    '始めた日',
                                    style: AppTextStyle.profilePageUserKey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          userId.isNull || myUid == userId
                              ? Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: FilledButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      EditProfilePage.route(userData: data),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: const Text(
                                      'プロフィールを編集',
                                    ),
                                  ),
                                )
                              : const SizedBox()
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
                  ref.watch(fetchUserMarkersProvider(userId)).when(
                        data: (markers) => UserPostPage(markerData: markers),
                        error: (error, stackTrace) => ErrorPage(
                          error: error,
                          onTapReload: () =>
                              ref.invalidate(fetchUserMarkersProvider),
                        ),
                        loading: () => const Loading(),
                      ),
                  ref.watch(fetchBookMarkMarkersProvider(userId)).when(
                        data: (markers) => UserPostPage(
                          markerData: markers,
                          isUserPostPage: false,
                        ),
                        error: (error, stackTrace) => ErrorPage(
                          error: error,
                          onTapReload: () =>
                              ref.invalidate(fetchBookMarkMarkersProvider),
                        ),
                        loading: () => const Loading(),
                      ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => ErrorPage(
        error: error,
        onTapReload: () => ref.invalidate(fetchUserDataProvider),
      ),
      loading: () => const Loading(),
    );
  }
}
