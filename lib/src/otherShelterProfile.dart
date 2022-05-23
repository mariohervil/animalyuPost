import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
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
      body: Container(
        width: 600,
        height: 400,
        decoration: BoxDecoration(image: DecorationImage(
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
              children: [Padding(
                padding: const EdgeInsets.fromLTRB(0, 280, 27, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(elevation: 10,
                    primary: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.white),
                    ),),

                  child: Text("Donar",
                    style: TextStyle(color: Colors.black),),

                ),
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
    foto();
    FillUser("1");
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
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width,
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
                                                nombre,
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
                                                email,
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
                                                phone,
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
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(elevation: 10,
                                      primary: Colors.white,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.white),
                                      ),),

                                  child: Text("Adoptar",
                                    style: TextStyle(color: Colors.black),),

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
    sleep(Duration(seconds: 1));
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

class AppBarBorder extends ShapeBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..lineTo(0, rect.size.height - 70)..lineTo(
          rect.size.width, rect.size.height)..lineTo(rect.size.width, 0);
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => ui.Path();

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
