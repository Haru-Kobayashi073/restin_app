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
    final userNameController =
        useTextEditingController(text: userData.userName);

    return Scaffold(
      appBar: const HomeAppBar(),
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
                      imgInfo.value =
                          await ref.read(pickImageAndUploadProvider);
                    },
                    child: !imgInfo.value.item1.isNull
                        ? CircleAvatar(
                            radius: context.deviceWidth * 0.18,
                            backgroundImage: CachedNetworkImageProvider(
                              imgInfo.value.item1!,
                            ),
                          )
                        : userData.imageUrl.isNull
                            ? CircleAvatar(
                                radius: context.deviceWidth * 0.18,
                                child: SvgPicture.asset(Assets.icons.picture),
                              )
                            : CircleAvatar(
                                radius: context.deviceWidth * 0.18,
                                backgroundImage: CachedNetworkImageProvider(
                                  userData.imageUrl!,
                                ),
                              ),
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
                await updateUserData(
                  userName: userNameController.text,
                  imgInfo: Tuple2(
                    imgInfo.value.item1.toString(),
                    imgInfo.value.item2,
                  ),
                  ref: ref,
                  context: context,
                );
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
    Tuple2<String?, File?>? imgInfo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final read = ref.read;
    await read(updateUserDataProvider).call(
      userName: userName,
      imgInfo: imgInfo,
      onSuccess: () {
        ref.invalidate(fetchUserDataProvider);
        Navigator.pop(context);
      },
    );
  }
}
