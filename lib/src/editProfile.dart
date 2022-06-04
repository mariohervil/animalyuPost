import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:google_maps_in_flutter/src/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_in_flutter/src/app_colors.dart';
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(EditProfileDesign());
}

class EditProfileDesign extends StatefulWidget {
  @override
  State<EditProfileDesign> createState() => _ProfileDesignState();
}


class _ProfileDesignState extends State<EditProfileDesign> {


  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";

  Future<User> FillUser(String id) async {
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

    return user;
  }








  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 869),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Profile',
            home: FutureBuilder(
              builder: (context, AsyncSnapshot<User> snapshot) {
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
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return EditProfile(snapshot.data as User);
                } else {
                  return Dialog(
                    backgroundColor: Colors.white,
                    alignment: Alignment.center,
                    child: Text("Connection Failed"),
                  );
                }
              },
              future: FillUser("1"),
            ),
            debugShowCheckedModeBanner: false,
          );
        });
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class EditProfile extends StatelessWidget {
  User user;
  static const USER_PHOTO = 1;
  static const ANIMAL_PHOTO = 2;
  EditProfile(this.user);

  TextEditingController _textController = TextEditingController();
  uploadPhoto(int action) async{

    const userImageUrl = "https://animalyu.monlau-smx.com/imgs/users";
    const animalImageUrl = "https://animalyu.monlau-smx.com/imgs/animals";
    if (action == USER_PHOTO) {
      FTPConnect ftpConnect = FTPConnect(userImageUrl,user:'admin2dam', pass:'Monlau2022@');
      File fileToUpload = File('fileToUpload.txt');
      await ftpConnect.connect();
      bool res = await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
      await ftpConnect.disconnect();
      print(res);
    }
    else if (action == ANIMAL_PHOTO) {
      FTPConnect ftpConnect = FTPConnect(animalImageUrl,user:'admin2dam', pass:'Monlau2022@');
      File fileToUpload = await _getFromGallery();
      await ftpConnect.connect();
      bool res = await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
      await ftpConnect.disconnect();
      print(res);
    }

  }

  Future<File> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    File imageFile = File("");
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
    return imageFile;
  }

  Future<File> _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    File imageFile = File("");
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
    return imageFile;
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/noteBack.jpg"), fit: BoxFit.fill)),
          child: ClipPath(
            clipper: CClipper(),
            child: Container(
              decoration: BoxDecoration(
                  //color: Colors.black
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent),
                                    child: Stack(
                                      children: [
                                        //TODO USER INFO
                                        Container(
                                          color: AppColors.animalyuIcon,
                                        ),
                                        ClipPath(
                                          clipper: CustomClipPath(),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  opacity: 0.1,
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      "assets/a.jpeg"),
                                                )),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 120, 0),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(20, 0, 20, 0),
                                                    child: TextField(
                                                      controller:
                                                          _nameController,
                                                      textAlign:
                                                          TextAlign.center,

                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  "Nombre",
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText:
                                                                  user.username,
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .marronOscuro,
                                                              )), // TextStyle // Input Decoration
                                                    ) // TextField
                                                    ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(20, 0, 20, 0),
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller:
                                                          _emailController,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  "Correo",
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: user.email,
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .marronOscuro,
                                                              )), // TextStyle // Input Decoration
                                                    ) // TextF
                                                    ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(20, 0, 20, 0),
                                                    child: TextField(
                                                      controller:
                                                          _phoneController,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  "Teléfono",
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: user.phone,
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .marronOscuro,
                                                              )), // TextStyle // Input Decoration
                                                    ) // TextF
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0)),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 0,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    "assets/cat.png"))),
                                      ),
                                      Positioned(
                                        left: 80,
                                        top: 80,
                                        bottom: 0,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 3,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor)),
                                          child: IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.white),
                                            onPressed: () {
                                              _displayDialog(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Container(
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
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    color: AppColors.marronClaro,
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.marronClaro,
                        blurRadius: 0,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: _buildTextField(),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                onPressed: () {
                  String text = _textController.text;
                  String name = _nameController.text;
                  String phone = _phoneController.text;
                  // TODO UPDATE AQUI


                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.green),
                  ),
                ),
                child: Text("Guardar")),
          ],
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Editar foto'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                _getFromCamera();
              },
              child: const Text('Hacer una foto'),
            ),
            SimpleDialogOption(
              onPressed: () {
                _getFromGallery();
              },
              child: const Text('Escoger de la galería'),
            ),
          ],
          elevation: 10,
          //backgroundColor: Colors.green,
        );
      },
    );
  }

  Widget _buildTextField() {
    final maxLines = 13;

    return Container(
      margin: EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextField(
        maxLines: maxLines,
      ),
    );
  }

  final url = "https://animalyu.monlau-smx.com/test/php/phpPruebaProj.php";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<ui.Image> loadImage() async {
    final imageBytes = await rootBundle.load('assets/texture.jpg');
    return decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  static late ui.Image image;

  void foto() async {
    image = await loadImage();
    sleep(Duration(days: 0, hours: 0, minutes: 0, seconds: 1));
  }

  Future<String> makePostRequest(String url, Map<String, String> body) async {
    HttpOverrides.global = MyHttpOverrides();
    final response = await http.post(Uri.parse(url), body: body);

    return response.body;
  }

  Future<User> FillUser(String id) async {
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

    return user;
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
