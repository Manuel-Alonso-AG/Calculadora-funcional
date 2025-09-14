import 'package:calculadora/controller/operation_provider.dart';
import 'package:calculadora/view/constants/constants_colors.dart';
import 'package:calculadora/view/constants/constatns_sizes.dart';
import 'package:calculadora/view/widgets/calculator_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: ConstatsSizes.borderRadius,
        color: const Color.fromARGB(255, 206, 216, 233),
      ),
      height: double.minPositive,
      margin: ConstatsSizes.separationSpace,
      padding: ConstatsSizes.separationSpace,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CalculatorTextField(),
          Text(
            context.watch<OperationsProvider>().currentOperationText,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 22,
                color: ConstatsColors.onPrimary,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
