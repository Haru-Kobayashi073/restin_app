import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/pages/auth/sign_in_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class ErrorPage extends HookConsumerWidget {
  const ErrorPage({
    super.key,
    required this.onTapReload,
    this.onTapOk,
    this.error,
    this.showModal = true,
  });

  final void Function() onTapReload;
  final void Function(BuildContext)? onTapOk;
  final Object? error;
  final bool showModal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const title = '読み込みに失敗しました。';
    const message = '通信環境のいい場所で\n再度読み込みをお試しください。';
    const cancelLabel = '再読み込み';

    final dialog = showDialog<void>(
      context: context,
      builder: (context) => OkCancelAlertDialog(
        title: title,
        message: message,
        cancelLabel: cancelLabel,
        okLabel: 'OK',
        onTapCancel: (context) {
          Navigator.pop(context);
          onTapReload();
        },
        onTapOk: onTapOk ?? Navigator.pop,
      ),
    );

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (error != null && error is AppException) {
          final appException = error! as AppException;

          if (appException.code == unauthorized) {
            ref
                .read(scaffoldMessengerServiceProvider)
                .showExceptionSnackBar(generalUnauthorizedMessage);
            await ref
                .read(sharedPreferencesServiceProvider)
                .deleteAuthCredentials();
            await ref
                .read(navigatorKeyProvider)
                .currentState
                ?.pushAndRemoveUntil(
                  SignInPage.route(),
                  (_) => false,
                );
          }
        }

        if (showModal) {
          await dialog;
        }
      });

      return null;
    });

    return showModal
        ? const SizedBox()
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(20),
                const Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorName.deepGrey,
                    fontSize: 16,
                  ),
                ),
                const Gap(20),
                TextButton(
                  onPressed: onTapReload,
                  child: const Text(
                    cancelLabel,
                    style: TextStyle(
                      color: ColorName.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class ScaffoldErrorPage extends StatelessWidget {
  const ScaffoldErrorPage({
    super.key,
    required this.onTapReload,
    this.onTapOk,
    this.error,
    this.showModal = true,
  });

  final void Function() onTapReload;
  final void Function(BuildContext)? onTapOk;
  final Object? error;
  final bool showModal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorPage(
        onTapReload: onTapReload,
        onTapOk: onTapOk,
        error: error,
        showModal: showModal,
      ),
    );
  }
}
