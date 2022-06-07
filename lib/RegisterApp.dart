import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

import 'main.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  TextEditingController uNController = TextEditingController();
  TextEditingController uPController = TextEditingController();
  TextEditingController uEController = TextEditingController();
  TextEditingController uPhController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color color = HexColor.fromHex('#D3D3D3');
    return MaterialApp(
      theme: ThemeData(
          snackBarTheme: const SnackBarThemeData(
              contentTextStyle:
                  TextStyle(fontFamily: "Rubik-Light", fontSize: 21))),
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 200,
          backgroundColor:Colors.white,
          title: SvgPicture.asset(
            'assets/animalyuLogo.svg',
            width: 300,
            height: 300,
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
              // child: Text("Log In Screen"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                style: const TextStyle(fontSize: 16),
                controller: uNController,
                decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                   ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                style: const TextStyle(fontSize: 16),
                controller: uPController,
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                 ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                style: const TextStyle(fontSize: 16),
                controller: uEController,
                decoration: InputDecoration(
                    labelText: 'Email',
                 ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                style: const TextStyle(fontSize: 16),
                controller: uPhController,
                decoration: InputDecoration(
                    labelText: 'Teléfono',
               ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18)),
                onPressed: postData,
                child: const Text("Registrar"),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<http.Response> makePostRequest(
      String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    checkLogin(response.body);

    return response;
  }

  void checkLogin(String response) {
    //print(response);
    if (response == "1") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Registrado correctamente'),
          backgroundColor: Colors.green));
      _Login();

    } else {
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Registration failed'), backgroundColor: Colors.red));
    }
  }

  void postData() async {
    String username = uNController.text;
    String password = uPController.text;
    String email = uEController.text;
    String phone = uPhController.text;

    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    locations.first.latitude;
    locations.first.longitude;


    //print(username+ password + email+ phone);
    try {
      if (username == "" && password == "") {
        _messengerKey.currentState?.showSnackBar(const SnackBar(
            content: Text('Campos vacíos'), backgroundColor: Colors.red));
      } else if (username == "") {
        throw Exception("Usuario vacío");
      } else {
        Map<String, String> loginBody = {
          'mode': 'register',
          'username': username,
          'password': password,
          'email': email,
          'phone': phone
        };
        makePostRequest(url, loginBody);
      }
    } on Exception catch (e) {
      _messengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(e.toString().replaceAll("Exception:", "")),
          backgroundColor: Colors.red));
    }
  }
  Future<void> _Login() async {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.logApp, (Route<dynamic> route) => false,
        );
  }
}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
