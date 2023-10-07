import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/file/file.dart';
import 'package:search_roof_top_app/features/user/user.dart';
import 'package:search_roof_top_app/models/user_data.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key, required this.userData});
  final UserData userData;

  static Route<dynamic> route({required UserData userData}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => EditProfilePage(userData: userData),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imgInfo = useState<Tuple2<String?, File?>>(const Tuple2(null, null));
    final loading = useState<bool>(false);
    final userNameController = useTextEditingController(
      text: userData.userName,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorName.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: GestureDetector(
                    onTap: () async {
                      loading.value = true;
                      imgInfo.value =
                          await ref.read(pickImageAndUploadProvider);
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
                            : userData.imageUrl!.isEmpty
                                ? CircleAvatar(
                                    radius: context.deviceWidth * 0.18,
                                    child:
                                        SvgPicture.asset(Assets.icons.picture),
                                  )
                                : CircleAvatar(
                                    radius: context.deviceWidth * 0.18,
                                    backgroundImage: CachedNetworkImageProvider(
                                      userData.imageUrl!,
                                    ),
                                  )
                        : const CircularProgressIndicator(),
                  ),
                ),
                CommonTextField(
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  labelText: 'ユーザーネーム',
                ),
              ],
            ),
            CommonButton(
              onPressed: () async {
                if (imgInfo.value.item1 != null ||
                    userNameController.text.isNotEmpty) {
                  await updateUserData(
                    userName: userNameController.text,
                    imgInfo: Tuple2(
                      imgInfo.value.item1!,
                      imgInfo.value.item2!,
                    ),
                    ref: ref,
                    context: context,
                  );
                  ref.invalidate(fetchUserDataProvider);
                } else {
                  ScaffoldMessengerService.showSuccessSnackBar(
                    context,
                    'データが足りません。',
                  );
                }
              },
              text: '保存',
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
              '更新が完了しました!',
            );
            Navigator.pop(context);
          },
        );
  }
}
