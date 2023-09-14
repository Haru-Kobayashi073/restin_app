import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/file/file.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class EntryUserInformationPage extends HookConsumerWidget {
  const EntryUserInformationPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EntryUserInformationPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = useState<File?>(null);
    final profileImage = useState<Image?>(null);
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
                  file.value = await pickImageAndUpload(ref: ref);
                  final image = await ref.read(getDownloadUrlProvider);
                  profileImage.value = image;
                  loading.value = false;
                },
                child: loading.value == false
                    ? profileImage.value != null
                        ? CircleAvatar(
                            radius: context.deviceWidth * 0.18,
                            backgroundImage: profileImage.value!.image,
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
                    await updateUserData(
                      file: file.value,
                      ref: ref,
                      context: context,
                    );
                  },
                  text: '登録',
                ),
                CommonButton(
                  onPressed: () async {
                    if (profileImage.value != null) {
                      await deleteFile(
                        ref: ref,
                        context: context,
                      );
                    } else {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MainPage.route(),
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

  Future<File?> pickImageAndUpload({
    required WidgetRef ref,
  }) async {
    final file = await ref.read(pickImageAndUploadProvider);
    return file;
  }

  Future<void> updateUserData({
    required File? file,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(updateUserDataProvider).call(
          file: file,
          onSuccess: () async {
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
  }) async {
    await ref.read(deleteFileProvider).call(
      onSuccess: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MainPage.route(),
          (route) => false,
        );
      },
    );
  }
}
