import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';

@freezed
class LocationModel with _$LocationModel{
  factory LocationModel({
    required double latitude,
    required double longitude,
    required double speed,
  }) = _LocationModel;
}

@freezed
class LocationProviderState with _$LocationProviderState {
  factory LocationProviderState({
    required List<LocationModel> locations,
    required Timer? timer,
  }) = _LocationProviderState;
}