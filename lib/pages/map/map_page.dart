import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mapControllerProvider =
    StateProvider<GoogleMapController?>((ref) => null);

final firstSpotProvider = StateProvider<LatLng>(
  (ref) => const LatLng(
    35.658034,
    139.701636,
  ),
);

class MapPage extends HookConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onMapCreated(GoogleMapController controller) {
      ref.watch(mapControllerProvider.notifier).state = controller;
    }

    return Scaffold(
      body: GoogleMap(
        onMapCreated: onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: ref.watch(firstSpotProvider.notifier).state,
          zoom: 11,
        ),
      ),
    );
  }
}
