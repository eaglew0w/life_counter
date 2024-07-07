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
  final GlobalKey<_PlayerState> keyPlayer1 = GlobalKey<_PlayerState>();
  final GlobalKey<_PlayerState> keyPlayer2 = GlobalKey<_PlayerState>();
  void _resetLife() {
    setState(() {
      keyPlayer1.currentState?.resetLife(20);
      keyPlayer2.currentState?.resetLife(20);
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
            Player(key: keyPlayer1),
            ElevatedButton(
              onPressed: _resetLife,
              child: const Icon(Icons.handshake_outlined),
            ),
            Player(key: keyPlayer2),
          ],
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int life = 20;

  void _gainLife() {
    setState(() {
      life++;
    });
  }

  void _loseLife() {
    setState(() {
      life--;
    });
  }

  // 外部から初期化する用
  void resetLife(int defaultlife) {
    setState(() => life = defaultlife);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: _gainLife,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  shadowColor: Colors.transparent,
                ),
                child: const Text('+1'),
              ),
              ElevatedButton(
                onPressed: _loseLife,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  shadowColor: Colors.transparent,
                ),
                child: const Text('-1'),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '$life',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}