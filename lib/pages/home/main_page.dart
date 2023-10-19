import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/map/map_page.dart';
import 'package:search_roof_top_app/pages/profile/non_sign_in_profile_page.dart';
import 'package:search_roof_top_app/pages/profile/profile_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';

enum TabType { home, profile }

final tabTypeProvider = StateProvider<TabType>((ref) => TabType.home);

class MainPage extends HookConsumerWidget {
  const MainPage({super.key, this.isAuthenticated = false});
  final bool isAuthenticated;

  static Route<dynamic> route({bool isAuthenticated = false}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => MainPage(isAuthenticated: isAuthenticated),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(tabTypeProvider);
    final screens = [
      const MapPage(),
      isAuthenticated ? const ProfilePage() : const NonSignInProfilePage(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[tabType.index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorName.white,
        selectedItemColor: ColorName.black,
        unselectedItemColor: ColorName.mediumGrey,
        elevation: 0,
        currentIndex: tabType.index,
        onTap: (int selectIndex) {
          ref
              .read(
                tabTypeProvider.notifier,
              )
              .state = TabType.values[selectIndex];
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'マップ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'マイページ',
          ),
        ],
      ),
    );
  }
}
