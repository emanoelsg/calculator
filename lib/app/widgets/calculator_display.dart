// app/widgets/calculator_display.dart
import 'package:flutter/material.dart';

/// A widget that shows the current value of the calculator display.
/// 
/// [text] is the string to show on the display. It will automatically
/// truncate if it’s too long.
class CalculatorDisplay extends StatelessWidget {
  final String text;

  const CalculatorDisplay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('calculator-display'), // used for widget tests
      padding: const EdgeInsets.all(20), // spacing around the text
      alignment: Alignment.centerRight, // text aligned to the right
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // text color
          fontSize: 60,        // large font for visibility
        ),
        maxLines: 1,           // prevent wrapping
        overflow: TextOverflow.ellipsis, // truncate long numbers
      ),
    );
  }
}
