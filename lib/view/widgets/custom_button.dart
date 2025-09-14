import 'package:calculadora/view/constants/constatns_sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color colorText;
  final VoidCallback? action;

  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.colorText,
      this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
          padding: ConstatsSizes.spaceBetween,
          child: ClipRRect(
            borderRadius: ConstatsSizes.borderRadius,
            child: Container(
                color: color,
                child: Center(
                  child: Text(text,
                      style: TextStyle(
                          color: colorText,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                )),
          )),
    );
  }
}
