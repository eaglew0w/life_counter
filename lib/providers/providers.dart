import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/models/player_state.dart';
import 'package:life_counter/notifiers/background_notifier.dart';
import 'package:life_counter/notifiers/player_state_notifier.dart';

final backgroundProvider =
    NotifierProvider<BackgroundNotifier, BackgroundState>(
        BackgroundNotifier.new);

final playerProviderList = List.generate(
  playerNumber,
  (index) => NotifierProvider<PlayerStateNotifier, PlayerState>(
      PlayerStateNotifier.new),
);
