import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player_state.dart';
import '../providers/life_notifier.dart';

class Player extends ConsumerWidget {
  final StateNotifierProvider<LifeNotifier, PlayerState> playerProvider;

  const Player({required this.playerProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final lifeNotifier = ref.read(playerProvider.notifier);

    return Stack(
      children: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => lifeNotifier.gainLife(1),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('+1'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => lifeNotifier.gainLife(-1),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('-1'),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '${playerState.life}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.2),
          child: Text(
            playerState.lifeChange == 0
                ? ''
                : playerState.lifeChange > 0
                    ? '+${playerState.lifeChange}'
                    : '${playerState.lifeChange}',
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}