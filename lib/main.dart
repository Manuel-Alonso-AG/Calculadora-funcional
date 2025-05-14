import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String label = '';

  updateLabel(String caracter) {
    setState(() {
      label += caracter;
    });
  }

  clearLabel() {
    setState(() {
      label = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[200],
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
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(label),
                ),

                const SizedBox(height: 10),
                aCalculator(),
                const SizedBox(height: 20),
                normalCalculator()
              
              ],
            ),
          )
        ),
      ),
    );
  }

  
  StaggeredGrid aCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('sh'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('alp'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('Menu'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Icon(Icons.keyboard_arrow_left),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('^'),
            child: const Text('^'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('1/x'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('√('),
            child: const Text('√'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('log('),
            child: const Text('log'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('ln('),
            child: const Text('ln'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('+/-'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('hyp'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('sin('),
            child: const Text('sin'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('cos('),
            child: const Text('cos'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('tan('),
            child: const Text('tan'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('('),
            child: const Text('('),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel(')'),
            child: const Text(')'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('sec('),
            child: const Text('sec'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('csc('),
            child: const Text('csc'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('cot('),
            child: const Text('cot'),
          ),
        ),
      ],
    );
  }

  StaggeredGrid normalCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 5,
      crossAxisSpacing: 4,

      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('7'),
            child: const Text('7'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('8'),
            child: const Text('8'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('9'),
            child: const Text('9'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('DEL'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => clearLabel(),
            child: const Text('AC'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('4'),
            child: const Text('4'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('5'),
            child: const Text('5'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('6'),
            child: const Text('6'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('*'),
            child: const Text('*'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('/'),
            child: const Text('/'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('1'),
            child: const Text('1'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('2'),
            child: const Text('2'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('3'),
            child: const Text('3'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('+'),
            child: const Text('+'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('-'),
            child: const Text('-'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('0'),
            child: const Text('0'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('.'),
            child: const Text('.'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('ANS'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: const Text('='),
          ),
        ),
      ],
    );
  }
}
