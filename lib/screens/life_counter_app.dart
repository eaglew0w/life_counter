import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player_state.dart';
import '../widgets/player.dart';
import '../providers/life_notifier.dart';

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

final player1Provider =
    StateNotifierProvider<LifeNotifier, PlayerState>((ref) => LifeNotifier(20));
final player2Provider =
    StateNotifierProvider<LifeNotifier, PlayerState>((ref) => LifeNotifier(20));

class LifeCounter extends ConsumerWidget {
  const LifeCounter({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
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
                    ref.read(player1Provider.notifier).reset(20);
                    ref.read(player2Provider.notifier).reset(20);
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
