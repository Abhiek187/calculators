import 'dart:math';
import 'package:flutter/material.dart';
import 'round_button.dart';

class Calculator extends StatefulWidget {
  final String title;

  Calculator({required this.title});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double num1 = 0;
  String op = '';
  String numStr = '';
  String output = '';

  void clearOutput() {
    numStr = '';
    num1 = 0.0;
    op = '';
  }

  void addNumber(String key) {
    numStr += key;
  }

  void addOperator(String key) {
    if (double.tryParse(numStr) == null) return;

    num1 = double.parse(numStr);
    op = key;
    numStr = '';
  }

  void invertNumber() {
    numStr = numStr.startsWith('-') ? numStr.substring(1) : '-$numStr';
  }

  void evaluate() {
    double? num2 = double.tryParse(numStr);
    if (num2 == null) return;
    double result;

    switch (op) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      case '%':
        result = num1 % num2;
        break;
      case '^':
        result = pow(num1, num2) as double;
        break;
      default:
        result = num2;
    }

    num1 = result;
    numStr = result.toString();
    op = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Text(
                  output,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.black,
                        text: '^',
                        onPress: () {
                          addOperator('^');
                          setState(() => output += ' ^ ');
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: 'π',
                        onPress: null,
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: 'ln',
                        onPress: null,
                      ),
                      RoundButton(
                        color: Colors.red,
                        text: 'clear',
                        onPress: () {
                          clearOutput();
                          setState(() => output = '');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.black,
                        text: '(',
                        onPress: null,
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: ')',
                        onPress: null,
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '%',
                        onPress: () {
                          addOperator('%');
                          setState(() => output += ' % ');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '/',
                        onPress: () {
                          addOperator('/');
                          setState(() => output += ' / ');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.orange,
                        text: '7',
                        onPress: () {
                          addNumber('7');
                          setState(() => output += '7');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '8',
                        onPress: () {
                          addNumber('8');
                          setState(() => output += '8');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '9',
                        onPress: () {
                          addNumber('9');
                          setState(() => output += '9');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '*',
                        onPress: () {
                          addOperator('*');
                          setState(() => output += ' * ');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.orange,
                        text: '4',
                        onPress: () {
                          addNumber('4');
                          setState(() => output += '4');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '5',
                        onPress: () {
                          addNumber('5');
                          setState(() => output += '5');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '6',
                        onPress: () {
                          addNumber('6');
                          setState(() => output += '6');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '-',
                        onPress: () {
                          addOperator('-');
                          setState(() => output += ' - ');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.orange,
                        text: '1',
                        onPress: () {
                          addNumber('1');
                          setState(() => output += '1');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '2',
                        onPress: () {
                          addNumber('2');
                          setState(() => output += '2');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '3',
                        onPress: () {
                          addNumber('3');
                          setState(() => output += '3');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '+',
                        onPress: () {
                          addOperator('+');
                          setState(() => output += ' + ');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(
                        color: Colors.orange,
                        text: '0',
                        onPress: () {
                          addNumber('0');
                          setState(() => output += '0');
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: '.',
                        onPress: () {
                          addNumber('.');
                          setState(() => output += '.');
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: '(-)',
                        onPress: () {
                          invertNumber();
                          setState(() => output = numStr);
                        },
                      ),
                      RoundButton(
                        color: Colors.blue,
                        text: '=',
                        onPress: () {
                          evaluate();
                          setState(() => output = numStr);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
