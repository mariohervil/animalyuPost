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
  TextEditingController _searchController = new TextEditingController();

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
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildDrawerHeader(),
              _buildDrawerItem(icon: Icons.account_circle, text: 'Profile', onTap: () => {
                Navigator.pushNamedAndRemoveUntil(
                  context, Routes.userProfile, (Route<dynamic> route) => false,
                )
              }),
              _buildDrawerItem(icon: Icons.map_rounded, text: 'Localize an animal', onTap: () => {
                Navigator.pushNamedAndRemoveUntil(
                  context, Routes.devProfile, (Route<dynamic> route) => false,
                )
              }),
              _buildDrawerItem(icon: Icons.contact_phone, text: 'Contact Info', onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
              context, Routes.devProfile, (Route<dynamic> route) => false,
              )}),
              _buildDrawerItem(icon: Icons.payment, text: 'Donate to our team ', onTap: () => {
                Navigator.pushNamedAndRemoveUntil(
                  context, Routes.payPage, (Route<dynamic> route) => false,
                )}),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 300, 10, 0),
                // child: Text("Log In Screen"),
              ),
              _buildDrawerItem(icon: Icons.logout, text: 'Log Out', onTap: () => {
                Navigator.pushNamedAndRemoveUntil(
                  context, Routes.logApp, (Route<dynamic> route) => false,
                )}),
              ListTile(
                title: const Text('App version 1.0.0'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:  const CameraPosition(
            target: const LatLng(41.3879, 2.16992),
            zoom: 12,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
        margin: const EdgeInsets.only(top: 10, left: 0, right: 0,bottom: 40),
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('assets/animalyuLogo.jpg')
            )),
        child: Stack(children: <Widget>[
          const Positioned(
              bottom: 20.0,
              left: 20.0,
              child: Text("Animal yu",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _buildDrawerItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
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
                    Routes.shelterProfile,
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


