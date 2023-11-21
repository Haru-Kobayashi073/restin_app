import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/file/file.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

class AddMarkerOptionPage extends HookConsumerWidget {
  const AddMarkerOptionPage({
    super.key,
    required this.marker,
  });
  final Marker marker;

  static Route<dynamic> route(Marker marker) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => AddMarkerOptionPage(marker: marker),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMapType = ref.watch(selectedMapTypeProvider);
    final markerTitleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final detailFocusNode = useFocusNode();
    final formKey = useFormStateKey();
    final imgInfo = useState<Tuple2<String?, File?>>(const Tuple2(null, null));

    return PopScope(
      canPop: false, // 戻るキーの動作で戻ることを一旦防ぐ
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final cancel = await showDialog<bool>(
          context: context,
          builder: (_) => CommonDialog(
            title: 'キャンセルしますか？\n入力した内容は保存されません。',
            cancelText: 'キャンセル',
            okText: 'はい',
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pop();
            },
          ),
        );
        if (cancel == true) {
          ref.read(markersProvider).remove(marker);
        }
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: context.deviceHeight - context.deviceHeight * 0.8,
                      child: GoogleMap(
                        mapType: selectedMapType,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: marker.position,
                          zoom: 16,
                        ),
                        markers: ref.watch(markersProvider).toSet(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CommonTextField(
                      controller: markerTitleController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(detailFocusNode),
                      validator: Validator.common,
                      autofocus: true,
                      labelText: '地点名',
                    ),
                  ),
                  CommonTextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    focusNode: detailFocusNode,
                    validator: Validator.common,
                    labelText: '詳細',
                  ),
                  imgInfo.value.item1 == null
                      ? GestureDetector(
                          onTap: () async {
                            imgInfo.value =
                                await ref.read(pickImageAndUploadProvider);
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(0, 16, 10, 10),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorName.mediumGrey,
                                  image: !imgInfo.value.item1.isNull
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            imgInfo.value.item1!,
                                          ),
                                        )
                                      : null,
                                ),
                                child: imgInfo.value.item1.isNull
                                    ? Center(
                                        child: SvgPicture.asset(
                                          Assets.icons.picture,
                                          width: 32,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              imgInfo.value.item1.isNull
                                  ? Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: ColorName.amber,
                                          shape: BoxShape.circle,
                                        ),
                                        child:
                                            SvgPicture.asset(Assets.icons.add),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(0, 16, 10, 10),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorName.mediumGrey,
                            image: !imgInfo.value.item1.isNull
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      imgInfo.value.item1!,
                                    ),
                                  )
                                : null,
                          ),
                          child: imgInfo.value.item1.isNull
                              ? Center(
                                  child: SvgPicture.asset(
                                    Assets.icons.picture,
                                    width: 32,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorName.amber,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await showDialog<void>(
                          context: context,
                          builder: (_) => CommonDialog(
                            title: '作成されたマーカーは全てのユーザーが閲覧することができます。',
                            cancelText: 'キャンセル',
                            okText: '確認',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                ref.read(markersProvider).remove(marker);
                                final newMarker = Marker(
                                  markerId: marker.markerId,
                                  position: marker.position,
                                  infoWindow: InfoWindow(
                                    title: markerTitleController.text,
                                    snippet: descriptionController.text,
                                  ),
                                );
                                ref
                                    .read(markersProvider.notifier)
                                    .state
                                    .add(newMarker);
                                if (!context.mounted) {
                                  return;
                                }
                                await createMarker(
                                  marker: newMarker,
                                  imgInfo: imgInfo.value,
                                  ref: ref,
                                  context: context,
                                );
                              }
                            },
                          ),
                        );
                      },
                      child: const Text(
                        '保存',
                        style: AppTextStyle.saveMarkerText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createMarker({
    required Marker marker,
    Tuple2<String?, File?>? imgInfo,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    await ref.read(createMarkerProvider).call(
          marker: marker,
          imageUrl: imgInfo?.item1 ?? '',
          onSuccess: () {
            ref.invalidate(fetchAllMarkersProvider);
            Navigator.pushAndRemoveUntil(
              context,
              MainPage.route(),
              (route) => false,
            );
          },
        );
  }
}
