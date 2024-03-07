import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_tracer_app/model/location_model.dart';

part 'location_provider_state.freezed.dart';

@freezed
class LocationProviderState with _$LocationProviderState {
  factory LocationProviderState({
    required List<LocationModel> locations,
    required Timer? timer,
  }) = _LocationProviderState;
}