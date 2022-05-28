import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_in_flutter/src/app_colors.dart';
import 'dart:math' as math;

import 'animal.dart';

class AnimalScroll extends StatefulWidget {
  const AnimalScroll({Key? key}) : super(key: key);

  @override
  State<AnimalScroll> createState() => _AnimalScrollState();
}

class _AnimalScrollState extends State<AnimalScroll> {
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  var list = ["one", "two", "three", "four"];

  void FillAnimals(){


  }


  Future<List<String>> getAnimals() async {
    Map<String, String> body = {
      'mode': 'selectAnimals',
    };

    http.Response animalData = await makePostRequest(url, body);
    Map results =  json.decode(animalData.body);
    Animal animal = Animal.fromJson(results);
    List<String> animals = animalData.body.split(", ");
    for(String field in animals){


    }

  }

  Future<http.Response> makePostRequest(
      String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body);
    return response;
  }

  void postData() async {
    Map<String, String> registerBody = {
      'mode': 'selectAnimals',
    };
    makePostRequest(url, registerBody);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (var item in list)
          Row(
            children: [
              Card(child: Text("- $item\n\n")),
            ],
          )
      ],
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
