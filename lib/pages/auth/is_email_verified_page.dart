import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/pages/auth/complete_check_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class IsEmailVerifiedPage extends StatefulHookConsumerWidget {
  const IsEmailVerifiedPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const IsEmailVerifiedPage(),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IsEmailVerifiedPageState();
}

class _IsEmailVerifiedPageState extends ConsumerState<IsEmailVerifiedPage>
    with WidgetsBindingObserver {
  bool isEmailVerifiedState = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && isEmailVerifiedState) {
      Navigator.pushAndRemoveUntil(
        context,
        CompleteCheckPage.route(),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(emailVerificationTimerProvider).call(
        onSuccess: () {
          if (!mounted) {
            return;
          }
          setState(() {
            isEmailVerifiedState = true;
          });
        },
      );
    });

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '送信が完了しました',
                  style: AppTextStyle.authPageTitle,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'メールの確認が完了するとページが移動します!',
                    style: AppTextStyle.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'ご入力いただいたメールアドレスに確認メールをお送りしましたので、ご確認ください。',
                    style: AppTextStyle.greyText,
                  ),
                ),
                const Text(
                  '※ メールが届かない場合は',
                  style: AppTextStyle.greyText,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: precautionsForEmailVerified
                        .map(
                          (text) => ItemizedTextRow(text: text),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            SizedBox(height: context.deviceHeight * 0.06)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
