import 'dart:io';
import 'package:google_maps_in_flutter/src/locations.dart' as locations;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import 'package:google_maps_in_flutter/src/registerShelter.dart';
import 'package:google_maps_in_flutter/src/transaction_id.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

import 'RegisterApp.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Your title',
    home: LogInApp(),
  ));
}

class LogInApp extends StatefulWidget {
  const LogInApp({Key? key}) : super(key: key);

  @override
  _LogInAppState createState() => _LogInAppState();
}

class _LogInAppState extends State<LogInApp> {
  late String address;
  late String id;
  late double lat;
  late double lng;
  late String name;
  late String phone;
  late SuccessfulTransactionParameters transactionArguments;
  FocusNode myFocusNode = new FocusNode();
  late bool _passwordVisible = false;
  static String username = "";
  static String password = "";
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  TextEditingController uNController = TextEditingController();
  TextEditingController uPController = TextEditingController();

  // FIXME AQUI SE EDITA LO QUE SE ENVIA A LA BASE DE DATOS -> 'lo que encontrará el php':'el valor'
  final Map<String, String> registerBody = {
    'mode': 'register',
    'username': 'animalyu',
    'password': 'Monlau2022@',
    'email': 'admin@gmail.com',
    'phone': '93374638'
  };
  final Map<String, String> loginBody = {
    'mode': 'login',
    'username': username,
    'password': password
  };

  Future<http.Response> makePostRequest(
      String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    var array = response.body.split(",");

    print("ssaaaaaaaaaaaaaaass $array");
    checkLogin(array[0], array[1]);

    return response;
  }

  void postData() async {
    username = uNController.text;
    password = uPController.text;
    try {
      if (username == "" && password == "") {
        _messengerKey.currentState?.showSnackBar(const SnackBar(
            content: Text('Ambos campos vacíos'), backgroundColor: Colors.red));
      } else if (username == "") {
        throw Exception("Usuario vacío");
      } else {
        Map<String, String> loginBody = {
          'mode': 'login',
          'username': username,
          'password': password
        };
        makePostRequest(url, loginBody);
      }
    } on Exception catch (e) {
      String e2 = e.toString().replaceAll("Exception: ", "");
      _messengerKey.currentState?.showSnackBar(
          SnackBar(content: Text(e2), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Color color = HexColor.fromHex('#D3D3D3');

    return MaterialApp(
        theme: ThemeData(
            snackBarTheme: const SnackBarThemeData(
                contentTextStyle:
                    TextStyle(fontFamily: "Rubik-Light", fontSize: 20))),
        scaffoldMessengerKey: _messengerKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            //hacer que el botón no desaparezca con el teclado
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 300,
              backgroundColor: Colors.brown,
              title: SvgPicture.asset(
                'assets/animalyuLogo.svg',
                width: 300,
                height: 300,
              ),
              centerTitle: true,
            ),
            body: Container(
              decoration: const BoxDecoration(
                color: Colors.brown,
              ),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 8.0),
                  child: Text(
                    "",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  focusNode: myFocusNode,
                  controller: uNController,
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.alternate_email, color: Colors.black),
                    hintText: "Email",
                    //color cuando se selecciona
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: uPController,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.black),
                    hintText: "Contraseña",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                ),
                GestureDetector(
                  onTap: () {
                    postData();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: const Text(
                        "Iniciar sesión",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                ),
                TextButton(
                  child: const Text("No tienes una cuenta? Regístrate aquí"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterUser()),
                    );
                  },
                ),
                TextButton(
                  child:
                      const Text("Eres un centro de acogida? Regístrate aquí"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterShelter()),
                    );
                  },
                ),
              ]),
            )));
  }

  Future<void> _MapPage() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.mapPage,
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _toShelterProfile() async {}

  void checkLogin(String response, String id) {
    //print(response);
    if (response == "1") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Inicio de sesión correcto'),
          backgroundColor: Colors.green));
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.mapPage, (Route<dynamic> route) => false,
          arguments: TransactionID(id));

     // _MapPage();
    }
    if (response == "2") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Inicio de sesión correcto'),
          backgroundColor: Colors.green));
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.shelterProfile, (Route<dynamic> route) => false,
          arguments: TransactionID(id));
    } else {
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Nombre de usuario o contraseña incorrectos'),
          backgroundColor: Colors.red));
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterUser()));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
