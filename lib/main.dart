import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/RegisterApp.dart';
import 'package:google_maps_in_flutter/logInApp.dart';
import 'package:google_maps_in_flutter/src/editProfile.dart';
import 'package:google_maps_in_flutter/src/infoShelter_page.dart';
import 'package:google_maps_in_flutter/src/locations.dart' as locations;
import 'package:google_maps_in_flutter/src/map_page.dart';
import 'package:google_maps_in_flutter/src/otherShelterProfile.dart';
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import 'package:google_maps_in_flutter/src/pay_page.dart';
import 'package:google_maps_in_flutter/src/registerShelter.dart';
import 'package:google_maps_in_flutter/src/shelterProfile.dart';
import 'package:google_maps_in_flutter/src/userProfile.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';

import 'devProfile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      initialRoute: Routes.logApp,
      routes: {
        Routes.infoShelterPage: (context) => const infoShelterPageState(),
        Routes.payPage: (context) => const payPageState (),
        Routes.mapPage: (context) => const mapPageState(),
        Routes.registerApp: (context) => const RegisterUser(),
        Routes.logApp: (context) => const LogInApp(),
        Routes.shelterProfile: (context) =>  const ShelterProfileDesign(),
        Routes.editProfile: (context) => EditProfileDesign(),
        Routes.registerShelter: (context) => const RegisterShelter(),
        Routes.devProfile: (context) => const DevProfileDesign(),
        Routes.userProfile: (context) => const UserProfileDesign(),
        Routes.otherShelterProfile: (context) => const OtherShelterProfileDesign(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyAppStateState(),
    );
  }
}

class _MyAppStateState extends StatefulWidget {
   _MyAppStateState({Key? key}) : super(key: key);

  @override
  State<_MyAppStateState> createState() => _MyAppStateStateState();
}

class _MyAppStateStateState extends State<_MyAppStateState> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animalyu'),
          backgroundColor: Colors.green[700],
        ),
      ),
    );
  }


}