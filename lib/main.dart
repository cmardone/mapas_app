import 'package:flutter/material.dart';

import 'package:mapas_app/src/pages/gps_access_page.dart';
import 'package:mapas_app/src/pages/loading_page.dart';
import 'package:mapas_app/src/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: {
        '/map': (_) => MapPage(),
        '/loading': (_) => LoadingPage(),
        '/gps_access': (_) => GpsAccessPage(),
      },
    );
  }
}
