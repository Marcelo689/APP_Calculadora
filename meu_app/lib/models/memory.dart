import 'package:flutter/cupertino.dart';
import 'package:meu_app/functions/functions.dart';

class Memory {
  String _value = "0";
  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == "Calculate") {
      _value = calcularParte(_value);
      return;
    }
    if (command == "AC") {
      _value = "0";
      return;
    } else if (command == "Backspace") {
      if (_value.isNotEmpty && _value != "0") {
        _value = _value.substring(0, _value.length - 1);
      } else {
        _value = "0";
      }
      return;
    } else if (_value.indexOf("=") != -1) {
      if (command == "=") {
        return;
      }
    } else if ((!isNumeric(_value[_value.length - 1]) || command == "x") &&
        !isNumeric(command)) {
      return;
    }
    _value += command;
  }
}
