// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// GoogleMapControllerを保持
final mapControllerProvider =
    StateProvider<GoogleMapController?>((ref) => null);

/// 現在地の緯度経度を保持
final currentSpotProvider = StateProvider<LatLng?>((ref) => null);

class MapPage extends HookConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Position? currentPosition;
    late GoogleMapController mapController;
    late StreamSubscription<Position> positionStream;

    /// 画面上のGoogleMapを制御
    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
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
          final position = await Geolocator.getCurrentPosition(
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
          currentPosition = position;
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

    return Scaffold(
      body: currentSpot == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              onMapCreated: onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: ref.watch(currentSpotProvider.notifier).state ??
                    const LatLng(
                      35.658034,
                      139.701636,
                    ),
                zoom: 14,
              ),
            ),
    );
  }
}
