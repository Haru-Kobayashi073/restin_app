import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Completer<GoogleMapController> mapController = Completer();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: mapController.complete,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: ref.watch(firstSpotProvider.notifier).state,
          zoom: 11,
        ),
      ),
    );
  }
}
