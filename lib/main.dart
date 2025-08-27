// main.dart
import 'package:calculator/app/pages/calculator_page.dart';
import 'package:flutter/material.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the app
/// Sets the theme, title, and home page
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      title: 'Flutter Calculator', // app title
      theme: ThemeData(
        brightness: Brightness.dark, // dark theme
        primarySwatch: Colors.orange, // primary color
      ),
      home: const CalculatorPage(), // main calculator page
    );
  }
}
