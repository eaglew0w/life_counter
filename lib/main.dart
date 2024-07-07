import 'player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Player(key: player1Key),
            ElevatedButton(
              onPressed: () {
                _resetLife(defaultLife);
              },
              child: const Icon(Icons.handshake_outlined),
            ),
            Player(key: player2Key),
          ],
        ),
      ),
    );
  }
}