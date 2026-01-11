import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
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
  bool shouldResetDisplay = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        display = '0';
        operation = '';
        firstNumber = 0;
        shouldResetDisplay = false;
      } else if (value == '+/-') {
        if (display != '0' && display != 'Error') {
          display = display.startsWith('-')
              ? display.substring(1)
              : '-$display';
        }
      } else if (value == '%') {
        try {
          display = (double.parse(display) / 100).toString();
        } catch (_) {
          display = 'Error';
        }
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        try {
          firstNumber = double.parse(display);
          operation = value;
          shouldResetDisplay = true;
        } catch (_) {
          display = 'Error';
        }
      } else if (value == '=') {
        try {
          final secondNumber = double.parse(display);
          double result;

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
              if (secondNumber == 0) {
                display = 'Error';
                return;
              }
              result = firstNumber / secondNumber;
              break;
            default:
              return;
          }

          display = result.toString();
          operation = '';
          shouldResetDisplay = true;
        } catch (_) {
          display = 'Error';
        }
      } else {
        if (shouldResetDisplay || display == '0' || display == 'Error') {
          display = value;
          shouldResetDisplay = false;
        } else {
          if (value == '.' && display.contains('.')) return;
          display += value;
        }
      }
    });
  }

  Widget glassButton(String text,
      {bool isOperator = false, bool isWide = false}) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: InkWell(
              onTap: () => onButtonPressed(text),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.15),
                  border: Border.all(
                    color: isOperator ? Colors.orangeAccent : Colors.white24,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isOperator
                          ? const Color.fromRGBO(255, 152, 0, 0.6)
                          : const Color.fromRGBO(68, 138, 255, 0.4),
                      blurRadius: 15,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 26,
                      color:
                      isOperator ? Colors.orangeAccent : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: const TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Row(children: [
              glassButton('AC'),
              glassButton('+/-'),
              glassButton('%'),
              glassButton('÷', isOperator: true),
            ]),
            Row(children: [
              glassButton('7'),
              glassButton('8'),
              glassButton('9'),
              glassButton('×', isOperator: true),
            ]),
            Row(children: [
              glassButton('4'),
              glassButton('5'),
              glassButton('6'),
              glassButton('-', isOperator: true),
            ]),
            Row(children: [
              glassButton('1'),
              glassButton('2'),
              glassButton('3'),
              glassButton('+', isOperator: true),
            ]),
            Row(children: [
              glassButton('0', isWide: true),
              glassButton('.'),
              glassButton('=', isOperator: true),
            ]),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
