import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mapas_app/src/helpers/helpers.dart';
import 'package:mapas_app/src/pages/map_page.dart';
import 'package:mapas_app/src/pages/gps_access_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final isGpsActive = await Geolocator.isLocationServiceEnabled();
      if (isGpsActive) {
        Navigator.pushReplacement(
            context, mapNavigationFadeIn(context, MapPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLocationAndGps(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(snapshot.data),
              );
            }
            return Center(
              child: CircularProgressIndicator(strokeWidth: 3),
            );
          }),
    );
  }

  Future checkLocationAndGps(BuildContext context) async {
    // Check GPS permission
    final hasGpsPermission = await Permission.location.isGranted;
    // Check active GPS
    final isGpsActive = await Geolocator.isLocationServiceEnabled();
    if (hasGpsPermission && isGpsActive) {
      Navigator.pushReplacement(
          context, mapNavigationFadeIn(context, MapPage()));
      return '';
    } else if (!hasGpsPermission) {
      Navigator.pushReplacement(
        context,
        mapNavigationFadeIn(context, GpsAccessPage()),
      );
      return 'Grant GPS permissions';
    } else {
      return 'Active GPS access';
    }
  }
}
