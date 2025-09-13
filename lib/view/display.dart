import 'package:calculadora/controller/logic_buttons.dart';
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
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 206, 216, 233),
      ),
      height: double.minPositive,
      margin: const EdgeInsets.only(top: 28),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: context.watch<OperationsProvider>().controller,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 35, color: Color.fromARGB(255, 93, 113, 149)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0',
            ),
          ),
          Text(
            context.watch<OperationsProvider>().currentOperationText,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 93, 113, 149),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
