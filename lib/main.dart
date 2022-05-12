import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        throw Exception("Username and Password Field are Empty");
      } else if (username == "") {
        throw Exception("Username Field is Empty");
      } else if (password == "") {
        throw Exception("Password Field is Empty");
      } else {
        Map<String, String> loginBody = {
          'mode': 'login',
          'username': username,
          'password': password
        };

        //print(username + " " + password);
        makePostRequest(url, loginBody);
      }
    } on Exception catch (e) {
      _messengerKey.currentState?.showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
    }
  }

  void checkLogin(String response) {
    //print(response);
    if (response == "1") {
      //ScaffoldMessenger()
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Logged In'), backgroundColor: Colors.green));
    } else {
      _messengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text('Incorrect username or password'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
//${uNController.text}
    return MaterialApp(
      theme: ThemeData(
          snackBarTheme: const SnackBarThemeData(
              contentTextStyle: TextStyle(fontFamily: "Rubik-Light"))),
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text("Log In Screen"),
            ),
            TextField(
                controller: uNController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    hintText: 'Enter Your Username')),
            TextField(
                controller: uPController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    hintText: 'Enter Your Password')),
            ElevatedButton(
              onPressed: postData,
              child: const Text("Log in"),
            ),
          ],
        )),
      ),
    );
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
