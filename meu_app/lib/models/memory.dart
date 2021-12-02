import 'package:flutter/cupertino.dart';

class Memory {
  String _value = "0";

  String get value {
    return _value;
  }

  void applyCommand(String command) {
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
    }
    _value += command;
  }
}
