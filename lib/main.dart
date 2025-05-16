import 'package:calculadora/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OperationsProvider>(
          create: (_) => OperationsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: const CalculatorUX(),
            ),
          ),
        ),
      ),
    );
  }
}


@immutable
class PopoverButton extends StatelessWidget {
  final String label;
  final Widget popoverContent;

  const PopoverButton({
    super.key,
    required this.label,
    required this.popoverContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        direction: PopoverDirection.top,
        bodyBuilder: (context) => Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                popoverContent,
              ],
            ),
          ),
        ),
      ),
      child: Text(label),
    );
  }
}

class TrigonometryCalculatorGrid extends StatelessWidget {
  const TrigonometryCalculatorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        _trigButton(context, '^'),
        _actionButton('1/x', (context) => context.read<OperationsProvider>().oneOnX()),
        _trigButton(context, '√('),
        _trigButton(context, 'log('),
        _trigButton(context, 'ln('),
        _actionButton('+/-', (context) => context.read<OperationsProvider>().changeSing()),
        _disabledButton('hyp'),
        _trigButton(context, 'sin('),
        _trigButton(context, 'cos('),
        _trigButton(context, 'tan('),
        _trigButton(context, '('),
        _trigButton(context, ')'),
        _trigButton(context, 'sec('),
        _trigButton(context, 'csc('),
        _trigButton(context, 'cot('),
      ],
    );
  }

  static StaggeredGridTile _actionButton(String label, void Function(BuildContext) onPressed) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () => onPressed(context),
          child: Text(label),
        ),
      ),
    );
  }

  static StaggeredGridTile _trigButton(BuildContext context, String label) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: FilledButton(
        onPressed: () => context.read<OperationsProvider>().addElement(label),
        child: Text(label.replaceAll('(', '')),
      ),
    );
  }

  static StaggeredGridTile _disabledButton(String label) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: FilledButton(
        onPressed: null,
        child: Text(label),
      ),
    );
  }
}

class CalculatorUX extends StatefulWidget {
  const CalculatorUX({super.key});

  @override
  State<CalculatorUX> createState() => _CalculatorUXState();
}

class _CalculatorUXState extends State<CalculatorUX> {
  TextFormField textField = TextFormField();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              textField,
              Text(context.watch<OperationsProvider>().operation),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: const PopoverButton(
            label: 'Trigonometria',
            popoverContent: TrigonometryCalculatorGrid(),
          ),
        ),
        const SizedBox(height: 20),
        aCalculator(),
        const SizedBox(height: 20),
        normalCalculator(),
      ],
    );
  }

  static StaggeredGrid aCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        _disabledButton('sh'),
        _disabledButton('alp'),
        _disabledButtonIcon(Icons.keyboard_arrow_up),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('DEG/RAD'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
        _disabledButtonIcon(Icons.keyboard_arrow_left),
        _disabledButtonIcon(Icons.keyboard_arrow_down),
        _disabledButtonIcon(Icons.keyboard_arrow_right),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
      ],
    );
  }

  static StaggeredGridTile _disabledButton(String label) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: FilledButton(
        onPressed: null,
        child: Text(label),
      ),
    );
  }

  static StaggeredGridTile _disabledButtonIcon(IconData icon) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: FilledButton(
        onPressed: null,
        child: Icon(icon),
      ),
    );
  }

  static StaggeredGrid normalCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        _numberButton('7'),
        _numberButton('8'),
        _numberButton('9'),
        _actionButton('CE', (context) => context.read<OperationsProvider>().clearOperation()),
        _iconButton(Icons.backspace, (context) => context.read<OperationsProvider>().removeElement()),
        _numberButton('4'),
        _numberButton('5'),
        _numberButton('6'),
        _operatorButton('*'),
        _operatorButton('/'),
        _numberButton('1'),
        _numberButton('2'),
        _numberButton('3'),
        _operatorButton('+'),
        _operatorButton('-'),
        _numberButton('0'),
        _operatorButton('.'),
        _disabledButton('ANS'),
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('='),
          ),
        ),
      ],
    );
  }

  static StaggeredGridTile _numberButton(String number) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () => context.read<OperationsProvider>().addElement(number),
          child: Text(number),
        ),
      ),
    );
  }

  static StaggeredGridTile _operatorButton(String op) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () => context.read<OperationsProvider>().addElement(op),
          child: Text(op),
        ),
      ),
    );
  }

  static StaggeredGridTile _actionButton(String label, void Function(BuildContext) onPressed) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () => onPressed(context),
          child: Text(label),
        ),
      ),
    );
  }

  static StaggeredGridTile _iconButton(IconData icon, void Function(BuildContext) onPressed) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () => onPressed(context),
          child: Icon(icon),
        ),
      ),
    );
  }
}