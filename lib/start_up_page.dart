import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

import 'repositories/auth/auth_repository_impl.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(authUserProvider).when(
            data: (data) =>
                data != null ? const MainPage() : const SignInPage(),
            error: (error, stackTrace) => ErrorPage(
              error: error,
              onTapReload: () => ref.invalidate(authUserProvider),
            ),
            loading: () => const Loading(),
          ),
    );
  }
}
