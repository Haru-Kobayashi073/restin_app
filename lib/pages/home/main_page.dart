import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/map/map_page.dart';
import 'package:search_roof_top_app/pages/profile/non_sign_in_profile_page.dart';
import 'package:search_roof_top_app/pages/profile/profile_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

enum TabType { home, profile }

final tabTypeProvider =
    StateProvider.autoDispose<TabType>((ref) => TabType.home);

class MainPage extends StatefulHookConsumerWidget {
  const MainPage({super.key, this.isAuthenticated = false});
  final bool isAuthenticated;

  static Route<dynamic> route({bool isAuthenticated = false}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => MainPage(isAuthenticated: isAuthenticated),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
    // Future.wait<void>([
    //   ref.read(flutterBackgroundGeolocationServiceProvider).initialize(),
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    final tabType = ref.watch(tabTypeProvider);
    final screens = [
      const MapPage(),
      widget.isAuthenticated
          ? const ProfilePage()
          : const NonSignInProfilePage(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          screens[tabType.index],
          tabType.index == 0 ? const FloatSearchBar() : const SizedBox(),
        ],
      ),
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
