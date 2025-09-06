import 'package:calculadora/backend/bulding_tree.dart';
import 'package:calculadora/backend/node_class.dart';
import 'package:flutter/material.dart';

class OperationsProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  String get operation => controller.text;

  void evaluateOperation() {
    if (controller.text.isEmpty) {
      return;
    }

    try {
      BuldingTree buldingtree = BuldingTree();
      Node? root = buldingtree.generateTree(controller.text);

      double result = buldingtree.evaluateTree(root);
      controller.text = result.toString();
      controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
    } catch (e) {
      controller.text = "Error";
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
            chars[i] = '+';
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
