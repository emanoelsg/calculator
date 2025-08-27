// test/widget_test.dart
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculator widget test', (WidgetTester tester) async {
    // Inicializa o app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final displayFinder = find.byKey(const Key('calculator-display'));

    // Verifica se o display inicia com 0
    expect(displayFinder, findsOneWidget);
    expect(
      find.descendant(of: displayFinder, matching: find.text('0')),
      findsOneWidget,
    );

    // Clica em 2, +, 3, =
    await tester.tap(find.byKey(const Key('2')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('+')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('=')));
    await tester.pumpAndSettle();

    // Verifica se o resultado é 5
    expect(
      find.descendant(of: displayFinder, matching: find.text('5.0')),
      findsOneWidget,
    );

    // Testa limpar display
    await tester.tap(find.byKey(const Key('AC')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: displayFinder, matching: find.text('0')),
      findsOneWidget,
    );

    // Testa sinal negativo
    await tester.tap(find.byKey(const Key('7')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('+/-')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: displayFinder, matching: find.text('-7')),
      findsOneWidget,
    );

    // Testa apagar
    await tester.tap(find.byKey(const Key('delete')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: displayFinder, matching: find.text('0')),
      findsOneWidget,
    );
  });
}
