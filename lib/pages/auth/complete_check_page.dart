import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/entry_user_information_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CompleteCheckPage extends StatefulHookConsumerWidget {
  const CompleteCheckPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const CompleteCheckPage(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteCheckPageState();
}

class _CompleteCheckPageState extends ConsumerState<CompleteCheckPage> {
  int count = 3;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count--;
        if (count == 0) {
          timer.cancel();
          Navigator.pushAndRemoveUntil(
            context,
            EntryUserInformationPage.route(),
            (_) => false,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorName.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '新規登録が完了しました',
                style: AppTextStyle.authPageTitle,
              ),
              Row(
                children: [
                  Text(
                    '$count',
                    style: AppTextStyle.largeGrey,
                  ),
                  const Text(
                    '秒後に',
                    style: AppTextStyle.greyText,
                  ),
                ],
              ),
              const Text(
                'ユーザー情報の入力ページに移動します！',
                style: AppTextStyle.greyText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
