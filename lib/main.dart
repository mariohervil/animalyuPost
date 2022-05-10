import 'dart:convert';
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
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";

  //final String url = "animalyu.monlau-smx.com";
  final String unencodedPath = "/test/php/login.php";
  final Map<String, String> headers = {'Content-type': 'application/json'};
  final Map<String, String> body = {
    'username': 'animalyu',
    'password': 'Monlau2022@',
  'email': 'admin@gmail.com', 'phone':'93374638'
  };

  Future<http.Response> makePostRequest(String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body.toString());
    return response;
  }

  void postData() async {
    makePostRequest(url, body);
  }

  @override
  void initState() {
    makePostRequest(url, body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: postData,
            child: const Text("Send Post"),
          ),
          // ElevatedButton
        ),
        // Center
      ),
      // Scaffold
    ); // MaterialApp
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
