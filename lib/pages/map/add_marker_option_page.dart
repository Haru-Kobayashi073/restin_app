import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/pages/home/main_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

import 'components/map_components.dart';

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
    final createMarker = ref.read(createMarkerProvider);
    final markers = ref.watch(markersProvider.notifier).state;
    final markerTitleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final detailFocusNode = useFocusNode();

    return WillPopScope(
      onWillPop: () async {
        final cancel = await showDialog<bool>(
          context: context,
          builder: (_) => const CancelDialog(),
        );
        if (cancel == true) {
          ref.read(markersProvider).remove(marker);
        }
        return cancel ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorName.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
                      markers: markers.toSet(),
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
                    autofocus: true,
                    labelText: '地点名',
                  ),
                ),
                CommonTextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  focusNode: detailFocusNode,
                  labelText: '詳細',
                ),
                const SizedBox(height: 300),
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
                      ref.read(markersProvider).remove(marker);
                      final newMarker = Marker(
                        markerId: marker.markerId,
                        position: marker.position,
                        infoWindow: InfoWindow(
                          title: markerTitleController.text,
                          snippet: descriptionController.text,
                        ),
                      );
                      ref.read(markersProvider.notifier).state.add(newMarker);
                      await createMarker.call(
                        marker: newMarker,
                        onSuccess: () {
                          ref.invalidate(fetchAllMarkersProvider);
                          ScaffoldMessengerService.showSuccessSnackBar(
                            context,
                            'マーカーが追加されました!',
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MainPage.route(),
                            (route) => false,
                          );
                        },
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
    );
  }
}
