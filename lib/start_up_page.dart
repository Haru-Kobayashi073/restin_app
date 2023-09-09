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
        data: (data) {
          if (data != null) {
            return const MainPage();
          } else {
            return const SignInPage();
          }
        },
        error: (error, stackTrace) {
          return Scaffold(
            body: Center(
              child: Text(error.toString()),
            ),
          );
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }
}
