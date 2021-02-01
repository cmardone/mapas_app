part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isReady;
  final bool drawTrack;
  final Map<String, Polyline> polylines;

  MapState({
    this.isReady = false,
    this.drawTrack = true,
    Map<String, Polyline> polylines,
  }) : polylines = polylines ?? Map();

  MapState copyWith({
    bool isReady,
    bool drawTrack,
    Map<String, Polyline> polylines,
  }) =>
      MapState(
        isReady: isReady ?? this.isReady,
        drawTrack: drawTrack ?? this.drawTrack,
        polylines: polylines ?? this.polylines,
      );
}
