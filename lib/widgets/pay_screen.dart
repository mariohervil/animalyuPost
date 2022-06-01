import 'package:flutter/material.dart';

import '../src/app_colors.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: AppColors.marronOscuro,
                              onPressed: () {
                                Navigator.pop(
                                    context);
                              },
                            ),
                          ]
                      ),
                    ]
                )
            )
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sed mattis purus. Sed sed pellentesque mi. Phasellus blandit ornare fringilla. Integer vel odio tortor. Vestibulum euismod volutpat efficitur. Curabitur a urna a orci scelerisque cursus id ac magna. Maecenas eget dignissim magna. Donec vel aliquam lacus. Ut nec consectetur mauris.',
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: TextStyle(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
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
      ),
    );
  }
}
