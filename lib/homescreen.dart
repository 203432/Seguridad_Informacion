import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trust_location/trust_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? latitude;
  String? longitude;
  bool? isMock;
  bool showText = false;

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void getLocation() async {
    try {
      TrustLocation.onChange.listen((result) {
        setState(() {
          latitude = result.latitude;
          longitude = result.longitude;
          isMock = result.isMockLocation;
          showText = true;
        });
      });
    } catch (e) {
      print('error');
    }
  }

  void geoCode() async{
    
  }

  void requestPermission() async {
    final permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      TrustLocation.start(10);
      getLocation();
    } else if (permission == PermissionStatus.denied) {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(showText
            ? 'Lat: $latitude\nLon: $longitude\nMock Location: $isMock '
            : ''),
      ),
    );
  }
}
