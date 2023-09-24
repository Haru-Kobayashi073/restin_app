import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/pages/map/components/map_components.dart';
import 'package:search_roof_top_app/widgets/widgets.dart';

class MapPage extends HookConsumerWidget {
  const MapPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MapPage(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late StreamSubscription<Position> positionStream;
    late Position position;

    /// 画面上のGoogleMapを制御
    void onMapCreated(GoogleMapController controller) {
      ref.watch(mapControllerProvider.notifier).state = controller;
    }

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    useEffect(
      () {
        Future(() async {
          /// 位置情報の許可を確認
          final permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            await Geolocator.requestPermission();
          }

          /// 位置情報を格納
          position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );

          /// Providerに位置情報を格納
          ref.watch(currentSpotProvider.notifier).state = LatLng(
            position.latitude,
            position.longitude,
          );
        });

        /// 位置情報の変更を監視
        positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position? position) {
          debugPrint(
            position == null
                ? 'Unknown'
                : '${position.latitude}, ${position.longitude}',
          );
        });
        return positionStream.cancel;
      },
      [],
    );

    final currentSpot = ref.watch(currentSpotProvider);
    final selectedMapType = ref.watch(selectedMapTypeProvider);
    final markers = ref.watch(fetchAllMarkersProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: const TabActionsButton(),
      body: currentSpot == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : markers.when(
              data: (markers) {
                return GoogleMap(
                  onMapCreated: onMapCreated,
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
                  markers: markers.toSet(),
                );
              },
              error: (error, stackTrace) => ErrorPage(
                error: error,
                onTapReload: () => ref.invalidate(fetchAllMarkersProvider),
              ),
              loading: () => const Loading(),
            ),
    );
  }
}
