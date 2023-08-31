import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/map.dart';
import 'package:search_roof_top_app/pages/map/components/cancel_dialog.dart';
import 'package:search_roof_top_app/utils/utils.dart';

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
    final markers = ref.watch(markersProvider.notifier).state;
    final markerIdController = useTextEditingController();
    final detailController = useTextEditingController();
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
                      markers: markers,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: markerIdController,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(detailFocusNode),
                      decoration: InputDecoration(
                        labelText: '地点名',
                        labelStyle: AppTextStyle.createMarkerTextFieldLabel,
                        contentPadding: const EdgeInsets.all(12),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: detailController,
                      focusNode: detailFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: '詳細',
                        labelStyle: AppTextStyle.createMarkerTextFieldLabel,
                        contentPadding: const EdgeInsets.all(12),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: ColorName.mediumGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    onPressed: () {
                      ref.read(markersProvider).remove(marker);
                      final newMarker = Marker(
                        markerId: marker.markerId,
                        position: marker.position,
                        infoWindow: InfoWindow(
                          title: markerIdController.text,
                          snippet: detailController.text,
                        ),
                      );
                      final updatedMarkers = Set<Marker>.from(
                        ref.read(markersProvider.notifier).state,
                      )..add(newMarker);
                      ref.read(markersProvider.notifier).state = updatedMarkers;
                      Navigator.pop(context);
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
