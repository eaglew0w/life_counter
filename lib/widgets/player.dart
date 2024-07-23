import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/global_functions.dart';
import '../models/player_state.dart';
import '../providers/life_notifier.dart';
import '../widgets/life_change_button.dart';

class Player extends ConsumerWidget {
  final StateNotifierProvider<LifeNotifier, PlayerState> playerProvider;

  const Player({required this.playerProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlayerState playerState = ref.watch(playerProvider);
    final LifeNotifier lifeNotifier = ref.read(playerProvider.notifier);

    return Stack(
      children: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: LifeChangeButton(lifeNotifier: lifeNotifier, changeValue: 1),
              ),
              Expanded(
                child: LifeChangeButton(lifeNotifier: lifeNotifier, changeValue: -1),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '${playerState.life}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.2),
          child: Text(
            addAbsoluteValueText(playerState.lifeChange),
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}