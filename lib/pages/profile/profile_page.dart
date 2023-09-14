import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:search_roof_top_app/features/user/fetch_user_data.dart';
import 'package:search_roof_top_app/pages/settings/settings_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(fetchUserDataProvider);
    final tabs = ['投稿', 'いいね'];

    DateTime parseTimestampToDateTime(dynamic createdAt) {
      if (createdAt is Timestamp) {
        final parseDate = createdAt.toDate();
        return parseDate;
      }
      return DateTime(2023, 09);
    }

    return user.when(
      data: (data) {
        final createdDate = parseTimestampToDateTime(data?.createdAt);

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
              )
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                data?.userName ?? '名前を設定しましょう',
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
                              GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (_) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 20,
                                          sigmaY: 20,
                                        ),
                                        child: AlertDialog(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          content: data?.imageUrl != null
                                              ? CircleAvatar(
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    data!.imageUrl.toString(),
                                                  ),
                                                  radius: 112,
                                                )
                                              : CircleAvatar(
                                                  radius: 112,
                                                  child: SvgPicture.asset(
                                                    Assets.icons.person,
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: data?.imageUrl != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          data!.imageUrl.toString(),
                                        ),
                                        radius: 56,
                                      )
                                    : CircleAvatar(
                                        radius: 56,
                                        child: SvgPicture.asset(
                                          Assets.icons.person,
                                          width: 48,
                                        ),
                                      ),
                              ),
                              const Column(
                                children: [
                                  Text(
                                    '0',
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
                                    DateFormat('yyyy年M月d日').format(createdDate),
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: FilledButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute<dynamic>(
                                //     builder: (context) {
                                //       return const CreateMarkerDialog();
                                //     },
                                //     fullscreenDialog: true,
                                //   ),
                                // );
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'プロフィールを編集',
                              ),
                            ),
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
                            .map(
                              (String name) => Tab(
                                height: 50,
                                text: name,
                              ),
                            )
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
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('aaa'),
              ),
            ),
          ),
        );
      },
      loading: () => const Loading(),
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(error.toString()),
          ),
        );
      },
    );
  }
}
