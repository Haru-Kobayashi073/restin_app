import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class SearchResultCard extends HookConsumerWidget {
  const SearchResultCard({
    super.key,
    required this.marker,
    required this.controller,
    required this.removeState,
  });
  final Marker marker;
  final FloatingSearchBarController controller;
  final void Function() removeState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          Assets.icons.marker,
          width: 36,
        ),
        tileColor: ColorName.white,
        title: Text(marker.infoWindow.title ?? ''),
        subtitle: const Text('東京都豊島区南池袋1-28-1'),
        trailing: SvgPicture.asset(
          Assets.icons.rightArrow,
          width: 24,
        ),
        onTap: () {
          final read = ref.read;
          read(
            tappedMarkerPositionProvider.notifier,
          ).state = LatLng(
            marker.position.latitude,
            marker.position.longitude,
          );
          final mapController = read(mapControllerProvider);
          controller.close();
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: read(
                  tappedMarkerPositionProvider.notifier,
                ).state!,
                zoom: 18,
              ),
            ),
          );
          mapController?.showMarkerInfoWindow(
            MarkerId(
              read(
                tappedMarkerPositionProvider.notifier,
              ).state.toString(),
            ),
          );
        },
      ),
    );
  }
}
