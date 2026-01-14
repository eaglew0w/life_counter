import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/life_counter/base_screen/life_counter_scaffold.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button_flick.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

class LifeCounter2PlayerFlick extends ConsumerWidget {
  const LifeCounter2PlayerFlick({super.key});

  static const int _playerCount = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LifeCounterScaffold(
      resettableNotifiers: [
        ...List.generate(
          _playerCount,
          (index) => ref.read(playerProviderList[index].notifier),
        ),
        ref.read(themeModeStateProvider.notifier),
      ],
      themeModeProvider: themeModeStateProvider,
      body: Row(
        children: List.generate(
          _playerCount,
          (index) => Expanded(
            child: _buildPlayer(
              ref,
              Players.values[index],
              index == 0 ? PlayerPosition.left : PlayerPosition.right,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer(WidgetRef ref, Players player, PlayerPosition position) {
    final provider = playerProviderList[player.index];
    return Player(
      playerProvider: provider,
      playerPosition: position,
      loseButton: LifeChangeButtonFlick(
        text: lifeLoseText,
        onPressed: () => ref.read(provider.notifier).changeLife(lifeLoseOnTap),
        onFlickFunc: () =>
            ref.read(provider.notifier).changeLife(lifeLoseOnFlick),
        textColor: lifeLoseButtonTextColor,
      ),
      gainButton: LifeChangeButtonFlick(
        text: lifeGainText,
        onPressed: () => ref.read(provider.notifier).changeLife(lifeGainOnTap),
        onFlickFunc: () =>
            ref.read(provider.notifier).changeLife(lifeGainOnFlick),
        textColor: lifeGainButtonTextColor,
      ),
    );
  }
}
