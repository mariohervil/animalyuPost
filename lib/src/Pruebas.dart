import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'Animal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: ElevatedButton(
              onPressed: Post,
              child: Text("ola"),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> makePostRequest(String url) async {
    HttpOverrides.global = MyHttpOverrides();
    Map<String, String> body = {
      'mode': 'selectAllAnimals',
    };
    final response = await http.post(Uri.parse(url), body: body);

    String a = '{"animal": [${response.body}]}';
    print(a);
    Map<String, dynamic> results =  json.decode(a);
    Animal animal = Animal.fromJson(results);
    print(animal.toString());
    return response;
  }

  void Post() async {
    makePostRequest(url);
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
