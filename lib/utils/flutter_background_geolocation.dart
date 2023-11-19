import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';

final flutterBackgroundGeolocationServiceProvider =
    Provider<FlutterBackgroundGeolocationService>(
  (ref) {
    final fbg = ref.read(flutterBackgroundGeolocationProvider);
    return FlutterBackgroundGeolocationService(ref, fbg);
  },
);

final flutterBackgroundGeolocationProvider =
    Provider<bg.BackgroundGeolocation>((_) => throw UnimplementedError());

class FlutterBackgroundGeolocationService {
  FlutterBackgroundGeolocationService(this.ref, this.backgroundGeolocation);

  final ProviderRef<FlutterBackgroundGeolocationService> ref;
  final bg.BackgroundGeolocation backgroundGeolocation;
  bool isEnterOver = true;

  Future<void> initialize() async {
    await bg.BackgroundGeolocation.ready(
      bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: false,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        reset: true,
        enableHeadless: true,
        foregroundService: true,
      ),
    ).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  Future<bool> addGeofences(List<bg.Geofence> geofences) async {
    try {
      await bg.BackgroundGeolocation.addGeofences(geofences);
      debugPrint('addGeofences success');
      return true;
    } on Exception catch (e) {
      debugPrint('addGeofences failed $e');
      return false;
    }
  }

  Future<void> eventOnGeofence() async {
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      if (event.action == 'ENTER') {
        if (isEnterOver) {
          ref.read(changeGeofenceStatusProvider).call(
                markerId: event.identifier,
              );
          debugPrint('GeofenceEvent: [--ENTER--]$event');
          isEnterOver = false;
        }
      } else if (event.action == 'EXIT') {
        ref.read(changeGeofenceStatusProvider).call(
              markerId: event.identifier,
            );
        debugPrint('GeofenceEvent: [--EXIT--]$event');
        isEnterOver = true;
      }
    });
  }
}
