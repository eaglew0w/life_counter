import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MTG Life Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int player1Life = 20;
  int player2Life = 20;

  void _gainlifePlayer1() {
    setState(() {
      player1Life++;
    });
  }

  void _loselifePlayer1() {
    setState(() {
      player1Life--;
    });
  }

  void _gainlifePlayer2() {
    setState(() {
      player2Life++;
    });
  }

  void _loselifePlayer2() {
    setState(() {
      player2Life--;
    });
  }

  void _resetLife() {
    setState(() {
      player1Life = 20;
      player2Life = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: _resetLife,
            tooltip: 'Reset',
            child: const Icon(Icons.handshake_outlined),
          ),
        ],
      ),
      body: Stack (
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  child: Text(
                    '$player1Life',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(
                  width:200,
                  child: Text(
                    '$player2Life',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _gainlifePlayer1,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('+1'),
                ),
                ElevatedButton(
                  onPressed: _loselifePlayer1,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('-1'),
                ),
                ElevatedButton(
                  onPressed: _gainlifePlayer2,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('+1')
                ),
                ElevatedButton(
                  onPressed: _loselifePlayer2,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('-1')
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
