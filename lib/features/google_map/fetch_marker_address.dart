import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/repositories/marker/marker_repository_impl.dart';
import 'package:search_roof_top_app/utils/utils.dart';

final fetchMarkerAddressProvider =
    Provider<Future<String> Function({required LatLng latLng})>(
  (ref) => ({required latLng}) async {
    final read = ref.read;
    final isNetworkCheck = await isNetworkConnected();
    try {
      final response = await read(markerRepositoryImplProvider)
          .fetchMarkerAddress(latLng: latLng);
      return response;
    } on Exception catch (e) {
      if (!isNetworkCheck) {
        const exception = AppException(
          message: 'Maybe your network is disconnected. Please check yours.',
        );
        throw exception;
      }
      read(scaffoldMessengerServiceProvider)
          .showExceptionSnackBar(e.toString());
      rethrow;
    }
  },
);
