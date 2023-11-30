import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_roof_top_app/features/google_map/google_map.dart';
import 'package:search_roof_top_app/utils/utils.dart';

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
    );

    await bg.BackgroundGeolocation.start().then((value) async {
      logger.i('BackgroundGeolocation started');
    }).catchError((dynamic error) async {
      logger.e('BackgroundGeolocation error: $error');
    });

    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) async {
      logger.d('GeofenceEvent: catch the event: $event');
      await eventOnGeofence(event);
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

  Future<void> eventOnGeofence(bg.GeofenceEvent event) async {
    final isUsed = await ref
        .read(fetchGeofenceStatusProvider)
        .call(markerId: event.identifier);
    if (event.action == 'ENTER') {
      if (!isUsed) {
        await ref.read(changeGeofenceStatusProvider).call(
              markerId: event.identifier,
            );
        logger.d('GeofenceEvent: [--ENTER--]$event');
      }
    } else if (event.action == 'EXIT') {
      await ref.read(changeGeofenceStatusProvider).call(
            markerId: event.identifier,
          );
      logger.d('GeofenceEvent: [--EXIT--]$event');
    }
  }
}
