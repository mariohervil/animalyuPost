import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/src/locations.dart' as locations;
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';



class mapPageState extends StatefulWidget {
  const mapPageState({Key? key}) : super(key: key);

  State<mapPageState> createState() => _mapPageState();
}

class _mapPageState extends State<mapPageState> {
  late String address;

  late String id;

  late double lat;

  late double lng;

  late String name;

  late String phone;

  final Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animalyu'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:  CameraPosition(
            target: LatLng(41.3879, 2.16992),
            zoom: 12,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (locations.Office office in googleOffices.offices) {
        address = office.address;
        id = office.id;
        lat= office.lat;
        lng= office.lng;
        name = office.name;
        phone = office.phone;
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
              title: office.name,
              snippet: office.address,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.shelterPage,
                        (Route<dynamic> route) => false,
                    arguments: SuccessfulTransactionParameters(
                        office.address, office.id, office.lat,office.lng,office.name, office.phone));

              }
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }
}


