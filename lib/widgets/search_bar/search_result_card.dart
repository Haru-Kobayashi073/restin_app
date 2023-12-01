import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/models/marker_data.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class SearchResultCard extends HookConsumerWidget {
  const SearchResultCard({
    super.key,
    required this.markerData,
    required this.controller,
    required this.removeState,
  });
  final MarkerData markerData;
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
        title: Text(markerData.title),
        subtitle: Text(
          markerData.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: SvgPicture.asset(
          Assets.icons.rightArrow,
          width: 24,
        ),
        onTap: () {
          final read = ref.read;
          read(
            tappedMarkerPositionProvider.notifier,
          ).state = LatLng(
            markerData.latitude,
            markerData.longitude,
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
            MarkerId(markerData.markerId),
          );
          read(showModalProvider).call(markerData: markerData);
        },
      ),
    );
  }
}
