// app/pages/calculator_page.dart
import 'package:calculator/app/pages/desktop_page.dart';
import 'package:calculator/app/pages/mobile_page.dart';
import 'package:flutter/material.dart';

/// Main Calculator Page
/// This widget decides whether to show the **Mobile** or **Desktop** version
/// depending on the available screen width.
///
/// The displayText state is managed here so both layouts can share it.
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  /// Centralized state of the calculator display.
  /// This avoids duplicating logic between Mobile and Desktop pages.
  String displayText = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// AppBar is kept here to avoid duplicating it on both versions
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),

      /// LayoutBuilder allows us to detect the screen size
      /// and choose the appropriate UI (Mobile or Desktop).
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If width is less than 600 → show Mobile layout
          if (constraints.maxWidth < 600) {
            return CalculatorPageMobile(initialText: displayText);
          } 
          // Otherwise → show Desktop layout
          else {
            return CalculatorPageDesktop(initialText: displayText);
          }
        },
      ),
    );
  }
}
