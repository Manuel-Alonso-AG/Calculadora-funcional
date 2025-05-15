import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:popover/popover.dart';


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
  String result = '';

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

  removeLast() {
    setState(() {
      label = label.substring(0, label.length - 1);
    });
  }


  TextFormField textField = TextFormField();

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
            width: 420,
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      textField,
                      Text(result)
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                GestureDetector(
                  child: Text(
                    'Trigonometry',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => showPopover(
                    context: context,
                    bodyBuilder: (context) => Container(
                      width: 300,
                      height: 400,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Text('Trigonometry'),
                          Expanded(
                            child: Text('A'),
                          ),
                        ],
                      ),
                    ),
                    onPop: () => print('Popover was popped!'),
                    direction: PopoverDirection.bottom,
                    width: 350,
                    height: 400,
                  ),
                ),
                const SizedBox(height: 20),
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
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('sh'),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('alp'),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Icon(Icons.keyboard_arrow_up),
          ),
        ),
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
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Icon(Icons.keyboard_arrow_left),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(),
        ),
      ],
    );
  }

  
  StaggeredGrid trigonometryCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => updateLabel('^'),
            child: const Text('^'),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('1/x'),
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
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('+/-'),
          ),
        ),
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('hyp'),
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
        )
      ],
    );
  }



  StaggeredGrid normalCalculator() {
    return StaggeredGrid.count(
      crossAxisCount: 5,
      mainAxisSpacing: 4,
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
            onPressed: () => clearLabel(),
            child: const Text('CE'),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: () => removeLast(),
            child: const Icon(Icons.backspace),
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
        const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: FilledButton(
            onPressed: null,
            child: Text('ANS'),
          ),
        ),
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
}
