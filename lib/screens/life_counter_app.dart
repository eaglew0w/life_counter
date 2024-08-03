import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/providers/background_provider.dart';
import 'package:life_counter/providers/life_notifier.dart';
import 'package:life_counter/widgets/player.dart';

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

class LifeCounter extends ConsumerWidget {
  const LifeCounter({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColorDefault,
      appBar: AppBar(
        backgroundColor: backgroundColorDefault,
        title: Text(
          title,
          style: const TextStyle(color: textColorDefault),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Player(playerProvider: player1Provider),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(player1Provider.notifier).reset(defaultLife);
                    ref.read(player2Provider.notifier).reset(defaultLife);
                  },
                  child: const Icon(Icons.handshake_outlined),
                ),
                Expanded(
                  child: Player(playerProvider: player2Provider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
