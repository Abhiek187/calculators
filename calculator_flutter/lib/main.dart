import 'package:flutter/material.dart';

import 'calculator.dart';

const String title = 'Flutter Calculator';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: Theme.of(context),
      home: Calculator(title: title),
    );
  }
}
