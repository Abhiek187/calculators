import 'package:calculator_flutter/calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

void main() {
  late var sut; // system under test

  setUp(() {
    sut = Calculator(title: '').createState();
  });

  group('AddNumber', () {
    test('with integers', () {
      sut.addNumber('7');
      sut.addNumber('2');
      sut.addNumber('9');

      expect(sut.numStr, '729');
    });

    test('with decimals', () {
      sut.addNumber('3');
      sut.addNumber('.');
      sut.addNumber('1');
      sut.addNumber('4');

      expect(sut.numStr, '3.14');
    });
  });

  group('AddOperator', () {
    test('with valid numbers', () {
      sut.addNumber('2');
      sut.addNumber('1');
      sut.addOperator('%');

      expect(sut.num1, closeTo(21.0, precisionErrorTolerance));
      expect(sut.op, '%');
      expect(sut.numStr.isEmpty, true);
    });

    test('with invalid numbers', () {
      sut.addOperator('+');

      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr.isEmpty, true);
    });
  });

  group('InvertNumber', () {
    test('empty', () {
      sut.invertNumber();

      expect(sut.numStr, '-');
    });

    test('once', () {
      sut.addNumber('5');
      sut.addNumber('4');
      sut.invertNumber();

      expect(sut.numStr, '-54');
    });

    test('twice', () {
      sut.addNumber('5');
      sut.invertNumber();
      sut.addNumber('4');
      sut.invertNumber();

      expect(sut.numStr, '54');
    });
  });

  group('Evaluate', () {
    test('valid add', () {
      sut.addNumber('2');
      sut.addOperator('+');
      sut.addNumber('3');
      sut.evaluate();

      expect(sut.num1, closeTo(5.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '5.0');
    });

    test('valid subtract', () {
      sut.addNumber('2');
      sut.addOperator('-');
      sut.addNumber('3');
      sut.evaluate();

      expect(sut.num1, closeTo(-1.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '-1.0');
    });

    test('valid multiply', () {
      sut.addNumber('2');
      sut.addOperator('*');
      sut.addNumber('3');
      sut.evaluate();

      expect(sut.num1, closeTo(6.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '6.0');
    });

    test('valid divide', () {
      sut.addNumber('2');
      sut.addOperator('/');
      sut.addNumber('3');
      sut.evaluate();
      double answer = 2 / 3;

      expect(sut.num1, closeTo(answer, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, answer.toString());
    });

    test('valid mod', () {
      sut.addNumber('2');
      sut.addOperator('%');
      sut.addNumber('3');
      sut.evaluate();

      expect(sut.num1, closeTo(2.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '2.0');
    });

    test('valid exp', () {
      sut.addNumber('2');
      sut.addOperator('^');
      sut.addNumber('3');
      sut.evaluate();

      expect(sut.num1, closeTo(8.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '8.0');
    });

    test('missing first num', () {
      sut.evaluate();

      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr.isEmpty, true);
    });

    test('missing operator', () {
      sut.addNumber('2');
      sut.evaluate();

      expect(sut.num1, closeTo(2.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
      expect(sut.numStr, '2.0');
    });

    test('missing second num', () {
      sut.addNumber('2');
      sut.addOperator('^');
      sut.evaluate();

      expect(sut.num1, closeTo(2.0, precisionErrorTolerance));
      expect(sut.op, '^');
      expect(sut.numStr.isEmpty, true);
    });
  });

  group('ClearOutput', () {
    test('empty', () {
      sut.clearOutput();

      expect(sut.numStr.isEmpty, true);
      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
    });

    test('after first num', () {
      sut.addNumber('6');
      sut.clearOutput();

      expect(sut.numStr.isEmpty, true);
      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
    });

    test('after operator', () {
      sut.addNumber('6');
      sut.addNumber('/');
      sut.clearOutput();

      expect(sut.numStr.isEmpty, true);
      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
    });

    test('after second num', () {
      sut.addNumber('6');
      sut.addOperator('/');
      sut.addNumber('6');
      sut.clearOutput();

      expect(sut.numStr.isEmpty, true);
      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
    });

    test('after evaluate', () {
      sut.addNumber('6');
      sut.addOperator('/');
      sut.addNumber('6');
      sut.evaluate();
      sut.clearOutput();

      expect(sut.numStr.isEmpty, true);
      expect(sut.num1, closeTo(0.0, precisionErrorTolerance));
      expect(sut.op.isEmpty, true);
    });
  });
}
