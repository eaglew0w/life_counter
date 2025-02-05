import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/life_counter/2player/life_counter_2_player.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/player/player.dart';
import 'package:life_counter/shared/widgets/player/player_flick.dart';

class LifeCounter2PlayerFlick extends LifeCounter2Player {
  const LifeCounter2PlayerFlick({super.key, required super.title});

  @override
  Player createPlayer(
      NotifierProvider<PlayerStateNotifier, PlayerState> playerProvider,
      PlayerPosition playerPosition) {
    return PlayerFlick(
        playerProvider: playerProvider, playerPosition: playerPosition);
  }
}
