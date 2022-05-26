import 'package:flutter/material.dart';

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
      appBar: AppBar(),
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
              padding: EdgeInsetsGeometry.infinity,
              child: Row(
                children: [
                  for (final tag in tags) Chip(label: Text(tag)),
                ],
              ),
             ),

          ],
        ),
      ),
    );
  }
}
