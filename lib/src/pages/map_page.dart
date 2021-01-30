import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas_app/src/bloc/location/location_bloc.dart';
import 'package:mapas_app/src/bloc/map/map_bloc.dart';
import 'package:mapas_app/src/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    print('startTracking');
    context.read<LocationBloc>().startTracking();
    super.initState();
  }

  @override
  void dispose() {
    print('stopTracking');
    context.read<LocationBloc>().stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) => createMap(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [LocationButton()],
      ),
    );
  }

  Widget createMap(LocationState state) {
    if (!state.hasLocation) return Center(child: Text('Locating...'));
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: state.location, zoom: 14),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: context.read<MapBloc>().initMap,
    );
  }
}
