import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/map/map_page.dart';
import 'package:search_roof_top_app/pages/settings/settings_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MainPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = useState<TabItem>(TabItem.map);

    final navigatorKeys = <TabItem, GlobalKey<NavigatorState>>{
      TabItem.map: GlobalKey<NavigatorState>(),
      TabItem.mypage: GlobalKey<NavigatorState>(),
    };

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Stack(
        children: TabItem.values
            .map(
              (tabItem) => Offstage(
                offstage: currentTab.value != tabItem,
                child: Navigator(
                  key: navigatorKeys[tabItem],
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute<Widget>(
                      builder: (context) => tabItem.page,
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorName.white,
        selectedItemColor: ColorName.black,
        unselectedItemColor: ColorName.mudiumGrey,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: TabItem.values.indexOf(currentTab.value),
        items: TabItem.values
            .map(
              (tabItem) => BottomNavigationBarItem(
                icon: Icon(tabItem.icon),
                label: tabItem.title,
              ),
            )
            .toList(),
        onTap: (index) {
          // ③ 選択済なら第一階層まで pop / 未選択なら currentTab に指定
          final selectedTab = TabItem.values[index];
          if (currentTab.value == selectedTab) {
            navigatorKeys[selectedTab]
                ?.currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            currentTab.value = selectedTab;
          }
        },
      ),
    );
  }
}

enum TabItem {
  map(
    title: 'マップ',
    icon: Icons.map_rounded,
    page: MapPage(),
  ),

  mypage(
    title: 'マイページ',
    icon: Icons.person,
    page: SettingsPage(),
  );

  const TabItem({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;

  final IconData icon;

  final Widget page;
}

final isShowDialogProvider = StateProvider<bool>((ref) => false);
