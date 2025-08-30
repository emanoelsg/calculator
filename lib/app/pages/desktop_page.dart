// app/pages/desktop_page.dart
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calculator_buttons.dart';
import '../widgets/calculator_display.dart';

/// Desktop version of the calculator.
/// Layout is a horizontal Row:
/// - Left: bigger display
/// - Right: buttons in a grid
class CalculatorPageDesktop extends StatefulWidget {
  final String initialText;

  const CalculatorPageDesktop({super.key, this.initialText = '0'});

  @override
  State<CalculatorPageDesktop> createState() => _CalculatorPageDesktopState();
}

class _CalculatorPageDesktopState extends State<CalculatorPageDesktop> {
  late String displayText;

  @override
  void initState() {
    super.initState();
    displayText = widget.initialText; // Initialize display
  }

  /// Resets display to "0"
  void clear() => setState(() => displayText = '0');

  /// Deletes the last character or resets to "0" if only one char left
  void delete() {
    setState(() {
      displayText = displayText.length > 1
          ? displayText.substring(0, displayText.length - 1)
          : '0';
    });
  }

  /// Appends a character to the display
  /// Prevents duplicate operators or multiple decimal points
  void append(String value) {
    if ('+-x/'.contains(displayText[displayText.length - 1]) &&
        '+-x/'.contains(value)) {
      return;
    }

    if (value == '.' && displayText.contains('.')) return;

    setState(() {
      displayText = displayText == '0' ? value : displayText + value;
    });
  }

  /// Toggles the sign of the current number
  void toggleSign() {
    setState(() {
      displayText = displayText.startsWith('-')
          ? displayText.substring(1)
          : '-$displayText';
    });
  }

  /// Calculates the result using math_expressions
  void calculate() {
    try {
      if (displayText.contains('/0') ||
          displayText.contains('++') ||
          displayText.contains('--') ||
          displayText.contains('xx') ||
          displayText.contains('//')) {
        setState(() => displayText = 'Erro');
        return;
      }

      final parser = ShuntingYardParser();
      final exp = parser.parse(displayText.replaceAll('x', '*'));
      final evaluator = RealEvaluator();
      final result = evaluator.evaluate(exp);

      if (result.isInfinite || result.isNaN) {
        setState(() => displayText = 'Erro');
        return;
      }

      setState(() {
        displayText = result.toString();
      });
    } catch (_) {
      setState(() => displayText = 'Erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Button labels and keys for easier management
    final buttons = [
      ['AC', '+/-', '/', '⌫', 'x'],
      ['7', '8', '9', '-', '+'],
      ['4', '5', '6', '0', '.'],
      ['1', '2', '3', '=', ''],
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Display section - takes 2/5 of the width
          Expanded(
            flex: 2,
            child: Center(
              child: CalculatorDisplay(
                text: displayText,
                key: const Key('calculator-display'),
              ),
            ),
          ),

          // Buttons section - takes 3/5 of the width
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: buttons.expand((e) => e).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final flatList = buttons.expand((e) => e).toList();
                  final text = flatList[index];

                  // Assign callbacks based on button text
                  VoidCallback? onPressed;
                  Color color = Colors.grey[800]!; // default color

                  switch (text) {
                    case 'AC':
                      onPressed = clear;
                      break;
                    case '+/-':
                      onPressed = toggleSign;
                      break;
                    case '/':
                    case 'x':
                    case '-':
                    case '+':
                    case '=':
                      onPressed = text == '=' ? calculate : () => append(text);
                      break;
                    case '⌫':
                      onPressed = delete;
                      break;
                    default:
                      if (text.isNotEmpty) onPressed = () => append(text);
                  }

                  return CalculatorButton(
                    text: text,
                    onPressed: onPressed ?? () {},
                    color: color,
                    key: Key(text),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
