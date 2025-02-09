import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button_long_press.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

class PlayerLongPress extends Player {
  const PlayerLongPress(
      {required super.playerProvider, super.playerPosition, super.key});

  @override
  Widget leftButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButtonLongPress(
        text: ChangeLifeInfo.loseText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.loseOnTap),
        onLongPress: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.loseOnLongPress),
        textColor: lifeLoseButtonTextColor,
      ),
    );
  }

  @override
  Widget rightButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButtonLongPress(
        text: ChangeLifeInfo.gainText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.gainOnTap),
        onLongPress: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.gainOnLongPress),
        textColor: lifeGainButtonTextColor,
      ),
    );
  }
}
