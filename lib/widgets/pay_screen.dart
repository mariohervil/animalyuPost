
import 'package:flutter/material.dart';

import '../util/page_directory.dart';

class ExampleScaffold extends StatelessWidget {
  final List<Widget> children;
  final List<String> tags;
  final String title;
  final EdgeInsets? padding;
  const ExampleScaffold({
    Key? key,
    this.children = const [],
    this.tags = const [],
    this.title = '',
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            Padding(
              child: Text(title, style: Theme.of(context).textTheme.headline5),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 4),
            Padding(
              child: Row(
                children: [
              Padding(
              padding: const EdgeInsets.only(top: 14, left: 36, right: 36),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context, Routes.mapPage, (Route<dynamic> route) => false,
                  );
                  },
                child: Text("Proximamente"),
              ),
              )
                ]
              ),
              padding: EdgeInsets.symmetric(horizontal: 1),
            ),
          ],
        ),
      ),
    );
  }
}
