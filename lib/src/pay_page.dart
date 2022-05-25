import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/screens.dart';
import 'package:google_maps_in_flutter/src/page_arguments.dart';
import '../widgets/dismiss_focus_overlay.dart';



class payPageState extends StatefulWidget {
  const payPageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissFocusOverlay(
      child: MaterialApp(
        theme: exampleAppTheme,
        home: payPageState(),
        navigatorObservers: [],
      ),
    );
  }
  State<payPageState> createState() => _payPageState();
}

class _payPageState extends State<payPageState> {
  late SuccessfulTransactionParameters transactionArguments;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ...ListTile.divideTiles(
          context: context,
          tiles: [for (final example in Example.screens) example],
        ),
      ]),
    );
  }
}

final exampleAppTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xff6058F7),
    secondary: Color(0xff6058F7),
  ),
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(elevation: 1),
);

