import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button_flick.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

class PlayerFlick extends Player {
  const PlayerFlick(
      {required super.playerProvider, super.playerPosition, super.key});

  @override
  Widget leftButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButtonFlick(
        text: ChangeLifeInfo.loseText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.loseOnTap),
        onFlickFunc: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.loseOnFlick),
        textColor: lifeChangeButtonColor,
      ),
    );
  }

  @override
  Widget rightButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButtonFlick(
        text: ChangeLifeInfo.gainText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.gainOnTap),
        onFlickFunc: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.gainOnFlick),
        textColor: lifeChangeButtonColor,
      ),
    );
  }
}
