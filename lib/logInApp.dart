import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/src/registerShelter.dart';
import 'package:google_maps_in_flutter/util/page_directory.dart';
import 'package:http/http.dart' as http;

import 'RegisterApp.dart';

void main(){runApp(const MaterialApp(
  title: 'Your title',
  home: LogInApp(),));}

class LogInApp extends StatefulWidget {
  const LogInApp({Key? key}) : super(key: key);

  @override
  _LogInAppState createState() => _LogInAppState();
}

class _LogInAppState extends State<LogInApp> {

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
    checkLogin(response.body);

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
  Future<void> _MapPage() async {
    Navigator.pushNamedAndRemoveUntil(
      context, Routes.mapPage, (Route<dynamic> route) => false,
    );
  }
  void checkLogin(String response) {
    //print(response);
    if (response == "1") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Inicio de sesión correcto'), backgroundColor: Colors.green));
      _MapPage();


    } else {
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Nombre de usuario o contraseña incorrectos'),
          backgroundColor: Colors.red));
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
        body: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(60, 50, 0, 0),
                  // child: Text("Log In Screen"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    controller: uNController,
                    decoration: InputDecoration(
                        labelText: 'Nombre de usuario',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    controller: uPController,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18)),
                  onPressed: postData,
                  child: const Text("Iniciar sesión"),
                ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //padding: const EdgeInsets.fromLTRB(250, 0, 0, 0),
                              elevation: 0.00,
                              primary: Colors.transparent,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontFamily: "Rubik-Light"),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: Colors.transparent))),
                          child: const Text(
                            'Regístrate aquí',
                            style: TextStyle(
                                color: Colors.lightBlue,
                                decoration: TextDecoration.underline),
                          ),
                          onPressed: () {
                            // _navigateToNextScreen(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterUser()),);
                          }),

               ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //padding: const EdgeInsets.fromLTRB(250, 0, 0, 0),
                            elevation: 0.00,
                            primary: Colors.transparent,
                            textStyle: const TextStyle(
                                fontSize: 20, fontFamily: "Rubik-Light"),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.transparent))),
                        child: const Text(
                          'Eres una protectora?',
                          style: TextStyle(
                              color: Colors.lightBlue,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          // _navigateToNextScreen(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterShelter()),);
                        }),
                   ],
                 ),
              ],
            )),
      ),
    );
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
