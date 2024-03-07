import 'dart:developer';

import 'package:geolocator/geolocator.dart';

Future<bool> isLocationEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

Future<bool> requestLocationPermission() async {
  var permission = await Geolocator.checkPermission();
  bool isPermissionGranted = true;

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      log('Location permission denied');
      isPermissionGranted = false;
    } else {
      log('Location permission granted');
    }
  } else {
    log('Location permission already granted');
  }

  if (permission == LocationPermission.deniedForever) {
    log('Location denied forever');
    isPermissionGranted = false;
  }

  return isPermissionGranted;
}
