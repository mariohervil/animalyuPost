import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_in_flutter/src/app_colors.dart';
import 'package:google_maps_in_flutter/src/shelter.dart';
import 'package:google_maps_in_flutter/src/transaction_id.dart';
import 'package:google_maps_in_flutter/src/user.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ShelterProfileDesign());
}

class ShelterProfileDesign extends StatefulWidget {
  const ShelterProfileDesign({Key? key}) : super(key: key);

  @override
  State<ShelterProfileDesign> createState() => _ShelterProfileDesignState();
}

class _ShelterProfileDesignState extends State<ShelterProfileDesign> {
  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  late TransactionID transactionArguments;

  Future<User> fillUser(String id) async {
    Map<String, String> loginBody = {
      'mode': 'selectUser',
      'user_id': id,
    };

    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: loginBody);

    var arr = response.body.split(", ");
    //sleep(Duration(seconds: 1));
    // print(response);

    User user = User(
        username: arr.elementAt(0),
        email: arr.elementAt(1),
        phone: arr.elementAt(2));
    //User user = User(email: email, phone: phone)

    return user;
  }

  Future<Shelter> fillShelter(String id) async {
    Map<String, String> select = {
      'mode': 'selectShelterbyID',
      'user_id': id,
    };

    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: select);

    var arr = response.body.split(", ");
    //sleep(Duration(seconds: 1));
    // print(response);

    Shelter shelter = Shelter(
        name: arr.elementAt(0),
        email: arr.elementAt(1),
        phone: arr.elementAt(2),
        address: arr.elementAt(3));
    //User user = User(email: email, phone: phone)

    return shelter;
  }

  Future<String> makePostRequest(String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    transactionArguments =
        ModalRoute.of(context)!.settings.arguments as TransactionID;
    final size = MediaQuery.of(context).size;
    String id = transactionArguments.id;
    return ScreenUtilInit(
        designSize: const Size(412, 869),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            home: FutureBuilder(
              builder: (context, AsyncSnapshot<Shelter> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/animalyuTexture.jpg",
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white54,
                                blurRadius: 0,
                                offset: Offset(0, 0))
                          ]),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Center(child: CircularProgressIndicator()),
                          Positioned(
                              bottom: 500.h,
                              left: 150.w,
                              child: Text(
                                "Cargando...",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none),
                              ))
                        ],
                      ));
                } else {
                  return ShelterProfile(snapshot.data as Shelter);
                }
              },
              future: fillShelter(id),
            ),
            title: 'Profile',
            // home: UserProfile(),
            debugShowCheckedModeBanner: false,
          );
        });
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}

class ShelterProfile extends StatelessWidget {
  ShelterProfile(this.shelter);

  Shelter shelter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(shelter),
      body: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/noteBack.jpg"), fit: BoxFit.fill),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0,
                offset: Offset(0, 0),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
          child: CustomPaint(
            foregroundPainter: LineBottomPainter(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 280, 27, 0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  Shelter shelter;

  CustomAppBar(this.shelter);

  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";

  Future<ui.Image> loadImage() async {
    final imageBytes = await rootBundle.load('assets/texture.jpg');
    return decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  static late ui.Image image;

  void foto() async {
    image = await loadImage();
    sleep(Duration(days: 0, hours: 0, minutes: 0, seconds: 1));
  }

  static late String nombre;
  static late String email;
  static late String phone;

  @override
  Widget build(BuildContext context) {
    //foto();
    //FillUser("1");
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/noteBack.jpg"), fit: BoxFit.fill)),
      child: ClipPath(
        clipper: CClipper(),
        child: Container(
          decoration: BoxDecoration(
              //color: Colors.black,
              //shape: AppBarBorder(),
              image: DecorationImage(
                  image: new AssetImage("assets/animalyuTexture.jpg"),
                  opacity: 0.5,
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 0,
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
                        icon: Icon(Icons.arrow_back),
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
                        icon: const Icon(Icons.menu),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              opacity: 0.1,
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage("assets/a.jpeg"),
                                            )),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 120, 0),
                                              child: CustomPaint(
                                                foregroundPainter:
                                                    LinePainter(),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Nombre",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .marronOscuro),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                shelter.name,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.marronOscuro),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Correo",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        AppColors.marronOscuro),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                shelter.email,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.marronOscuro),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Teléfono",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        AppColors.marronOscuro),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                shelter.phone,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.marronOscuro),
                                              ),
                                            ),
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
                                        image: AssetImage("assets/cat.png"))),
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
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Text(
                                    "Editar",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> makePostRequest(String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);

    return response.body;
  }

  void FillUser(String id) async {
    Map<String, String> loginBody = {
      'mode': 'selectUser',
      'user_id': id,
    };
    String response = await makePostRequest(url, loginBody);
    var arr = response.split(", ");
    nombre = await arr[0];
    email = await arr[1];
    phone = await arr[2];
    //sleep(Duration(seconds: 1));
    print(response);
  }

  void FillShelter(String id) async {
    Map<String, String> loginBody = {
      'mode': 'selectUser',
      'shelter_id': id,
    };
    makePostRequest(url, loginBody);
  }

  @override
  ui.Size get preferredSize => const ui.Size(double.infinity, 350);
}

class CClipper extends CustomClipper<Path> {
  @override
  Path getClip(ui.Size size) {
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

class CClipperLow extends CustomClipper<Path> {
  @override
  Path getClip(ui.Size size) {
    Path p = Path();
    p.lineTo(0, size.height);
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
  Path getClip(ui.Size size) {
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, ui.Size size) {
    size = ui.Size(183, 126);
    final paint = Paint()
      ..strokeWidth = 1
      ..color = AppColors.marronTranslucido
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(183, 263);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(183, 400);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LineBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, ui.Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..color = AppColors.marronOscuro
      ..strokeCap = StrokeCap.round;
    size = ui.Size(530, 126);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(530, 200);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(530, 274);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(530, 348);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(530, 422);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
    size = ui.Size(530, 496);
    canvas.drawLine(Offset(size.width * 4 / 6, size.height * 1 / 2),
        Offset(size.width * 0 / 6, size.height * 1 / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
