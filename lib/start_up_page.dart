import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

import 'repositories/auth/auth_repository_impl.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(tabTypeProvider);
    final isFirstLaunch =
        ref.watch(sharedPreferencesServiceProvider).getIsFirstLaunch();
    if (isFirstLaunch) {
      ref
          .read(sharedPreferencesServiceProvider)
          .setIsFirstLaunch(isFirstLaunch: false);
    }

    return Scaffold(
      resizeToAvoidBottomInset: tabType.index == 0 ? false : null,
      body: ref.watch(authUserProvider).when(
            data: (data) =>
                data != null || !isFirstLaunch || !isFirstLaunch && data == null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          MainPage(isAuthenticated: data != null),
                          tabType.index == 0
                              ? const FloatSearchBar()
                              : const SizedBox(),
                        ],
                      )
                    : const SignInPage(),
            error: (error, stackTrace) => ErrorPage(
              error: error,
              onTapReload: () => ref.invalidate(authUserProvider),
            ),
            loading: () => const Loading(),
          ),
    );
  }
}
