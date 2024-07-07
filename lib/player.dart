import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => PlayerState();
}

class PlayerState extends State<Player> {
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