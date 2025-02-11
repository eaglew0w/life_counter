import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class PlayerStateNotifier extends Notifier<PlayerState>
    implements ResettableNotifier {

  Timer? _lifeChangeTimer;

  @override
  PlayerState build() {
    ref.onDispose(() {});
    return PlayerState(life: defaultLife);
  }

  void changeLife(int value) {
    state = state.copyWith(
      life: state.life + value,
      lifeChange: state.lifeChange + value,
    );
    _restartTimer();
  }

  @override
  void reset() {
    _lifeChangeTimer?.cancel();
    state = PlayerState(life: defaultLife);
  }

  void _restartTimer() {
    _lifeChangeTimer?.cancel();
    _lifeChangeTimer =
        Timer(const Duration(seconds: lifeChangeDisplayTimer), () {
      state = state.copyWith(lifeChange: 0);
    });
  }
}
