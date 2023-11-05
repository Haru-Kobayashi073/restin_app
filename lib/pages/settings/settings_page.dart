import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/features/setting/setting.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/launch/first_launch_page.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOut = ref
        .read(
          signOutControllerProvider.notifier,
        )
        .signOutProvider;
    final isAuthenticated = ref.read(isAuthenticatedProvider.notifier).state;

    return Scaffold(
      appBar: const HomeAppBar(text: '設定'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('利用規約'),
            onTap: () async => ref.read(termsSiteLaunchProvider).call(),
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            onTap: () async => ref.read(privacySiteLaunchProvider).call(),
          ),
          isAuthenticated
              ? ListTile(
                  title: const Text('ログアウト'),
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (_) => CommonDialog(
                        title: '本当にログアウトしますか？',
                        cancelText: 'キャンセル',
                        okText: 'はい',
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(signOut).call(
                            onSuccess: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                SignInPage.route(canPop: false),
                                (route) => false,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                )
              : ListTile(
                  title: const Text('ログイン'),
                  onTap: () => Navigator.push(context, SignInPage.route()),
                ),
          isAuthenticated
              ? ListTile(
                  title: const Text('アカウント削除'),
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (_) => CommonDialog(
                        title: '本当にアカウントを削除しますか？',
                        cancelText: 'キャンセル',
                        okText: 'はい',
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(deleteUserProvider).call(
                            onSuccess: () {
                              ref.read(signOut).call(
                                onSuccess: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    FirstLaunchPage.route(),
                                    (route) => false,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
