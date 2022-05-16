import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

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
          decoration: const BoxDecoration(color: Colors.redAccent, boxShadow: [
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
                    icon: Icon(Icons.notifications),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(

                ),
              )
            ],
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 200);
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
