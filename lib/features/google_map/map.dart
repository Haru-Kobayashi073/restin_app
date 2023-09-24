import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// GoogleMapControllerを保持
final mapControllerProvider =
    StateProvider<GoogleMapController?>((ref) => null);

/// 現在地の緯度経度を保持
final currentSpotProvider = StateProvider<LatLng?>((ref) => null);

final selectedMapTypeProvider = StateProvider<MapType>((ref) => MapType.normal);

// final tappedMarkerProvider = StateProvider<List<Marker>>((ref) => []);

final markersProvider = StateProvider<List<Marker>>((ref) => []);

final allMarkersProvider = StateProvider.autoDispose<List<Marker>>((ref) => []);

final tappedMarkerPositionProvider = StateProvider<LatLng?>((ref) => null);
