import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/models/player_state.dart';
import 'package:life_counter/providers/life_notifier.dart';
import 'package:life_counter/widgets/life_change_button.dart';

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
                child: LifeChangeButton(
                  lifeNotifier: lifeNotifier,
                  changeValue: 1,
                  textColor: lifeChangeButtonColor,
                ),
              ),
              Expanded(
                child: LifeChangeButton(
                    lifeNotifier: lifeNotifier,
                    changeValue: -1,
                    textColor: lifeChangeButtonColor),
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
        )
      ],
    );
  }
}
