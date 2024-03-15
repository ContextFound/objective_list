import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class ObjectiveListApp extends StatelessWidget {
  const ObjectiveListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Objective List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
