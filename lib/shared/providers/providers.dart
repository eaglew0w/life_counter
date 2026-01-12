import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/models/counter_visibility_state.dart';
import 'package:life_counter/shared/notifiers/counter_visibility_state_notifier.dart';

final playerProviderList = List.generate(
  playerNumber,
  (index) => NotifierProvider<PlayerStateNotifier, PlayerState>(
      PlayerStateNotifier.new),
);

final themeModeStateProvider =
    NotifierProvider<ThemeModeStateNotifier, ThemeModeState>(
        ThemeModeStateNotifier.new);

final counterVisibilityStateProvider =
    NotifierProvider<CounterVisibilityStateNotifier, CounterVisibilityState>(
        CounterVisibilityStateNotifier.new);
