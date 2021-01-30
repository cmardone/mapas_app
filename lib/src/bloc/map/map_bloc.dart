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

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(isReady: true);
    }
  }

  void initMap(GoogleMapController controller) {
    if (!state.isReady) {
      _controller = controller;
      _controller.setMapStyle(mapStyle);
      // TODO: Cambiar estilo del mapa
      add(OnMapReady());
    }
  }

  Future moveCamera(LatLng location) async {
    _controller?.animateCamera(CameraUpdate.newLatLng(location));
  }
}
