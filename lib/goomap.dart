import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/src/app_colors.dart';
import 'package:google_maps_in_flutter/src/locations.dart' as locations;
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import 'package:google_maps_in_flutter/src/transaction_id.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';

class mapPageHelp extends StatefulWidget {
  const mapPageHelp({Key? key}) : super(key: key);

  State<mapPageHelp> createState() => _mapPageHelp();
}

class _mapPageHelp extends State<mapPageHelp> {
  TextEditingController _searchController = new TextEditingController();

  late String address;

  late String id;

  late double lat;

  late double lng;

  late String name;

  late String phone;

  final Map<String, Marker> _markers = {};

  var _controller;

  late final ArgumentCallback<LatLng> onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mapPage,
                (Route<dynamic> route) => false,
              );
            },
          ),
          title: const Text('Rescue an animal!'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: false,
          initialCameraPosition: const CameraPosition(
            target: const LatLng(41.3879, 2.16992),
            zoom: 12,
          ),
          markers: _markers.values.toSet(),
          onTap: _handleTap,
        ),
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[700],
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          onPressed: () {},
          child: const Text('Pedir ayuda'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      final marker = Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'Lugar a marcar',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      );
      _markers["Tap"] = marker;
    });
  }
}
