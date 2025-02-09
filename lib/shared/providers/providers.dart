import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/background_state.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/background_notifier.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/notifiers/theme_mode_notifier.dart';

final backgroundProvider =
    NotifierProvider<BackgroundNotifier, BackgroundState>(
        BackgroundNotifier.new);

final playerProviderList = List.generate(
  playerNumber,
  (index) => NotifierProvider<PlayerStateNotifier, PlayerState>(
      PlayerStateNotifier.new),
);

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
