import 'player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LifeCounterApp());
}

class LifeCounterApp extends StatelessWidget {
  const LifeCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG Life Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LifeCounter(title: 'MTG Life Counter'),
    );
  }
}

class LifeCounter extends StatefulWidget {
  const LifeCounter({super.key, required this.title});

  final String title;

  @override
  State<LifeCounter> createState() => _LifeCounterState();
}

class _LifeCounterState extends State<LifeCounter> {
  final GlobalKey<PlayerState> player1Key = GlobalKey<PlayerState>();
  final GlobalKey<PlayerState> player2Key = GlobalKey<PlayerState>();
  final int defaultLife = 20;

  void _resetLife(int defaultLife) {
    setState(() {
      player1Key.currentState?.resetLife(defaultLife);
      player2Key.currentState?.resetLife(defaultLife);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: Player(key: player1Key),),
          ElevatedButton(
            onPressed: () {
              _resetLife(defaultLife);
            },
            child: const Icon(Icons.handshake_outlined),
          ),
          Expanded(child: Player(key: player2Key),),
        ],
      ),
    );
  }
}