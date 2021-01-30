part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isReady;

  MapState({
    this.isReady = false,
  });

  MapState copyWith({bool isReady}) =>
      MapState(isReady: isReady ?? this.isReady);
}
