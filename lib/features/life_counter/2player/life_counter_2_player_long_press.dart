import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/life_counter/base_screen/life_counter_scaffold.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button_long_press.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

class LifeCounter2PlayerLongPress extends ConsumerWidget {
  const LifeCounter2PlayerLongPress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LifeCounterScaffold(
      resettableNotifiers: [
        ...List.generate(
          2,
          (index) => ref.read(playerProviderList[index].notifier),
        ),
        ref.read(themeModeStateProvider.notifier),
      ],
      themeModeProvider: themeModeStateProvider,
      body: Row(
        children: [
          Expanded(
            child: _buildPlayer(ref, Players.player1, PlayerPosition.left),
          ),
          Expanded(
            child: _buildPlayer(ref, Players.player2, PlayerPosition.right),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer(WidgetRef ref, Players player, PlayerPosition position) {
    final provider = playerProviderList[player.index];
    return Player(
      playerProvider: provider,
      playerPosition: position,
      loseButton: LifeChangeButtonLongPress(
        text: lifeLoseText,
        onPressed: () => ref.read(provider.notifier).changeLife(lifeLoseOnTap),
        onLongPress: () =>
            ref.read(provider.notifier).changeLife(lifeLoseOnLongPress),
        textColor: lifeLoseButtonTextColor,
      ),
      gainButton: LifeChangeButtonLongPress(
        text: lifeGainText,
        onPressed: () => ref.read(provider.notifier).changeLife(lifeGainOnTap),
        onLongPress: () =>
            ref.read(provider.notifier).changeLife(lifeGainOnLongPress),
        textColor: lifeGainButtonTextColor,
      ),
    );
  }
}
