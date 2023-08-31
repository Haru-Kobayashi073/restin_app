import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/map.dart';
import 'package:search_roof_top_app/pages/map/add_marker_option_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class CreateMarkerDialog extends HookConsumerWidget {
  const CreateMarkerDialog({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const CreateMarkerDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool createMarker(LatLng latLng) {
      debugPrint('marker$latLng');
      final marker = Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      );
      Navigator.push(
        context,
        AddMarkerOptionPage.route(marker),
      );
      return ref.read(markersProvider.notifier).state.add(marker);
    }

    final selectedMapType = ref.watch(selectedMapTypeProvider);
    final markers = ref.watch(markersProvider.notifier).state;
    final tappedPosition = useState<LatLng?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '地点を選択してください',
          style: AppTextStyle.mapTypeModalTitle,
        ),
        elevation: 0,
        backgroundColor: ColorName.white,
      ),
      body: GoogleMap(
        mapType: selectedMapType,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: ref.watch(currentSpotProvider) ??
              const LatLng(
                35.658034,
                139.701636,
              ),
          zoom: 14,
        ),
        onTap: (LatLng latLang) {
          createMarker(tappedPosition.value = latLang);
        },
        markers: markers.toSet(),
      ),
    );
  }
}
