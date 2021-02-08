import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:mapas_app/src/themes/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _controller;

  Polyline _myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 3,
  );

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(isReady: true);
    } else if (event is OnLocationUpdate) {
      final points = [
        ..._myRoute.points,
        event.location,
      ];
      _myRoute = _myRoute.copyWith(pointsParam: points);
      final polylines = state.polylines;
      polylines['my_route'] = _myRoute;
      yield state.copyWith(polylines: polylines);

      // final polylines = state?.polylines ?? Map<String, Polyline>();
      // if (!polylines.containsKey('my_track'))
      //   polylines['my_track'] = Polyline(
      //     polylineId: PolylineId(event.location.toString()),
      //     points: [],
      //   );
      // polylines['my_track'].points.add(event.location);
      // print(event.location);
      // state.copyWith(polylines: polylines);
    }
  }

  void initMap(GoogleMapController controller) {
    if (!state.isReady) {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
      add(OnMapReady());
    }
  }

  Future moveCamera(LatLng location) async {
    await _controller?.animateCamera(CameraUpdate.newLatLng(location));
  }
}
