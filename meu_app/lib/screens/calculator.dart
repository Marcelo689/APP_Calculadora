import "package:flutter/material.dart";
import 'package:meu_app/components/keyboard.dart';
import "../components/display.dart";

class Calculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Column(
        children: <Widget>[
          Display("120.50"),
          Keyboard(),
        ],)
    );
  }
}