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
  double num1 = 0.0;
  String op = '';
  String numStr = '0';
  String output = '0';

  void clearOutput() {
    numStr = '0';
    num1 = 0.0;
    op = '';
  }

  void addNumber(String key) {
    // Replace a 0 with the number
    if (numStr == '0') {
      numStr = key;
    } else if (numStr == '-0') {
      numStr = '-$key';
    } else {
      numStr += key;
    }
  }

  void addDecimal() {
    // Don't add another decimal point if the number already contains one
    if (!numStr.contains('.')) {
      numStr += '.';
    }
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

  void backspace() {
    if (numStr.isNotEmpty) {
      numStr = numStr.substring(0, numStr.length - 1);

      if (numStr.isEmpty) {
        numStr = '0'; // show 0 when there's no text
      }
    } else if (op.isNotEmpty) {
      // Undo addOperator after deleting an operator
      numStr = num1.toString();
      num1 = 0.0;
      op = '';
    }
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

  // _ = private
  void _opButtonPressed(String key) {
    // Simplify the left side of the expression before chaining additional operators
    evaluate();

    double? num = double.tryParse(numStr);
    if (num != null) {
      setState(() {
        output = numStr;
        addOperator(key);
        output += " $key ";
      });
    }
  }

  void _numButtonPressed(String key) {
    addNumber(key);

    setState(() {
      if (output == '0') {
        output = key;
      } else if (output == '-0') {
        output = '-$key';
      } else {
        output += key;
      }
    });
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
                          _opButtonPressed('^');
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: 'π',
                        onPress: null,
                      ),
                      RoundButton(
                        color: Colors.red,
                        text: '↩',
                        onPress: () {
                          backspace();

                          if (output.isNotEmpty) {
                            setState(() {
                              if (output.characters.last == ' ') {
                                output = output.substring(0, output.length - 3);
                              } else {
                                output = output.substring(0, output.length - 1);
                              }

                              if (output.isEmpty) {
                                output = '0';
                              }
                            });
                          }
                        },
                      ),
                      RoundButton(
                        color: Colors.red,
                        text: 'clear',
                        onPress: () {
                          clearOutput();
                          setState(() => output = '0');
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
                          _opButtonPressed('%');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '/',
                        onPress: () {
                          _opButtonPressed('/');
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
                          _numButtonPressed('7');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '8',
                        onPress: () {
                          _numButtonPressed('8');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '9',
                        onPress: () {
                          _numButtonPressed('9');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '*',
                        onPress: () {
                          _opButtonPressed('*');
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
                          _numButtonPressed('4');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '5',
                        onPress: () {
                          _numButtonPressed('5');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '6',
                        onPress: () {
                          _numButtonPressed('6');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '-',
                        onPress: () {
                          _opButtonPressed('-');
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
                          _numButtonPressed('1');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '2',
                        onPress: () {
                          _numButtonPressed('2');
                        },
                      ),
                      RoundButton(
                        color: Colors.orange,
                        text: '3',
                        onPress: () {
                          _numButtonPressed('3');
                        },
                      ),
                      RoundButton(
                        color: Colors.green,
                        text: '+',
                        onPress: () {
                          _opButtonPressed('+');
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
                          _numButtonPressed('0');
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: '.',
                        onPress: () {
                          if (!numStr.contains('.')) {
                            addDecimal();
                            setState(() => output += '.');
                          }
                        },
                      ),
                      RoundButton(
                        color: Colors.black,
                        text: '(-)',
                        onPress: () {
                          invertNumber();
                          setState(() {
                            if (op.isNotEmpty) {
                              // Negate the right side of the expression
                              output = "$num1 $op $numStr";
                            } else {
                              output = numStr;
                            }
                          });
                        },
                      ),
                      RoundButton(
                        color: Colors.blue,
                        text: '=',
                        onPress: () {
                          evaluate();

                          if (numStr.isNotEmpty) {
                            setState(() => output = numStr);
                          }
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
