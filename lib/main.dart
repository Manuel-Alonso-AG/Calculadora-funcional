import 'package:calculadora/controller/operation_provider.dart';
import 'package:calculadora/view/constants/constants_colors.dart';
import 'package:calculadora/view/display.dart';
import 'package:calculadora/view/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OperationsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: ConstatsColors.onLight,
          body: const Center(
            child: SizedBox(
              width: 525,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Display()),
                  Expanded(flex: 2, child: Keyboard())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
