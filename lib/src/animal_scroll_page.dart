import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'animal.dart';
import 'package:kt_dart/kt.dart';

void main() => runApp(AnimalScroll());

class AnimalScroll extends StatefulWidget {
  const AnimalScroll({Key? key}) : super(key: key);

  @override
  State<AnimalScroll> createState() => _AnimalScrollState();
}

class _AnimalScrollState extends State<AnimalScroll> {
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  late List<Animals> list;
  final Map<String, String> body = {
    'mode': 'selectAllAnimals',
  };

  /* Future<Animal> receiveAnimal() async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    final animals = (response.body.replaceAll("][", ","));
    final List parsedList = json.decode(animals);
    List<Animal> list = parsedList.map((val) => Animal.fromJson(val)).toList();
    list.removeAt(0);

    return animalFromJson(animals);
  }*/

  Future<Animals> getAnimals() async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);
    final animals = (response.body.replaceAll("][", ","));
    //print(animals);
    final List parsedList = json.decode(animals);
    //var lista = mutableListFrom(parsedList["animals"]);

    List<Animal> list = parsedList.map((val) => Animal.fromJson(val)).toList();
    Map<String, Animal> mp = {};
    for (var item in list) {
      mp[item.name] = item;
    }
    var filteredList = mp.values.toList();
    Animals animal = Animals(animals: filteredList);
    //var distinct = list.distinctBy((it) => it["name"]);
    print(animals);
    return animal;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          builder: (context, AsyncSnapshot<Animals> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _AnimalsList(snapshot.data!.animals);
            }
          },
          future: getAnimals(),
        ));
  }
}

class _AnimalsList extends StatelessWidget {
  final List<Animal> animals;

  _AnimalsList(this.animals);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/animalyuTexture.jpg"),
              fit: BoxFit.cover,
              opacity: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.white54, blurRadius: 0, offset: Offset(0, 0))
            ]),
        //color: Colors.white,
        child: ListView.builder(
          itemCount: animals.length,
          itemBuilder: ((context, i) {
            return Card(
              borderOnForeground: true,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Ink.image(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1143&q=80'),
                        child: InkWell(
                          onTap: () {},
                        ),
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          bottom: 16,
                          right: 16,
                          left: 16,
                          child: Text(animals[i].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24))),
                    ],
                  ),
                  Text(
                      "- ${animals[i].animalType}\t- ${animals[i]
                          .raceName}\n- ${animals[i].birthdate}\t- ${animals[i]
                          .weight}kg",
                      style: TextStyle(
                        //fontFamily: "Rubik-Light",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ],
              ),
            );
          }),
        ));
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

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}


/*Future<Animal> getData() async {
  var animals= await makePostRequest(url); // not sure what your events data/method is
  for(Animal animal in animals){
  return animal;
  }

  }
  FutureBuilder(
  future: makePostRequest(url),
  builder: (context, snapshot) {
  List<Animal> animals = snapshot.data;
  if (!snapshot.hasData) return CircularProgressIndicator();
  return new ListView.builder(
  itemBuilder: (BuildContext context, int index) {  },
  itemCount:animals.length)
  }
*/

/**
 *
 * Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    for (Animal animal in list)
    ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
    return Card(child:Text(list[index].name));
    },
    ),
    ],
    );ç


 *
 */
