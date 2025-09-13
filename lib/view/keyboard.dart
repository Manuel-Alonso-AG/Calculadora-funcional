import 'package:calculadora/controller/logic_buttons.dart';
import 'package:calculadora/utils/math_token_helper.dart';
import 'package:calculadora/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({super.key});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final List<String> buttonsList = [
    "AC",
    "()",
    "^",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "DE",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: buttonsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            final String char = buttonsList[index];
            return CustomButton(
              text: char,
              color: colorButton(char, index),
              colorText: colorTextButton(char, index),
              action: () {
                if (MathTokenHelper.isNumber(char) ||
                    MathTokenHelper.isOperation(char) ||
                    char == ".") {
                  context.read<OperationsProvider>().addElement(char);
                } else if (char == "=") {
                  context.read<OperationsProvider>().evaluateOperation();
                } else if (char == "AC") {
                  context.read<OperationsProvider>().clearOperation();
                } else if (char == "DE") {
                  context.read<OperationsProvider>().removeElement();
                }
              },
            );
          },
        ));
  }

  Color colorButton(String char, int idx) {
    if (idx == 0 || idx == 18) {
      return const Color.fromARGB(255, 93, 113, 149);
    }
    if (MathTokenHelper.isOperation(char) || char == '=') {
      return const Color.fromARGB(255, 54, 98, 175);
    }
    return const Color.fromARGB(255, 206, 216, 233);
  }

  Color colorTextButton(String char, int idx) {
    if (MathTokenHelper.isOperation(char) ||
        char == '=' ||
        idx == 0 ||
        idx == 18) {
      return Colors.white;
    }
    return const Color.fromARGB(255, 93, 113, 149);
  }
}
