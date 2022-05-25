import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import '../../util/page_directory.dart';
import 'package:url_launcher/url_launcher.dart';

class infoShelterPageState extends StatefulWidget {
  const infoShelterPageState({Key? key}) : super(key: key);

  @override
  State<infoShelterPageState> createState() => _infoShelterPageState();
}

class _infoShelterPageState extends State<infoShelterPageState> {
  late SuccessfulTransactionParameters transactionArguments;
  late var number;

  @override
  Widget build(BuildContext context) {
    transactionArguments = ModalRoute.of(context)!.settings.arguments
        as SuccessfulTransactionParameters;
    number = transactionArguments.phone;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("name : ${transactionArguments.name}"),
                onPressed: () => print("a"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("ID : ${transactionArguments.id}"),
                onPressed: () => print("a"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("Address : ${transactionArguments.address}"),
                onPressed: () => print("a"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("Donate"),
                onPressed: () => _PayPage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("Adopt"),
                onPressed: () => _AdoptPage(),
              ),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 27),
                children: [
                  TextSpan(
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      //make link blue and underline
                      text: "number phone: ${transactionArguments.phone}",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          launch('tel://$number');
                        }),
                  //more text paragraph, sentences here.
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                child: Text("exit"),
                onPressed: () => _MapPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _PayPage() async {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.payPage, (Route<dynamic> route) => false,
        arguments: transactionArguments);
  }

  Future<void> _AdoptPage() async {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.adoptPage, (Route<dynamic> route) => false,
        arguments: transactionArguments);
  }

  Future<void> _MapPage() async {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.mapPage, (Route<dynamic> route) => false,
        arguments: transactionArguments);
  }
}
