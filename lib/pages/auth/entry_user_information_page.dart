// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/file/file.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

class EntryUserInformationPage extends HookConsumerWidget {
  const EntryUserInformationPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EntryUserInformationPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgInfo = useState<Tuple2<String?, File?>>(const Tuple2(null, null));
    final loading = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'プロフィール画像を選択',
              style: AppTextStyle.authPageTitle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: () async {
                  loading.value = true;
                  imgInfo.value = await ref.read(pickImageAndUploadProvider);
                  loading.value = false;
                },
                child: loading.value == false
                    ? !imgInfo.value.item1.isNull
                        ? CircleAvatar(
                            radius: context.deviceWidth * 0.18,
                            backgroundImage: CachedNetworkImageProvider(
                              imgInfo.value.item1!,
                            ),
                          )
                        : CircleAvatar(
                            radius: context.deviceWidth * 0.18,
                            child: SvgPicture.asset(Assets.icons.picture),
                          )
                    : const CircularProgressIndicator(),
              ),
            ),
            Column(
              children: [
                CommonButton(
                  onPressed: () async {
                    if (imgInfo.value.item1 != null) {
                      await updateUserData(
                        imgInfo: Tuple2(
                          imgInfo.value.item1!,
                          imgInfo.value.item2!,
                        ),
                        ref: ref,
                        context: context,
                      );
                    } else {
                      ScaffoldMessengerService.showSuccessSnackBar(
                        context,
                        'データが足りません。',
                      );
                    }
                  },
                  text: '登録',
                ),
                CommonButton(
                  onPressed: () async {
                    if (imgInfo.value.item1 != null) {
                      await deleteFile(
                        ref: ref,
                        context: context,
                        url: imgInfo.value.item1!,
                      );
                    } else {
                      ScaffoldMessengerService.showSuccessSnackBar(
                        context,
                        '新規登録が完了しました!',
                      );
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MainPage.route(isAuthenticated: true),
                        (route) => false,
                      );
                    }
                  },
                  text: 'スキップ',
                  color: ColorName.mediumGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserData({
    String? userName,
    Tuple2<String, File>? imgInfo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(updateUserDataProvider).call(
          userName: userName,
          imgInfo: imgInfo,
          onSuccess: () async {
            ScaffoldMessengerService.showSuccessSnackBar(
              context,
              '新規登録が完了しました!',
            );
            await Navigator.pushAndRemoveUntil(
              context,
              MainPage.route(),
              (route) => false,
            );
          },
        );
  }

  Future<void> deleteFile({
    required WidgetRef ref,
    required BuildContext context,
    required String url,
  }) async {
    await ref.read(deleteFileProvider).call(
          url: url,
          onSuccess: () async {
            ScaffoldMessengerService.showSuccessSnackBar(
              context,
              '新規登録が完了しました!',
            );
            await Navigator.pushAndRemoveUntil(
              context,
              MainPage.route(),
              (route) => false,
            );
          },
        );
  }
}
