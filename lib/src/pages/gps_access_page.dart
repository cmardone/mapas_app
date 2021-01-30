import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccessPage extends StatefulWidget {
  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage>
    with WidgetsBindingObserver {
  bool _isPopupOpen = false;

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
    if (state == AppLifecycleState.resumed && !_isPopupOpen) {
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
                _isPopupOpen = true;
                var status = await Permission.location.request();
                await gpsAccess(status);
                _isPopupOpen = false;
              },
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Future gpsAccess(PermissionStatus status) async {
    print(status);
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, '/loading');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();
    }
  }
}
