part of 'location_bloc.dart';

@immutable
class LocationState {
  final bool tracking;
  final bool hasLocation;
  final LatLng location;

  LocationState({
    this.tracking = true,
    this.hasLocation = false,
    this.location,
  });

  LocationState copyWith({bool tracking, bool hasLocation, LatLng location}) =>
      LocationState(
          tracking: tracking ?? this.tracking,
          hasLocation: hasLocation ?? this.hasLocation,
          location: location ?? this.location);
}
