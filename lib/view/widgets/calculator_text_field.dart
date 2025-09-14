import 'package:calculadora/controller/operation_provider.dart';
import 'package:calculadora/view/constants/constants_colors.dart';
import 'package:calculadora/view/constants/constatns_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalculatorTextField extends StatefulWidget {
  const CalculatorTextField({super.key});

  @override
  State<CalculatorTextField> createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField>
    with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _cursorAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _cursorAnimation = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _cursorAnimation.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OperationsProvider>(
      builder:
          (BuildContext context, OperationsProvider provider, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (!_focusNode.hasFocus) {
              _focusNode.requestFocus();
            }
          },
          child: Container(
            padding: ConstatsSizes.spaceBetween,
            child: TextField(
              controller: provider.controller,
              focusNode: _focusNode,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ConstatsColors.primary),
              cursorColor: ConstatsColors.secundary,
              cursorWidth: 2.0,
              showCursor: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9+\-*/.()πeφ^√\s]'))
              ],
              onTap: () {
                if (!_focusNode.hasFocus) {
                  _focusNode.requestFocus();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
