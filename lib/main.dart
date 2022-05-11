import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    makePostRequest(url, registerBody);
  }

  void checkLogin(String response) {
    if (response == "1") {
      const CupertinoAlertDialog(
        title: Text("Accept?"),
        content: Text("Do you accept?"),
        actions: [
        ],
      );
    }
  }

  //@override
  //void initState() {
  //  makePostRequest(url, body);
  // }

  showAlertDialog(BuildContext context) async {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget build(BuildContext context) {
    username = uNController.text;
    password = uPController.text;

    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: postData,
              child: const Text("Send Post"),
            ),
            TextField(
                controller: uNController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    hintText: 'Enter Your Username')),
            TextField(
                controller: uPController,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    hintText: 'Enter Your Password'))
          ],
        )

            // ElevatedButton
            ),
        // Center
      ),
      // Scaffold
    ); // MaterialApp
  }
}

// set up the AlertDialog

// show the dialog

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
