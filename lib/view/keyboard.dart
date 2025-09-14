import 'package:calculadora/controller/operation_provider.dart';
import 'package:calculadora/utils/math_token_helper.dart';
import 'package:calculadora/view/constants/constants_colors.dart';
import 'package:calculadora/view/constants/constatns_sizes.dart';
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
    "DE",
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
    "≡",
    "0",
    ".",
    "=",
  ];

  final List<String> actionsList = ["()", ")", "1/x", "±", "π", "e", "φ", "x!"];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: ConstatsSizes.spaceBetween,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: buttonsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            final String char = buttonsList[index];
            return CustomButton(
              text: char,
              color: _colorButton(char, index),
              colorText: _colorTextButton(char, index),
              action: () {
                _handleButtonPress(char);
              },
            );
          },
        ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: ConstatsSizes.displayWidth,
          padding: ConstatsSizes.separationSpace,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actionsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              final String charAction = actionsList[index];
              return CustomButton(
                text: charAction,
                color: ConstatsColors.secundary,
                colorText: Colors.white,
                action: () {
                  Navigator.of(context).pop();
                  _handleAdditionalAction(charAction);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _handleButtonPress(String char) {
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
    } else if (char == "≡") {
      _showBottomSheet();
    }
  }

  void _handleAdditionalAction(String action) {
    switch (action) {
      case "()":
        context.read<OperationsProvider>().parenthesis();
        break;
      case ")":
        context.read<OperationsProvider>().addElement(')');
        break;
      case "1/x":
        context.read<OperationsProvider>().oneOnX();
        break;
      case "±":
        context.read<OperationsProvider>().changeSing();
        break;
    }
  }

  Color _colorButton(String char, int idx) {
    if (idx < 2) {
      return ConstatsColors.onPrimary;
    }
    if (MathTokenHelper.isOperation(char) || char == '=') {
      return ConstatsColors.primary;
    }
    return ConstatsColors.light;
  }

  Color _colorTextButton(String char, int idx) {
    if (MathTokenHelper.isOperation(char) || char == '=' || idx < 2) {
      return Colors.white;
    }
    return ConstatsColors.onPrimary;
  }
}
