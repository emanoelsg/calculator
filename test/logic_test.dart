// test/logic_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';

/// A mock calculator logic class to test calculator functions
class CalculatorLogic {
  String displayText = '0';

  /// Resets display to "0"
  void clear() => displayText = '0';

  /// Deletes the last character or resets to "0" if only one character left
  void delete() {
    displayText = displayText.length > 1
        ? displayText.substring(0, displayText.length - 1)
        : '0';
  }

  /// Appends a character to the display
  /// Prevents duplicate operators or multiple decimal points
  void append(String value) {
    if ('+-x/'.contains(displayText[displayText.length - 1]) &&
        '+-x/'.contains(value)) {
      return;
    }
    if (value == '.' && displayText.contains('.')) return;

    displayText = displayText == '0' ? value : displayText + value;
  }

  /// Toggles the sign of the current number
  void toggleSign() {
    displayText = displayText.startsWith('-')
        ? displayText.substring(1)
        : '-$displayText';
  }

  /// Calculates the result using math_expressions
  void calculate() {
    try {
      if (displayText.contains('/0') ||
          displayText.contains('++') ||
          displayText.contains('--') ||
          displayText.contains('xx') ||
          displayText.contains('//')) {
        displayText = 'Erro';
        return;
      }

      final parser = ShuntingYardParser();
      final exp = parser.parse(displayText.replaceAll('x', '*'));
      final evaluator = RealEvaluator();
      final result = evaluator.evaluate(exp);

      if (result.isInfinite || result.isNaN) {
        displayText = 'Erro';
        return;
      }

      displayText = result.toString();
    } catch (_) {
      displayText = 'Erro';
    }
  }
}

void main() {
  group('CalculatorLogic unit tests', () {
    late CalculatorLogic calc;

    setUp(() {
      calc = CalculatorLogic();
    });

    test('Clear resets display to 0', () {
      calc.displayText = '123';
      calc.clear();
      expect(calc.displayText, '0');
    });

    test('Delete removes last character or resets to 0', () {
      calc.displayText = '123';
      calc.delete();
      expect(calc.displayText, '12');

      calc.displayText = '7';
      calc.delete();
      expect(calc.displayText, '0');
    });

    test('Append numbers and operators', () {
      calc.displayText = '0';
      calc.append('5');
      expect(calc.displayText, '5');

      calc.append('+');
      expect(calc.displayText, '5+');

      // Prevent duplicate operators
      calc.append('+');
      expect(calc.displayText, '5+');

      // Prevent multiple decimal points
      calc.displayText = '3.1';
      calc.append('.');
      expect(calc.displayText, '3.1');
    });

    test('Toggle sign', () {
      calc.displayText = '5';
      calc.toggleSign();
      expect(calc.displayText, '-5');

      calc.toggleSign();
      expect(calc.displayText, '5');
    });

    test('Calculate valid expressions', () {
      calc.displayText = '2+3';
      calc.calculate();
      expect(calc.displayText, '5.0');

      calc.displayText = '4x5';
      calc.calculate();
      expect(calc.displayText, '20.0');

      calc.displayText = '10/2';
      calc.calculate();
      expect(calc.displayText, '5.0');

      calc.displayText = '8-3';
      calc.calculate();
      expect(calc.displayText, '5.0');

      calc.displayText = '2+3x4-1';
      calc.calculate();
      expect(calc.displayText, '13.0');
    });

    test('Calculate invalid or error expressions', () {
      calc.displayText = '5/0';
      calc.calculate();
      expect(calc.displayText, 'Erro');

      calc.displayText = '2++2';
      calc.calculate();
      expect(calc.displayText, 'Erro');

      calc.displayText = '3xx3';
      calc.calculate();
      expect(calc.displayText, 'Erro');
    });
  });
}
