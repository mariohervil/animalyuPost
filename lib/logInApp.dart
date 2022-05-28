import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/src/registerShelter.dart';
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
  late bool _passwordVisible  = false;
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
      context,
      Routes.mapPage,
      (Route<dynamic> route) => false,
    );
  }

  void checkLogin(String response) {
    //print(response);
    if (response == "1") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Inicio de sesión correcto'),
          backgroundColor: Colors.green));
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
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 300,
          backgroundColor:Colors.grey,
          title: SvgPicture.asset(
          'assets/animalyuLogo.svg',
          width: 300,
          height: 300,
        ),
          centerTitle: true,
        ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    4.0,
                    4.0,
                  ),
                )
              ],
            ),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
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
                controller: uNController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                controller: uPController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: "Password",
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),),
              RaisedButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                onPressed: () {
                  postData();
                },
              ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),),
              FlatButton(
                child: Text("Don't have an account? Sign up here"),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterUser()),
                  );
                },
              ),
              FlatButton(
                child: Text("Centro de acogida? Sign up here"),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterShelter()),
                  );
                },
              ),
            ]),
          )

      )

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
