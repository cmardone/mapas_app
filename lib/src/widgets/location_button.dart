import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_app/src/bloc/location/location_bloc.dart';
import 'package:mapas_app/src/bloc/map/map_bloc.dart';

class LocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final location = context.read<LocationBloc>().state.location;
            context.read<MapBloc>().moveCamera(location);
          },
        ),
      ),
    );
  }
}
