import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/utils/global_functions.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';

class Player extends ConsumerWidget {
  final NotifierProvider<PlayerStateNotifier, PlayerState> playerProvider;
  final PlayerPosition playerPosition;
  final Widget loseButton;
  final Widget gainButton;

  const Player({
    required this.playerProvider,
    required this.loseButton,
    required this.gainButton,
    this.playerPosition = PlayerPosition.none,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        _buildButtonLayer(context, ref),
        _buildLifeDisplay(context, ref),
        _buildLifeChangeDisplay(context, ref),
      ],
    );
  }

  Widget _buildButtonLayer(BuildContext context, WidgetRef ref) {
    final List<Widget> buttons = playerPosition == PlayerPosition.right
        ? [gainButton, loseButton]
        : [loseButton, gainButton];

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((b) => Expanded(child: b)).toList(),
      ),
    );
  }

  Widget _buildLifeDisplay(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    return Center(
      child: Text(
        '${playerState.life}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget _buildLifeChangeDisplay(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    return Align(
      alignment: const Alignment(
        alignmentXofPlayerLifeChange,
        alignmentYofPlayerLifeChange,
      ),
      child: Text(
        addAbsoluteValueText(playerState.lifeChange),
        textAlign: TextAlign.end,
      ),
    );
  }
}
