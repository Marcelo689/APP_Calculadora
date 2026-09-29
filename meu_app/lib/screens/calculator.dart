import 'package:flutter/material.dart';
import 'package:meu_app/components/keyboard.dart';
import 'package:meu_app/models/memory.dart';
import '../components/display.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  void _onPressed(String text) {
    setState(() {
      memory.applyCommand(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Display(memory.value),
            Keyboard(_onPressed),
          ],
        ),
      ),
    );
  }
}
