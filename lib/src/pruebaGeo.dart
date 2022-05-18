import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static String lat = "";
  static String long = "";

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    location();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text(lat + "  " + long),
          ),
        ),
      ),
    );
  }



 static void location() async {
    List<Location> locations =
        await locationFromAddress("Gronausestraat 710, Enschede");
    lat = locations.first.latitude.toString();
    long = locations.first.longitude.toString();
  }
}
