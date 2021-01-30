import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_app/src/bloc/location/location_bloc.dart';
import 'package:mapas_app/src/bloc/map/map_bloc.dart';
import 'package:mapas_app/src/pages/gps_access_page.dart';
import 'package:mapas_app/src/pages/loading_page.dart';
import 'package:mapas_app/src/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MapBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/loading',
        routes: {
          '/map': (_) => MapPage(),
          '/loading': (_) => LoadingPage(),
          '/gps_access': (_) => GpsAccessPage(),
        },
      ),
    );
  }
}
