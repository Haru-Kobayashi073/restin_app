import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/auth/auth.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/pages/map/add_marker_option_page.dart';
import 'package:search_roof_top_app/utils/utils.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class CreateMarkerDialog extends HookConsumerWidget {
  const CreateMarkerDialog({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const CreateMarkerDialog(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setMarkerPosition(LatLng latLng) {
      debugPrint('marker$latLng');
      final markerId = returnUuidV4();
      final marker = Marker(
        markerId: MarkerId(markerId),
        position: latLng,
      );
      Navigator.push(
        context,
        AddMarkerOptionPage.route(marker),
      );
      ref.read(markersProvider.notifier).state.add(marker);
    }

    final isAuthenticated = ref.read(isAuthenticatedProvider);
    final selectedMapType = ref.watch(selectedMapTypeProvider);
    final markers = ref.watch(fetchAllMarkersProvider(context));
    final tappedPosition = useState<LatLng?>(null);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (isAuthenticated) {
          return;
        } else {
          showDialog<void>(
            context: context,
            builder: (_) {
              return const SignInDialog(isTwicePop: true);
            },
          );
        }
        return;
      },
    );

    return Scaffold(
      appBar: const HomeAppBar(text: '地点を選択してください'),
      body: markers.when(
        data: (markers) {
          return GoogleMap(
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
            onTap: (latLng) => setMarkerPosition(tappedPosition.value = latLng),
            markers: markers.toSet(),
          );
        },
        error: (error, stackTrace) => ErrorPage(
          error: error,
          onTapReload: () => ref.invalidate(fetchAllMarkersProvider),
        ),
        loading: () => const SizedBox(),
      ),
    );
  }
}
