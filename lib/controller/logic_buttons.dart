import 'package:calculadora/controller/bulding_tree.dart';
import 'package:calculadora/controller/tree_calculator.dart';
import 'package:flutter/material.dart';

class OperationsProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  String currentOperationText = "";
  String get operation => controller.text;

  void evaluateOperation() {
    final String expression = controller.text;

    if (expression.isEmpty) {
      return;
    }

    final calculator = TreeCalculator();

    try {
      double result = calculator.evaluate(expression);

      currentOperationText = expression;
      controller.text = result.toString();
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    } catch (e) {
      currentOperationText = e.toString();
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    }
    notifyListeners();
  }

  void moveCursorLeft() {
    final selection = controller.selection;
    int pos = selection.isValid ? selection.baseOffset : controller.text.length;
    if (pos > 0) {
      controller.selection = TextSelection.collapsed(offset: pos - 1);
    }
    notifyListeners();
  }

  void moveCursorRight() {
    final selection = controller.selection;
    int pos = selection.isValid ? selection.baseOffset : controller.text.length;
    if (pos < controller.text.length) {
      controller.selection = TextSelection.collapsed(offset: pos + 1);
    }
    notifyListeners();
  }

  void addElement(String element) {
    final selection = controller.selection;
    final text = controller.text;

    int cursorPos = selection.isValid ? selection.baseOffset : text.length;

    final newText = text.replaceRange(cursorPos, cursorPos, element);

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPos + element.length),
    );

    notifyListeners();
  }

  void removeElement() {
    if (controller.text.isEmpty) {
      return;
    }

    final selection = controller.selection;
    final text = controller.text;

    int cursorPos = selection.isValid ? selection.baseOffset : text.length;

    if (cursorPos == 0) return;

    final newText = text.replaceRange(cursorPos - 1, cursorPos, '');

    controller.text = newText;
    controller.selection = TextSelection.collapsed(offset: cursorPos - 1);

    notifyListeners();
  }

  void parenthesis() {
    final selection = controller.selection;
    final text = controller.text;
    int cursorPos = selection.isValid ? selection.baseOffset : text.length;

    final newText = text.replaceRange(cursorPos, cursorPos, "()");
    controller.text = newText;
    controller.selection = TextSelection.collapsed(offset: cursorPos + 1);

    notifyListeners();
  }

  void oneOnX() {
    if (controller.text.isNotEmpty) {
      controller.text = "1/($operation)";
    }
    notifyListeners();
  }

  void changeSing() {
    String text = controller.text;

    if (text.isNotEmpty) {
      List<String> chars = text.split('');

      for (var i = 0; i < chars.length; i++) {
        String element = chars[i];

        switch (element) {
          case '+':
            chars[i] = '-';
            break;
          case '-':
            if (i > 0 && (isNumber(chars[i - 1]) || chars[i - 1] == ')')) {
              chars[i] = '+';
            } else {
              chars[i] = '';
            }
            break;
          case '*':
          case '/':
            if (chars.length - i > 1) {
              if (chars[i + 1] == '-') {
                chars[i + 1] = '';
              }
            }
            break;
          default:
            if (isNumber(element) || element == '(') {
              if (i > 0 && chars[i - 1] == '-') {
                chars[i - 1] = '+';
              } else if (i > 0 && chars[i - 1] == '+') {
                chars[i - 1] = '-';
              } else if (i == 0) {
                chars.insert(0, '-');
              } else {
                chars.insert(i, '-');
              }
            }
            break;
        }
      }

      if (text.startsWith('-')) {
        chars.removeAt(0);
      } else {
        chars.insert(0, '-');
      }

      controller.text = chars.join('');
    }
  }

  void clearOperation() {
    controller.text = "";
    notifyListeners();
  }
}
