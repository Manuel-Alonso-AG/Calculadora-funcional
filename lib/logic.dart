
import 'package:flutter/material.dart';

class OperationsProvider extends ChangeNotifier {
  String _operation = "";

  String get operation => _operation;

  void addElement(String element) {
    _operation += element;
    notifyListeners();
  }

  void removeElement() {
    if (_operation.isNotEmpty) {
      _operation = _operation.substring(0, _operation.length - 1);
    }
    notifyListeners();
  }

  void oneOnX(){
    if (_operation.isNotEmpty) {
      _operation = "1/($_operation)";
    }
    notifyListeners();
  }

  void changeSing() {
    if (_operation.isNotEmpty) {
      if (_operation[0] == '-') {
        _operation = _operation.substring(1);
      } else {
        _operation = "-$_operation";
      }
    }
    notifyListeners();
  }

  void clearOperation() {
    _operation = "";
    notifyListeners();
  }
}