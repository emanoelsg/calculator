// test/logic_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  String evaluateExpression(String expr) {
    try {
      if (expr.contains('/0')) return 'Erro';
      if (expr.contains('++') ||
          expr.contains('--') ||
          expr.contains('xx') ||
          expr.contains('//')) {
        return 'Erro';
      }

      final parser = ShuntingYardParser();
      final expression = parser.parse(expr.replaceAll('x', '*'));

      final evaluator = RealEvaluator();
      final result = evaluator.evaluate(expression);

      if (result.isInfinite || result.isNaN) return 'Erro';

      return result.toString();
    } catch (e) {
      return 'Erro';
    }
  }

  group('Calculator logic tests', () {
    test('Addition', () {
      expect(evaluateExpression('2+3'), '5.0');
    });

    test('Subtraction', () {
      expect(evaluateExpression('10-4'), '6.0');
    });

    test('Multiplication', () {
      expect(evaluateExpression('5x6'), '30.0');
    });

    test('Division', () {
      expect(evaluateExpression('12/4'), '3.0');
    });

    test('Division by zero', () {
      expect(evaluateExpression('5/0'), 'Erro');
    });

    test('Complex expression', () {
      expect(evaluateExpression('2+3x4-1'), '13.0'); // 2 + (3*4) - 1 = 13
    });

    test('Invalid expression', () {
      expect(evaluateExpression('2++2'), 'Erro');
    });
  });
}
