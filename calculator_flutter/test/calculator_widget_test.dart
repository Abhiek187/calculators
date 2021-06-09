import 'package:calculator_flutter/main.dart';
import 'package:calculator_flutter/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension on WidgetTester {
  // Get the calculator output
  Text getOutput() {
    return this.firstWidget(
      find.descendant(of: find.byType(Container), matching: find.byType(Text)),
    );
  }

  // Tap the calculator buttons
  Future<void> tapButton(String text) {
    return this.tap(
      find.byWidgetPredicate(
          (widget) => widget is RoundButton && widget.text == text),
    );
  }
}

void main() {
  testWidgets('Test simple equation', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());
    await tester.pumpAndSettle();
    expect(tester.getOutput().data?.isEmpty, true);

    await tester.tapButton('2');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '2');

    await tester.tapButton('+');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '2 + ');

    await tester.tapButton('3');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '2 + 3');

    await tester.tapButton('=');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '5.0'); // on web, the result is 5
  });

  testWidgets('Test complex equation', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());
    await tester.pumpAndSettle();
    expect(tester.getOutput().data?.isEmpty, true);

    await tester.tapButton('(-)');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-');

    await tester.tapButton('0');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0');

    await tester.tapButton('.');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.');

    await tester.tapButton('1');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.1');

    await tester.tapButton('*');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.1 * ');

    await tester.tapButton('7');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.1 * 7');

    await tester.tapButton('=');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.7000000000000001');

    await tester.tapButton('/');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.7000000000000001 / ');

    await tester.tapButton('2');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.7000000000000001 / 2');

    await tester.tapButton('=');
    await tester.pumpAndSettle();
    expect(tester.getOutput().data, '-0.35000000000000003');
  });
}
