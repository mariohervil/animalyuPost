import 'dart:ui';

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
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CClipper(),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.darkBackground,
                  AppColors.background,
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {},
                ),
                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images3.memedroid.com/images/UPLOADED753/618f10769197d.jpeg"))),
            ),
            Text(
              "Nombre",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 100, 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Align(
                  child: Container(
                    child: Text(
                      "data",
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Align(
                    child: Transform.rotate(
                  angle: (math.pi * 0.055),
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 110,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 450);
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
