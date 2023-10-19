import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';

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
      appBar: AppBar(
        title: const Text('設定'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('プライバシーポリシー'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('利用規約'),
            onTap: () {},
          ),
          isAuthenticated
              ? ListTile(
                  title: const Text('ログアウト'),
                  onTap: () => ref.read(signOut).call(
                    onSuccess: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        SignInPage.route(),
                        (route) => false,
                      );
                    },
                  ),
                )
              : ListTile(
                  title: const Text('ログイン'),
                  onTap: () => Navigator.push(context, SignInPage.route()),
                )
        ],
      ),
    );
  }
}
