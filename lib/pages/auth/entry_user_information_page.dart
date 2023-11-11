import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/file/file.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/pages/auth/components/auth_components.dart';
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
    final userNameController = useTextEditingController();
    final imgInfo = useState<Tuple2<String?, File?>>(const Tuple2(null, null));
    final loading = useState<bool>(false);

    return AuthPageWrapper(
      canPop: false,
      authContent: AuthContent.entryInformation,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () async {
              loading.value = true;
              imgInfo.value = await ref.read(pickImageAndUploadProvider);
              loading.value = false;
            },
            child: loading.value == false
                ? !imgInfo.value.item1.isNull
                    ? CircleAvatar(
                        radius: context.deviceWidth * 0.14,
                        backgroundImage: CachedNetworkImageProvider(
                          imgInfo.value.item1!,
                        ),
                      )
                    : CircleAvatar(
                        radius: context.deviceWidth * 0.14,
                        child: SvgPicture.asset(Assets.icons.picture),
                      )
                : Container(
                    padding: const EdgeInsets.all(32),
                    width: context.deviceWidth * 0.28,
                    height: context.deviceWidth * 0.28,
                    child: const CircularProgressIndicator(),
                  ),
          ),
        ),
        CommonTextField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          labelText: 'ユーザーネーム',
        ),
        const SizedBox(height: 16),
        CommonButton(
          onPressed: () async {
            if (imgInfo.value.item1 != null ||
                userNameController.text.isNotEmpty) {
              await createUserData(
                userName: userNameController.text,
                imgInfo: Tuple2(
                  imgInfo.value.item1,
                  imgInfo.value.item2,
                ),
                ref: ref,
                context: context,
              );
            } else if (imgInfo.value.item1 == null ||
                userNameController.text.isEmpty) {
              ref.read(scaffoldMessengerServiceProvider).showSuccessSnackBar(
                    '情報を入力またはスキップしてください',
                  );
            }
          },
          text: '登録',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: CommonButton(
            onPressed: () async {
              await createUserData(
                ref: ref,
                context: context,
              );
              if (imgInfo.value.item1 != null) {
                await ref
                    .read(deleteFileProvider)
                    .call(url: imgInfo.value.item1!);
              }
            },
            text: 'スキップ',
            color: ColorName.white,
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'スキップをしても後から登録できます。',
            style: AppTextStyle.greyText,
          ),
        ),
      ],
    );
  }

  Future<void> createUserData({
    String? userName,
    Tuple2<String?, File?>? imgInfo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(createUserDataProvider).call(
          userName: userName,
          imgInfo: imgInfo,
          onSuccess: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              MainPage.route(isAuthenticated: true),
              (route) => false,
            );
          },
        );
  }
}
