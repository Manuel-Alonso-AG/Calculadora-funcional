import 'package:calculadora/logic_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
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
        const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('DEG/RAD'),
          ),
        ),
        _disabledButton('hyp'),
        _trigButton(context, '^'),
        _trigButton(context, '√('),
        _actionButton(
            '1/x', (context) => context.read<OperationsProvider>().oneOnX()),
        _actionButton('+/-',
            (context) => context.read<OperationsProvider>().changeSing()),
        _trigButton(context, 'log('),
        _trigButton(context, 'ln('),
        _trigButton(context, 'sin('),
        _trigButton(context, 'cos('),
        _trigButton(context, 'tan('),
        _trigButton(context, 'sec('),
        _trigButton(context, 'csc('),
        _trigButton(context, 'cot('),
      ],
    );
  }

  static StaggeredGridTile _actionButton(
      String label, void Function(BuildContext) onPressed) {
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
        onPressed: null,
        //onPressed: () => context.read<OperationsProvider>().addElement(label),
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
              const Text('Operación', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: context.watch<OperationsProvider>().controller,
                cursorColor: Colors.black,
                autofocus: true,
                showCursor: true,
                // Como hago que se vea el cursor siempre?
                readOnly: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('.*')),
                ],
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 30),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '0',
                ),
              ),
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
            label: 'Avanzado',
            popoverContent: TrigonometryCalculatorGrid(),
          ),
        ),
        const SizedBox(height: 20),
        controlsCalculator(),
        const SizedBox(height: 20),
        normalCalculator(),
      ],
    );
  }

  static StaggeredGrid controlsCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        _disabledButton('sh'),
        _disabledButton('alp'),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
        _disabledButtonIcon(Icons.keyboard_arrow_up),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
        _actionButton(
            '(', (context) => context.read<OperationsProvider>().parenthesis()),
        _actionButton(')',
            (context) => context.read<OperationsProvider>().addElement(')')),
        _actionButton('<-',
            (context) => context.read<OperationsProvider>().moveCursorLeft()),
        _disabledButtonIcon(Icons.keyboard_arrow_down),
        _actionButton('->',
            (context) => context.read<OperationsProvider>().moveCursorRight()),
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
        _actionButton('CE',
            (context) => context.read<OperationsProvider>().clearOperation()),
        _iconButton(Icons.backspace,
            (context) => context.read<OperationsProvider>().removeElement()),
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
        _actionButton("=", (context) {
          context.read<OperationsProvider>().evaluateOperation();
        })
      ],
    );
  }

  static StaggeredGridTile _numberButton(String number) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Builder(
        builder: (context) => FilledButton(
          onPressed: () =>
              context.read<OperationsProvider>().addElement(number),
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

  static StaggeredGridTile _actionButton(
      String label, void Function(BuildContext) onPressed) {
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

  static StaggeredGridTile _iconButton(
      IconData icon, void Function(BuildContext) onPressed) {
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
