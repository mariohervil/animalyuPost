import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_in_flutter/src/app_colors.dart';
import 'dart:math' as math;

void main() {
  runApp(ProfileDesign());
}

class ProfileDesign extends StatefulWidget {
  @override
  State<ProfileDesign> createState() => _ProfileDesignState();
}

class _ProfileDesignState extends State<ProfileDesign> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile',
      home: Profile(),
      debugShowCheckedModeBanner: false,
    );
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  Future<ui.Image> loadImage() async {
    final imageBytes = await rootBundle.load('assets/texture.jpg');
    return decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  static late ui.Image image;

  void foto() async {
    image = await loadImage();
    sleep(Duration(days: 0, hours: 0, minutes: 0, seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    foto();
    return ClipPath(
      clipper: CClipper(),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/animalyuTexture.jpg"),
                opacity: 0.5,
                fit: BoxFit.cover),
              boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ]),
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      color: AppColors.marronOscuro,
                      onPressed: () {},
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: AppColors.marronOscuro,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      color: AppColors.marronOscuro,
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              width: 200,
                              height: 250,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Stack(
                                children: [
                                  Container(
                                    color: AppColors.animalyuIcon,
                                  ),
                                  ClipPath(
                                    clipper: CustomClipPath(),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            opacity: 0.1,
                                            fit: BoxFit.fill,
                                            image: AssetImage("assets/a.jpeg"),
                                          )),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Nombre",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(30, 0, 0, 0)),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://images3.memedroid.com/images/UPLOADED753/618f10769197d.jpeg"))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(280, 0, 0, 0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Transform.rotate(
                            angle: (math.pi * 0.055),
                            child: Container(
                              width: 110,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 350);
}

class CClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);
    p.lineTo(size.width, 0);

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  //Size size= const Size(double.infinity, 100);
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 34);
    p.lineTo(size.width, size.height);
    p.lineTo(size.width, 0);
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
