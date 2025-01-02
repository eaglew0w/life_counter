import 'package:flutter/material.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/providers/providers.dart';
import 'package:life_counter/widgets/player.dart';
import 'package:life_counter/screens/body/life_counter_2_player.dart';

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
      home: LifeCounter2Player(
        title: 'MTG Life Counter',
        player1: Player(
            playerProvider: playerProviderList[Players.player1.index],
            playerPosition: PlayerPosition.left),
        player2: Player(
            playerProvider: playerProviderList[Players.player2.index],
            playerPosition: PlayerPosition.right),
      ),
    );
  }
}
