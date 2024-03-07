import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:location_tracer_app/controller/providers/location_provider_state.dart';
import 'package:location_tracer_app/model/location_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_provider.g.dart';

@riverpod
class Location extends _$Location{

  @override
  LocationProviderState build(){
    return LocationProviderState(locations: [], timer: null);
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<void> startLocationTracing() async {
    if (state.timer != null) {
      return;
    }

    ///Updating location in each 30 seconds
    final timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      final newLocation = await getLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('latitude', newLocation.latitude);
      prefs.setDouble('longitude', newLocation.longitude);
      state = state.copyWith(
        locations: [
          ...state.locations,
          LocationModel(
            latitude: newLocation.latitude,
            longitude: newLocation.longitude,
            speed: newLocation.speed,
          )
        ],
      );

      log(state.locations.toString());
    });
    state = state.copyWith(timer: timer);
  }

  void stopLocationTracing() {
    if (state.timer != null) {
      state.timer!.cancel();
      state = state.copyWith(timer: null);
    }
  }
}