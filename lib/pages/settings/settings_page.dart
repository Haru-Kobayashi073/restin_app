import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/sign_out.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/repositories/auth/auth_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';
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
    final user = ref.watch(authUserProvider);

    return user.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorName.white,
            title: Text(data?.displayName ?? '名前を設定しましょう'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(data?.email ?? 'メールアドレスを設定しましょう'),
                GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://www.photolibrary.jp/mhd6/img174/450-201010070921378146.jpg',
                    ),
                    radius: 56,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(signOut).call(
                      onSuccess: () async {
                        await Navigator.pushAndRemoveUntil(
                          context,
                          SignInPage.route(),
                          (route) => false,
                        );
                      },
                    );
                  },
                  child: const Text('ログアウト'),
                )
              ],
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
