// app/widgets/calculator_buttons.dart
import 'package:flutter/material.dart';

/// A reusable calculator button widget.
/// 
/// [text] is the label shown on the button.
/// [onPressed] is the callback triggered when the button is tapped.
/// [color] sets the button background color, defaulting to a dark gray.
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF333333), // default dark gray button
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // button color
        padding: const EdgeInsets.all(20), // internal padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // rounded corners
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28, 
          color: Colors.white, // text color
        ),
      ),
    );
  }
}
