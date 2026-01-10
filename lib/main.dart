import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double firstNumber = 0;
  String operation = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        display = '0';
        firstNumber = 0;
        operation = '';
      } else if (value == '+' ||
          value == '-' ||
          value == '×' ||
          value == '÷') {
        firstNumber = double.parse(display);
        operation = value;
        display = '0';
      } else if (value == '=') {
        double secondNumber = double.parse(display);
        double result = 0;

        switch (operation) {
          case '+':
            result = firstNumber + secondNumber;
            break;
          case '-':
            result = firstNumber - secondNumber;
            break;
          case '×':
            result = firstNumber * secondNumber;
            break;
          case '÷':
            result = firstNumber / secondNumber;
            break;
        }

        display = result.toString();
      } else {
        if (display == '0') {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  Widget buildButton(String text,
      {Color color = Colors.grey, Color textColor = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 26, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              display,
              style: const TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          Row(
            children: [
              buildButton('AC', color: Colors.grey),
              buildButton('+/-', color: Colors.grey),
              buildButton('%', color: Colors.grey),
              buildButton('÷', color: Colors.orange, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('×', color: Colors.orange, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('-', color: Colors.orange, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('+', color: Colors.orange, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 2, child: buildButton('0')),
              buildButton('.'),
              buildButton('=', color: Colors.orange, textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
