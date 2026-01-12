import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/life_counter/base_screen/life_counter_scaffold.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

class LifeCounter2Player extends ConsumerWidget {
  const LifeCounter2Player({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LifeCounterScaffold(
      resettableNotifiers: [
        ref.read(playerProviderList[Players.player1.index].notifier),
        ref.read(playerProviderList[Players.player2.index].notifier),
        ref.read(playerProviderList[Players.player3.index].notifier),
        ref.read(playerProviderList[Players.player4.index].notifier),
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
      loseButton: LifeChangeButton(
        text: ChangeLifeInfo.loseText,
        onPressed: () =>
            ref.read(provider.notifier).changeLife(ChangeLifeInfo.loseOnTap),
        textColor: lifeLoseButtonTextColor,
      ),
      gainButton: LifeChangeButton(
        text: ChangeLifeInfo.gainText,
        onPressed: () =>
            ref.read(provider.notifier).changeLife(ChangeLifeInfo.gainOnTap),
        textColor: lifeGainButtonTextColor,
      ),
    );
  }
}
