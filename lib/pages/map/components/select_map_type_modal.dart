import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/map.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class SelectMapTypeModal extends ConsumerWidget {
  const SelectMapTypeModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMapType = ref.watch(selectedMapTypeProvider);

    return Container(
      height: context.deviceHeight * 0.9,
      decoration: const BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close_rounded,
                  color: ColorName.darkGrey,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              width: 100,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorName.darkGrey,
                    width: 3,
                  ),
                ),
              ),
              child: const Text(
                '地図の種類',
                style: AppTextStyle.mapTypeModalTitle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(
                              selectedMapTypeProvider.notifier,
                            )
                            .state = MapType.normal;
                      },
                      child: Container(
                        width: context.deviceWidth * 0.3,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedMapType == MapType.normal
                                ? ColorName.amber
                                : ColorName.white,
                            width: 3,
                          ),
                        ),
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: ColorName.white,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                Assets.images.defaultMap.path,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'デフォルト',
                      style: AppTextStyle.mapTypeModalOption,
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(
                              selectedMapTypeProvider.notifier,
                            )
                            .state = MapType.hybrid;
                      },
                      child: Container(
                        width: context.deviceWidth * 0.3,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedMapType == MapType.hybrid
                                ? ColorName.amber
                                : ColorName.white,
                            width: 3,
                          ),
                        ),
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: ColorName.white,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                Assets.images.satelliteMap.path,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      '航空写真',
                      style: AppTextStyle.mapTypeModalOption,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
