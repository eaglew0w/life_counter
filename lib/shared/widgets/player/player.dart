import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/utils/global_functions.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/player/counter_chip.dart';
import 'package:life_counter/shared/providers/providers.dart';

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
        _buildOverlayControls(context, ref),
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

  Widget _buildOverlayControls(BuildContext context, WidgetRef ref) {
    if (playerPosition == PlayerPosition.none) return const SizedBox.shrink();

    final playerState = ref.watch(playerProvider);
    final notifier = ref.read(playerProvider.notifier);
    final visibilityState = ref.watch(counterVisibilityStateProvider);

    // Determines alignment based on player position
    // P1 (Left): Poison: TopLeft, Speed: BottomLeft
    // P2 (Right): Poison: TopRight, Speed: BottomRight
    final bool isLeft = playerPosition == PlayerPosition.left;
    final Alignment poisonAlign =
        isLeft ? Alignment.topLeft : Alignment.topRight;
    final Alignment speedAlign =
        isLeft ? Alignment.bottomLeft : Alignment.bottomRight;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          if (visibilityState.isPoisonVisible)
            Align(
              alignment: poisonAlign,
              child: CounterChip(
                icon: Text(
                  'Φ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ), // Poison icon
                count: playerState.poison,
                onTap: () => notifier.changePoison(1),
                onLongPress: notifier.resetPoison,
              ),
            ),
          if (visibilityState.isSpeedVisible)
            Align(
              alignment: speedAlign,
              child: CounterChip(
                icon: const Icon(Icons.speed, size: 16, color: Colors.orange),
                count: playerState.speed,
                countColor: playerState.speed == 4 ? Colors.red : null,
                onTap: () => notifier.changeSpeed(1),
                onLongPress: notifier.resetSpeed,
              ),
            ),
        ],
      ),
    );
  }
}
