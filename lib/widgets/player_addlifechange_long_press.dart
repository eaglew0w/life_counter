import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/models/player_state.dart';
import 'package:life_counter/providers/life_notifier.dart';
import 'package:life_counter/widgets/life_change_button_long_press.dart';
import 'package:life_counter/widgets/player.dart';

class PlayerAddLifeChangeLongPress extends Player {
  const PlayerAddLifeChangeLongPress(
      {required super.playerProvider, super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: LifeChangeButtonLongPress(
                        text: ChangeLifeInfo.loseText,
                        onPressed: () =>
                            {lifeNotifier.gainLife(ChangeLifeInfo.loseOnTap)},
                        onLongPress: () => {
                          lifeNotifier.gainLife(ChangeLifeInfo.loseOnLongPress)
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: LifeChangeButtonLongPress(
                        text: ChangeLifeInfo.gainText,
                        onPressed: () =>
                            {lifeNotifier.gainLife(ChangeLifeInfo.gainOnTap)},
                        onLongPress: () =>
                            {lifeNotifier.gainLife(ChangeLifeInfo.gainOnFlick)},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '${playerState.life}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: textColorDefault),
          ),
        ),
        Align(
          alignment: const Alignment(
              alignmentXofPlayerLifeChange, alignmentYofPlayerLifeChange),
          child: Text(
            addAbsoluteValueText(playerState.lifeChange),
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: textColorDefault,
            ),
          ),
        ),
      ],
    );
  }
}
