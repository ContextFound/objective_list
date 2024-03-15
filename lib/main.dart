import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ObjectiveListApp());
}

class ObjectiveListApp extends StatelessWidget {
  const ObjectiveListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Objective List',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],

        // Add a theme color constant for Card color - dark grey
        cardColor: Colors.grey[700],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

        // Define the default AppBar theme.
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[900], // Dark color for AppBar
          elevation: 0,
        ),
      ),
      home: const HomePage(), // Replace with your app's home page widget
    );
  }
}
