import 'package:location_tracer_app/controller/providers/location_provider_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@riverpod
class Location extends _$Location{

  @override
  LocationProviderState build(){
    return LocationProviderState(locations: [], timer: null);
  }
}