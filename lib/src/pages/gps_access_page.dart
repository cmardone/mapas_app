import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccessPage extends StatefulWidget {
  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage>
    with WidgetsBindingObserver {
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

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted)
        Navigator.pushReplacementNamed(context, '/loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('GPS access must be activated to use this app.'),
            MaterialButton(
              child:
                  Text('Request access', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              elevation: 1,
              onPressed: () async {
                // TODO: Validate permissions
                var status = await Permission.location.request();
                gpsAccess(status);
              },
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  void gpsAccess(PermissionStatus status) {
    print(status);
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, '/map');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();
    }
  }
}
