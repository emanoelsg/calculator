// app/pages/mobile_page.dart
import 'package:calculator/app/widgets/calculator_buttons.dart';
import 'package:calculator/app/widgets/calculator_display.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

/// Mobile version of the calculator.
/// Layout is a Column:
/// - Top: display
/// - Bottom: buttons in a grid
class CalculatorPageMobile extends StatefulWidget {
  final String initialText;

  const CalculatorPageMobile({super.key, this.initialText = '0'});

  @override
  State<CalculatorPageMobile> createState() => _CalculatorPageMobileState();
}

class _CalculatorPageMobileState extends State<CalculatorPageMobile> {
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
      if (displayText.contains('/0')) {
        setState(() => displayText = 'Erro');
        return;
      }

      final parser = ShuntingYardParser();
      final exp = parser.parse(displayText.replaceAll('x', '*'));
      final evaluator = RealEvaluator();
      final result = evaluator.evaluate(exp);

      if (result.isInfinite || result.isNaN) {
        setState(() => displayText = 'Erro');
      } else {
        setState(() => displayText = result.toString());
      }
    } catch (_) {
      setState(() => displayText = 'Erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Button labels arranged in rows for grid layout
    final buttons = [
      ['AC', '+/-', '/', '⌫'],
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    // Flatten buttons to a single list for GridView
    final flatButtons = buttons.expand((e) => e).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Display section
          CalculatorDisplay(
            text: displayText,
            key: const Key('calculator-display'),
          ),
          const SizedBox(height: 10),

          // Buttons section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: flatButtons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final text = flatButtons[index];

                  // Assign callbacks based on button text
                  VoidCallback? onPressed;
                  Color color = Colors.grey[800]!; // default button color

                  switch (text) {
                    case 'AC':
                      onPressed = clear;
                      color = Colors.orange;
                      break;
                    case '+/-':
                      onPressed = toggleSign;
                      color = Colors.orange;
                      break;
                    case '/':
                    case 'x':
                    case '-':
                    case '+':
                    case '=':
                      onPressed = text == '=' ? calculate : () => append(text);
                      color = Colors.orange;
                      break;
                    case '⌫':
                      onPressed = delete;
                      color = Colors.orange;
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
